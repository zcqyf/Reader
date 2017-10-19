//
//  YGReadConfig.m
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGReadConfig.h"

@interface YGReadConfig ()

@property (nonatomic, assign) CGFloat cachefontSize;
@property (nonatomic, copy) NSString *cacheFontName;
@property (nonatomic) CGFloat cacheLineSpace;
@property (nonatomic,strong) UIColor *cacheTextColor;
@property (nonatomic,strong) UIColor *cacheTheme;

@end

@implementation YGReadConfig

NSString *const kReadConfigEncodeKey = @"ReadConfig";

//  TODO static YGReadConfig *readConfig 是否有问题？
+ (instancetype)shareInstance {
    static YGReadConfig *readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readConfig = [[self alloc] init];
    });
    return readConfig;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kReadConfigEncodeKey];
        if (data) {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            YGReadConfig *config = [unarchiver decodeObjectForKey:kReadConfigEncodeKey];
            return config;
        }
        self.cachefontSize = kXDSReadViewDefaultFontSize;
        self.cacheFontName = @"";
        self.cacheLineSpace = 10.0f;
        self.cacheTextColor = [UIColor blackColor];
        self.cacheTheme = [UIColor whiteColor];
        [YGReadConfig updateLocalConfig:self];
    }
    return self;
}

+ (void)updateLocalConfig:(YGReadConfig *)config{
    
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:config forKey:kReadConfigEncodeKey];
    [archiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kReadConfigEncodeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isReadConfigChanged {
    
    BOOL isReadConfigNotChanged = (_cachefontSize == _currentFontSize &&
                                   _cacheFontName == _currentFontName &&
                                   _cacheLineSpace == _currentLineSpace &&
                                   _cacheTextColor == _currentTextColor &&
                                   _cacheTheme == _currentTheme);
    if (!isReadConfigNotChanged)
    {
        _currentFontSize > 0 ? (_cachefontSize = _currentFontSize) : 0;
        _currentFontName ? (_cacheFontName = _currentFontName) : 0;
        _currentLineSpace > 0? (_cacheLineSpace = _currentLineSpace) : 0;
        _currentTextColor ? (_cacheTextColor = _currentTextColor) : 0;
        _currentTheme ? (_cacheTheme = _currentTheme) : 0;
        [YGReadConfig updateLocalConfig:self];
    }
    
    _currentFontSize = _cachefontSize;
    _currentFontName = _cacheFontName;
    _currentLineSpace = _cacheLineSpace;
    _currentTextColor = _cacheTextColor;
    _currentTheme = _cacheTheme;
    
    return !isReadConfigNotChanged;
}

- (BOOL)isEqual:(YGReadConfig *)config {
    
    return (self.cachefontSize == config.cachefontSize &&
            self.cacheFontName == config.cacheFontName &&
            self.cacheTextColor == config.cacheTextColor &&
            self.cacheLineSpace == config.cacheLineSpace &&
            self.cacheTheme == config.cacheTheme &&
            
            self.currentFontSize == config.currentFontSize &&
            self.currentFontName == config.currentFontName &&
            self.currentTextColor == config.currentTextColor &&
            self.currentLineSpace == config.currentLineSpace &&
            self.currentTheme == config.currentTheme);
}

@end
