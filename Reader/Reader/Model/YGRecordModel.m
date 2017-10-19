//
//  YGRecordModel.m
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRecordModel.h"

@interface YGRecordModel ()

/// 阅读当前页数
@property (nonatomic, assign) NSInteger currentPage;

/// 该章总页数
@property (nonatomic, assign) NSInteger totalPage;

/// 总章节数
@property (nonatomic, assign) NSInteger totalChapters;

@end

@implementation YGRecordModel

- (id)copyWithZone:(NSZone *)zone {
    YGRecordModel *recordModel = [[YGRecordModel allocWithZone:zone]init];
    recordModel.chapterModel = [self.chapterModel copy];
    recordModel.location = self.location;
    recordModel.currentChapter = self.currentChapter;
    return recordModel;
}

- (NSInteger)totalPage{
    return self.chapterModel.pageCount;
}
- (NSInteger)totalChapters{
    return CURRENT_BOOK_MODEL.chapters.count;
}
- (NSInteger)currentPage{
    if (self.chapterModel.pageLocations.count < 1) {
        return 0;
    }
    
    NSInteger page = 0;
    if (self.location == [self.chapterModel.pageLocations.lastObject integerValue]) {
        page = self.chapterModel.pageLocations.count - 1;
    }else{
        for (int i = 0; i < self.chapterModel.pageLocations.count; i ++) {
            NSInteger location = [self.chapterModel.pageLocations[i] integerValue];
            if (self.location < location) {
                page = (i > 0)? (i - 1):0;
                break;
            }
        }
    }
    return page;
}

@end
