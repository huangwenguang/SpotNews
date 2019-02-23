//
//  HomeViewController.m
//  imageZoom
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "JSBreakingNewsViewController.h"
#import "MsgAllObject.h"
#import "JSHomeHeaderView.h"
#import "JSHomeNavigationBarView.h"
#import "MsgObject.h"
#import "MsgDataObject.h"
#import "MsgSectionObject.h"
#import "LiveCell.h"
#define thumbnailImageHeigt 50.0f
#define LiveTopPadding  45.0f
#define kContentPadding 67 //内容距离2边的总和
static NSString *IDCONTENTLiveCell = @"CONTENTLiveCell";//文本
static NSString *IDDATALiveCell = @"DATALiveCell";//数据
@interface JSBreakingNewsViewController ()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

{
    
    CGFloat lastScale;
    CGPoint pointLeftTop;
    BOOL  isPushOpen;
    BOOL  isPushShock;
    NSDate *maxSectionTime;
    NSDate *minSectionTime;
    CGFloat lastPosition;
    UIFont *kFont;
    NSInteger  totalLiveCount;//限制1000条就不能加载更多
}
@property (nonatomic, strong) UIImageView *myView;
@end

@implementation JSBreakingNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor=[UIColor clearColor];
    self.newsSectionArray=[NSMutableArray array];
     [self tableViewInit];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketDidConncet) name:TSSOCKET_E_SOCKET_CONNECTED object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(receiveNewMessage:) name:TSSOCKET_P_RECEIVE_NEWS object:nil];

}

-(void)tableViewInit
{
    
    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBoundsTabbarFrame) style:UITableViewStylePlain];
    self.mytableview.rowHeight=129;
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mytableview.backgroundColor =[UIColor clearColor];
   // [self.mytableview registerClass:[LiveCell class] forCellReuseIdentifier:IDDATALiveCell];
    [self setExtraCellLineHidden:self.mytableview];
  
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;

   
    self.mytableview.mj_header=header;
    
    //self.mytableview.mj_header.state=MJRefreshStateRefreshing;
 // [MJRefreshStateHeader]
//    self.mytableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self refreshData];
//      //  [self.mytableview.mj_header endRefreshing];
//     
//    }];
        [self.view addSubview:self.mytableview];

