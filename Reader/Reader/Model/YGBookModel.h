//
//  YGBookModel.h
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"

typedef NS_ENUM(NSUInteger, YGEBookType) {
    YGEBookTypeTxt,
    YGEBookTypeEpub,
};

@interface YGBookModel : YGRootModel

/// 资源路径
@property (nonatomic,strong) NSURL *resource;

/// 书籍基本信息
@property (nonatomic, strong) YGBookInfoModel *bookBasicInfo;

/// 电子书文本内容
@property (nonatomic,strong) NSString *content;

/// 电子书类型(txt, epub)
@property (nonatomic,assign) YGEBookType bookType;

/// 章节   TODO 是否要设置 readonly;   chapterModel
@property (nonatomic,strong) NSArray<YGChapterModel *> *chapters;

/// 包含笔记的章节
@property (nonatomic,strong) NSArray<YGChapterModel *> *chapterContainNotes;

/// 包含书签的章节
@property (nonatomic,strong) NSArray<YGChapterModel *> *chapterContainMarks;

/// 阅读进度
@property (nonatomic,strong) YGRecordModel *record;



/**
 初始化

 @param content 内容字符串
 @return instancetype
 */
- (instancetype)initWithContent:(NSString *)content;

/**
 初始化

 @param ePubPath 文件路径
 @return instancetype
 */
- (instancetype)initWithePub:(NSString *)ePubPath;


/**
 更新本地的model

 @param bookModel YGBookModel
 @param url 提供路径
 */
+ (void)updateLocalModel:(YGBookModel *)bookModel url:(NSURL *)url;

/**
 获取资源并转化为model

 @param url 资源路径
 @return 返回model
 */
+ (id)getLocalModelWithURL:(NSURL *)url;

/**
 加载chapterModel的内容

 @param chapterModel YGChapterModel
 */
- (void)loadContentInChapter:(YGChapterModel *)chapterModel;

/**
 加载所有的章节
 */
- (void)loadContentForAllChapters;

/**
 删除对应note

 @param noteModel 待删除的YGNoteModel
 */
- (void)deleteNote:(YGNoteModel *)noteModel;

/**
 添加note

 @param noteModel 待添加的YGNoteModel
 */
- (void)addNote:(YGNoteModel *)noteModel;

/**
 删除mark

 @param markModel 待删除的YGMarkModel
 */
- (void)deleteMark:(YGMarkModel *)markModel;

/**
 添加mark

 @param markModel 待添加的YGMarkModel
 */
- (void)addMark:(YGMarkModel *)markModel;












@end
