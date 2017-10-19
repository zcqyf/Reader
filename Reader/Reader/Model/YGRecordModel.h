//
//  YGRecordModel.h
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"

@interface YGRecordModel : YGRootModel

/// 阅读的章节
@property (nonatomic,strong) YGChapterModel *chapterModel;

/// 章节中的位置
@property (nonatomic) NSInteger location;

/// 阅读的章节
@property (nonatomic, assign) NSInteger currentChapter;

/// 阅读的页数
@property (nonatomic, readonly) NSInteger currentPage;

/// 该章总页数
@property (nonatomic, readonly) NSInteger totalPage;

/// 总章节数
@property (nonatomic, readonly) NSInteger totalChapters;

@end
