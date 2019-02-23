//
//  JSNewFeatureController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSNewFeatureController.h"
#import "JSNewFeatureCell.h"
#define JSGuidePageCount 4

@implementation JSNewFeatureController
static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[JSNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.array = [NSArray arrayWithArray:[self getGuidePageImageMethord:JSGuidePageCount]];
    // 添加guide
        [self setUpGuide];
    [self setUpGuideLine];

}
-(NSArray*)getGuidePageImageMethord:(NSInteger)pageNumber{
    
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    if (screenH > 480) { // 5 , 6 , 6 plus
        NSMutableArray * array =[NSMutableArray array];
        for (int i=1;i<=pageNumber;i++) {
            NSString * subString = [NSString stringWithFormat:@"GuidePage_640x1136_%ld",(long)i];
            [array addObject:subString];
        }
        return array;
    }else
    {
        NSMutableArray * array =[NSMutableArray array];
        for (int i=1;i<=pageNumber;i++) {
            NSString * subString = [NSString stringWithFormat:@"GuidePage_640x920_%ld",(long)i];
            [array addObject:subString];
        }
        return array;
    }

}

#pragma mark <UICollectionViewDataSource>
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat offsetGap = offsetX - _offsetX;

    _guideView.x += 2 * offsetGap;
    [UIView animateWithDuration:0.25 animations:^{
        
        _guideView.x -= offsetGap;

    }];

    int page = offsetX / self.view.width + 1;
    _guideView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",page]];
    _offsetX = offsetX;
}
- (void)setUpGuideLine
{
    UIImageView *guideLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    
    guideLine.x -= self.view.width * 0.47;
    
    [self.collectionView addSubview:guideLine];
    
}
// 添加guide
- (void)setUpGuide
{
    NSLog(@"name%@",self.array[0]);
    UIImageView *guideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    guideView.centerX = self.view.centerX;
    _guideView = guideView;
    
    [self.collectionView addSubview:guideView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   ;
    cell.image = [UIImage imageNamed:self.array[indexPath.row]];
    
    [cell setIndexPath:indexPath count:(int)self.array.count];
    
    return cell;
}

@end
