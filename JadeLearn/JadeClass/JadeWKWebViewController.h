//
//  JadeWKWebViewController.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "JadeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JadeWKWebViewController : JadeViewController

/** 标题 */
@property (nonatomic,strong) NSString* titleStr;
/**
 加载纯外部链接网页

 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 postData请求块 注意格式：@"\"username\":\"xxxx\",\"password\":\"xxxx\""
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;

@end

NS_ASSUME_NONNULL_END
