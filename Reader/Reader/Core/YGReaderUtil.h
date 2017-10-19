//
//  YGReaderUtil.h
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (YGReader)

/**
 *  获取当前可见ViewController
 *
 *  NS_EXTENSION_UNAVAILABLE_IOS
 *  标记iOS插件不能使用这些API,后面有一个参数，可以作为提示，用什么API替换
 */

+ (UIViewController *)xds_visiableViewController NS_EXTENSION_UNAVAILABLE_IOS("iOS插件不能使用这些API，请参考实现方法重新定义API");

@end

@interface YGReaderUtil : NSObject

+ (NSString *)encodeWithURL:(NSURL *)url;

+(UIButton *)commonButtonSEL:(SEL)sel target:(id)target;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
