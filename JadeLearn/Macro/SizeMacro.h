//
//  SizeMacro.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/21.
//

#ifndef SizeMacro_h
#define SizeMacro_h


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone

/*获取顶部安全区高度*/
#define kSafeDistanceTop [UIDevice getSafeDistanceTop]
/*获取导航栏高度*/
#define kSafeDistanceBottm [UIDevice SafeDistanceBottm]
/*获取顶部状态栏高度 (包括安全区)*/
#define kStatusBarHeight [UIDevice getStatusBarHeight]
/*获取导航栏高度*/
#define kNavigationFullHeight [UIDevice getNavigationFullHeight]
/*获取状态栏 + 导航栏高度*/
#define kTabBarHeight [UIDevice getTabBarHeight]
/*获取底部导航栏高度 (包括安全区)*/
#define kTabBarFullHeight [UIDevice getTabBarFullHeight]
#endif /* SizeMacro_h */