//    self.mytableview.mj_header.automaticallyChangeAlpha = YES;
//    
//    self.mytableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
// 
//           // [self.mytableview.mj_footer endRefreshing];
//       
//    }];
 
    
}
-(void)viewDidLayoutSubviews {
    
    if ([self.mytableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mytableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.mytableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.mytableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark 接收信息
- (void)receiveNewMessage:(NSNotification *)notic {
    NSDictionary *dict=notic.userInfo[TSSOCKET_D_KEY_NEWSCONTENT];
   // NSLog(@"dict%@",dict);
    NSArray *tmp = [notic.userInfo[TSSOCKET_D_KEY_NEWSCONTENT] componentsSeparatedByString:@"#"];
   // NSLog(@"tmp%@",tmp);
    if ([tmp[0] isEqualToString:@"0"]) { // 快讯
        MsgObject *msg = [MsgObject messageWithArray:tmp];
        if ([msg.content length] == 0) { //如果为空，则不加载
            return;
        }
        [self insertNews:msg];
        [KGStatusBar showSuccessWithStatus:msg.content];
        //  [Util showStatusMessage:msg.content];
    }
    else if([tmp[0] isEqualToString:@"1"]){//data
        if (!tmp || tmp.count<12) {
            return;
        }
        MsgDataObject *data = [MsgDataObject dataWithArray:tmp];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCalendarByLive" object:data];
        [self insertNews:data];
         [KGStatusBar showSuccessWithStatus:data.name];
       

    }else if ([tmp[0] isEqualToString:@"2"]){//修改快讯
    NSString *tempNewstimespan=SAFE_STRING(tmp[1]);
    NSString *tempContent=SAFE_STRING(tmp[2]);
    NSMutableArray *tempnewsSectionArray=[self.newsSectionArray mutableCopy];
    for (NSInteger i=0; i<tempnewsSectionArray.count; i++) {
        MsgSectionObject *obj=tempnewsSectionArray[i];
        for (NSInteger j=0; j<obj.msgObjectList.count; j++) {
            MsgObject *object=obj.msgObjectList[j];
            if ([[object newstimespan] isEqualToString:tempNewstimespan]) {
                object.content=tempContent;
                MsgObject *newObject=object;
                [obj.msgObjectList replaceObjectAtIndex:j withObject:newObject];
                [tempnewsSectionArray replaceObjectAtIndex:i withObject:obj];
                break;
            }
        }
    }
    self.newsSectionArray=[tempnewsSectionArray mutableCopy];
    }
    [self changedNewsData];//改变数据
    [self.mytableview reloadData];
    
}
- (void)insertNews:(id)obj {
    
    if (!maxSectionTime) {
        maxSectionTime=[obj publictime];
    }
    if (!minSectionTime) {
        minSectionTime=[obj publictime];
    }
    if ([obj publictime]>maxSectionTime) {
        maxSectionTime=[obj publictime];
    }
    if ([obj publictime]<minSectionTime) {
        minSectionTime=[obj publictime];
    }
    
    MsgSectionObject *tempSection,*tempSectionCache;
    
    NSComparisonResult result1 = [[obj publictime] compare:minSectionTime];
    if (result1==NSOrderedAscending || result1 == NSOrderedSame){
        tempSection=[_newsSectionArray lastObject];
        tempSectionCache=[_newsSectionArray lastObject];
    }
    
    NSComparisonResult result2 = [[obj publictime] compare:maxSectionTime];
    if (result2==NSOrderedDescending || result2 == NSOrderedSame){
        tempSection=[_newsSectionArray firstObject];
        tempSectionCache=[_newsSectionArray firstObject];
    }
    
    
    MsgSectionObject *msgSection=[[MsgSectionObject alloc] init];
    msgSection.sectionTime=[obj publictime];
    if ([CommonUtils compareTimeData1:[obj publictime] date2:[tempSectionCache sectionTime]]==3) {//同一天
        BOOL isHave=NO;
        for (int i=0; i<tempSectionCache.msgObjectList.count; i++) {
            if ([obj isKindOfClass:[MsgDataObject class]] && [tempSection.msgObjectList[i] isKindOfClass:[MsgDataObject class]] && [[obj newstimespan] isEqualToString:[tempSection.msgObjectList[i] newstimespan]]) {
                isHave=YES;
                return;
            }
            if ([obj isKindOfClass:[MsgObject class]] && [tempSection.msgObjectList[i] isKindOfClass:[MsgObject class]] && ([[obj newstimespan] isEqualToString:[tempSection.msgObjectList[i] newstimespan]] || [(NSString*)[obj content] isEqualToString:(NSString*)[tempSection.msgObjectList[i] content]]) ) {
                isHave=YES;
                return;
            }
        }
        if (!isHave) {
            id firstObj=[tempSectionCache.msgObjectList firstObject];
            id lastObj=[tempSectionCache.msgObjectList lastObject];
            
            NSComparisonResult result1 = [[obj publictime] compare:[firstObj publictime]];
            if (result1==NSOrderedDescending || result1==NSOrderedSame ) {
                [tempSection.msgObjectList insertObject:obj atIndex:0];
                
            }
            NSComparisonResult result2 = [[obj publictime] compare:[lastObj publictime]];
            if (result2==NSOrderedAscending || result2==NSOrderedSame ) {
                [tempSection.msgObjectList addObject:obj];
                
            }
            return;
        }
        
    }else if([CommonUtils compareTimeData1:[obj publictime] date2:[tempSectionCache sectionTime]]==2){//小一天
        for (MsgSectionObject *objSection  in _newsSectionArray) {
            if ([CommonUtils compareTimeData1:[obj publictime] date2:[objSection sectionTime]]==3){
                return;
                
            }
        }
        [msgSection.msgObjectList addObject:obj];
        [_newsSectionArray addObject:msgSection];
        return;
    }
    for (MsgSectionObject *objSection  in _newsSectionArray) {
        if ([CommonUtils compareTimeData1:[obj publictime] date2:[objSection sectionTime]]==3){
            return;
            
        }
    }
    [msgSection.msgObjectList addObject:obj];
    [_newsSectionArray insertObject:msgSection atIndex:0];
    //    [_newsSectionArray addObject:msgSection];
}

-(void)changedNewsData{
   
}

#pragma mark 刷新数据
-(void)refreshData{
    totalLiveCount=0;
    [self getNewMessageWithAckBlock:0  count:50  block:^(NSDictionary *ack) {
                NSLog(@"成功");
       //[self.mytableview reloadData];
    } errorBlock:^{
    
    }];
}

#pragma mark 获取消息的回调
- (void)getNewMessageWithAckBlock:(NSInteger)type  count:(NSInteger)count  block:(void (^)(NSDictionary *))ack errorBlock:(void (^)())error {
    id maxTime =[[[[[_newsSectionArray lastObject] msgObjectList] lastObject] publictime] formatWithDefaultString];
    if (maxTime == nil) {
        maxTime = @0;
    }
    id sinceTime=[[[[[_newsSectionArray firstObject] msgObjectList] firstObject] publictime] formatWithDefaultString];
    if (sinceTime == nil) {
        sinceTime = @0;
    }
    if (type==1) {//加载更多  请求小时间
        sinceTime = @0;
    }else if (type==0){// 下拉 请求大的时间
        maxTime=@0;
        sinceTime=@0;
    }
    [[APISocket sharedSocket] sendEvent:TSSOCKET_P_GET_NEWS withData:@{@"since_time" :sinceTime, @"max_time" :maxTime, @"count" :[NSNumber numberWithInteger:count]} ackBlock:^(NSDictionary *ackDict) {
        self.templist = [MsgAllObject mj_objectArrayWithKeyValuesArray:ackDict[@"list"]];
        NSLog(@"templist%@",self.templist);
     
          [self.mytableview reloadData];
             [self.mytableview.mj_header endRefreshing];
         //totalLiveCount+=self.templist.count;
      
//        if (self.templist && self.templist.count!=0 && type==0) {
//            if (_newsSectionArray && _newsSectionArray.count>0) {
//                [_newsSectionArray removeAllObjects];
//            }
//            minSectionTime=maxSectionTime=nil;
        
            //            [Util showStatusMessage:KNotification_LiveMessage];
      //  }
       // [self.mytableview reloadData];
        //     [self UIAlert:ackDict];
      //  NSLog(@"ackDict%@",ackDict);
        
    }errorBlock:^{
        NSLog(@"错误");
    }];
    
    
}

#pragma mark socket连接
-(void)socketDidConncet{
     [self.mytableview.mj_header beginRefreshing];
  [self refreshData];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return self.newsSectionArray.count;
  return self.templist.count;
}
//指定有多少个分区(Section)，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //return [[self.newsSectionArray[section] msgObjectList] count];
    return 5;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
   
//     LiveCell *cell;
//
//            cell = [tableView dequeueReusableCellWithIdentifier:IDCONTENTLiveCell];
//            if (cell==nil) {
//                cell = [[LiveCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDCONTENTLiveCell tableView:tableView];
//                
//            }
    
    LiveCell *cell1;
           cell1 = [tableView dequeueReusableCellWithIdentifier:IDDATALiveCell];
            if (cell1==nil) {
                
                cell1 = [[LiveCell alloc] initWithDataStyle:UITableViewCellStyleDefault reuseIdentifier:IDDATALiveCell  tableView:tableView];
        }
    MsgAllObject *msgAllObject = self.templist[indexPath.row];
    
    
   // [cell setValue:msgAllObject];

  cell1.msgAllObject=msgAllObject;

    
    return cell1;
}
#pragma mark 返回每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // MsgAllObject *msgAllObject = self.templist[indexPath.row];
    return 129;
}
/**
 * 返回每一行的估计高度
 * 只要返回了估计高度，那么就会先调用tableView:cellForRowAtIndexPath:方法创建cell，再调用tableView:heightForRowAtIndexPath:方法获取cell的真实高度
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}
//    MsgSectionObject *obj=self.newsSectionArray[indexPath.section];
//    if ([obj.msgObjectList[indexPath.row] isKindOfClass:[MsgObject class]]) {//文本消息
//        MsgObject *msg=obj.msgObjectList[indexPath.row];
//        CGSize retSize = [msg.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kContentPadding,MAXFLOAT) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFont} context:NULL].size;
//
//        if (msg.imageurl && msg.imageurl.length!=0) {
//            return 10+17+10+retSize.height+10+thumbnailImageHeigt+12-(indexPath.row==0?LiveTopPadding:0);
//            //            return 10+17+10+retSize.height+10+thumbnailImageHeigt+10-(indexPath.row==0?35:0)>=35+thumbnailImageHeigt?10+retSize.height+10+thumbnailImageHeigt+10-(indexPath.row==0?35:0):35+thumbnailImageHeigt;
//        }
//        else
//        {
//            return 10+17+10+retSize.height+12-(indexPath.row==0?LiveTopPadding:0);
//            //            return 10+17+10+retSize.height+10-(indexPath.row==0?35:0)>=35?10+retSize.height+10-(indexPath.row==0?35:0):35;
//        }
//
//    }else if ([obj.msgObjectList[indexPath.row] isKindOfClass:[MsgDataObject class]]){//数据消息
//        MsgDataObject *msg=obj.msgObjectList[indexPath.row];
//        CGSize retSize = [msg.name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kContentPadding,MAXFLOAT) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFont} context:NULL].size;
//        return 10+17+10+retSize.height+10+40-(indexPath.row==0?LiveTopPadding:0);
//    }
//    return 0;
#pragma mark 自定义头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //MsgSectionObject *obj=self.newsSectionArray[section];
    MsgSectionObject *obj=nil;
    [[JSHomeHeaderView sharedInstance] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,40) msgSectionObject:obj];
    return [JSHomeHeaderView sharedInstance].view;
    
    
}

#pragma mark 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    // 释放内存
    self.mytableview=nil;
}



@end
