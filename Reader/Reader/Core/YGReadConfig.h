//
//  YGReadConfig.h
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"

@interface YGReadConfig : YGRootModel

@property (nonatomic, readonly) CGFloat cachefontSize;
@property (nonatomic, readonly) NSString *cacheFontName;
@property (nonatomic, readonly) CGFloat cacheLineSpace;
@property (nonatomic, readonly) UIColor *cacheTextColor;
@property (nonatomic, readonly) UIColor *cacheTheme;


//用与更新全部章节内容。当字体，字号，主题变化时，仅更新record章节内容而非全部章节
@property (nonatomic, assign) CGFloat currentFontSize;
@property (nonatomic, copy) NSString *currentFontName;
@property (nonatomic) CGFloat currentLineSpace;
@property (nonatomic,strong) UIColor *currentTextColor;
@property (nonatomic,strong) UIColor *currentTheme;

+ (instancetype)shareInstance;

- (BOOL)isReadConfigChanged;//if config changed, we need to load content for all chapters, and reset cache config。

@end
