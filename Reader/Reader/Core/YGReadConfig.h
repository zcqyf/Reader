//
//  YGReadConfig.h
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"

@interface YGReadConfig : YGRootModel

/// 缓存的字体大小
@property (nonatomic, readonly) CGFloat cachefontSize;

/// 缓存的字体名称
@property (nonatomic, readonly) NSString *cacheFontName;

/// 缓存的行距
@property (nonatomic, readonly) CGFloat cacheLineSpace;

/// 缓存的字体颜色
@property (nonatomic, readonly) UIColor *cacheTextColor;

/// 缓存的主题
@property (nonatomic, readonly) UIColor *cacheTheme;

/// 用于更新全部章节内容。当字体，字号，主题变化时，仅更新record章节内容而非全部章节
@property (nonatomic, assign) CGFloat currentFontSize;

@property (nonatomic, copy) NSString *currentFontName;

@property (nonatomic) CGFloat currentLineSpace;

@property (nonatomic,strong) UIColor *currentTextColor;

@property (nonatomic,strong) UIColor *currentTheme;


/**
 单例初始化

 @return YGReadConfig单例
 */
+ (instancetype)shareInstance;


/**
 如果config改变，我们需要重新加载所有的章节，并且重置config缓存

 @return 返回config是否改变
 */
- (BOOL)isReadConfigChanged;

@end
