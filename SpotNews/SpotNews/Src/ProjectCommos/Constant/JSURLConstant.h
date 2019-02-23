//
//  URLConstant.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//


#define JSMobileServer_URL @"http://ms.jin10x.com/MobileServer.json"

#ifdef DEBUG
#define JSBASE_URL @"http://192.168.5.100:8080/jinshi10BG"  //外
#else
#define JSBASE_URL @"http://192.168.5.100:8080/jinshi10BG"  //外
#endif


//推送toke
#define SJURL_UPDATETOKEN [JSBASE_URL stringByAppendingString:@"updateToken"]

//设置标签
#define SJURL_SETTAG [JSBASE_URL stringByAppendingString:@"setTag"]
//更新地理位置
#define SJURL_UPDATEAREA [JSBASE_URL stringByAppendingString:@"updateArea"]
//绑定用户UID
#define SJURL_DEVICEUSERLOGIN [JSBASE_URL stringByAppendingString:@"deviceUserLogin"]
//解除绑定用户UID
#define SJURL_DEVICEUSERLOGOUT [JSBASE_URL stringByAppendingString:@"deviceUserLogout"]
