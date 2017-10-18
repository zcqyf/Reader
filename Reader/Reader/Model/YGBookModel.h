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
@property (nonatomic, strong) YGBookInfoModel *bookBasicInfo;//书籍基本信息

/// 电子书文本内容
@property (nonatomic,strong) NSString *content;

/// 电子书类型(txt, epub)
@property (nonatomic,assign) YGEBookType bookType;

/// 章节   TODO 是否要设置 readonly;   chapterModel
@property (nonatomic,strong) NSArray *chapters;

/// 包含笔记的章节
@property (nonatomic,strong) NSArray *chapterContainNotes;

/// 包含书签的章节
@property (nonatomic,strong) NSArray *chapterContainMarks;

/// 阅读进度




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


+ (void)updateLocalModel:(YGBookModel *)bookModel url:(NSURL *)url;

+ (id)getLocalModelWithURL:(NSURL *)url;






















@end
