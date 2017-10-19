//
//  YGReadManager.h
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURRENT_BOOK_MODEL [YGReadManager sharedManager].bookModel
#define CURRENT_RECORD [YGReadManager sharedManager].bookModel.record

@protocol YGReadManagerDelegate;

@interface YGReadManager : NSObject

/// 资源路径
@property (nonatomic,strong) NSURL *resourceURL;

/// YGBookModel
@property (nonatomic,strong) YGBookModel *bookModel;

/// YGReadManagerDelegate
@property (nonatomic,weak) id<YGReadManagerDelegate> rmDelegate;

/**
 初始化单例
 
 @return YGReadManager
 */
+ (YGReadManager *)sharedManager;


/**
 获取阅读视图的bounds

 @return CGRect
 */
+ (CGRect)readViewBounds;


/**
 获取对应章节页码的readViewController

 @param chapter 章节
 @param page 页码
 @param pageUrl 页码对应的url
 @return YGReadViewController
 */
- (YGReadViewController *)readViewWithChapter:(NSInteger *)chapter page:(NSInteger *)page pageUrl:(NSString *)pageUrl;


/**
 跳转到指定章节（上一章，下一章，slider，目录）

 @param chapter 待跳转的指定章节
 @param page 对应页码
 */
- (void)readViewJumpToChapter:(NSInteger)chapter page:(NSInteger)page;


/**
 跳转到指定笔记，因为是笔记是基于位置查找的，使用page查找可能出错

 @param note YGNoteModel
 */
- (void)readViewJumpToNote:(YGNoteModel *)note;


/**
 跳转到指定书签，因为是书签是基于位置查找的，使用page查找可能出错

 @param mark YGMarkModel
 */
- (void)readViewJumpToMark:(YGMarkModel *)mark;

/**
 设置字体大小;

 @param plus BOOL值，是否增大
 */
- (void)configReadFontSize:(BOOL)plus;

/**
 设置字体

 @param fontName 带设置的字体名称
 */
- (void)configReadFontName:(NSString *)fontName;

/**
 设置阅读背景

 @param theme 待设置的阅读主题
 */
- (void)configReadTheme:(UIColor *)theme;

/**
 更新阅读记录

 @param chapter 待更新的章节
 @param page 对应页码
 */
- (void)updateReadModelWithChapter:(NSInteger)chapter page:(NSInteger)page;

/**
 关闭阅读器
 */
- (void)closeReadView;

/**
 添加或删除书签
 */
- (void)addBookMark;

/**
 添加笔记

 @param noteModel 待添加的笔记
 */
- (void)addNoteModel:(YGNoteModel *)noteModel;

@end

@protocol YGReadManagerDelegate <NSObject>

@optional

/**
 点击关闭按钮
 */
- (void)readViewDidClickCloseButton;

/**
 字体改变
 */
- (void)readViewFontDidChanged;

/**
 主题改变
 */
- (void)readViewThemeDidChanged;

/**
 翻页效果改变
 */
- (void)readViewEffectDidChanged;

/**
 添加笔记
 */
- (void)readViewDidAddNoteSuccess;

/**
 跳转章节

 @param chapter 待跳转的章节
 @param page 对应页数
 */
- (void)readViewJumpToChapter:(NSInteger)chapter page:(NSInteger)page;

/**
 更新阅读进度
 */
- (void)readViewDidUpdateReadRecord;

@end

