//
//  YGReadManager.m
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGReadManager.h"

@implementation YGReadManager

static YGReadManager *readManager;

+ (YGReadManager *)sharedManager {
    if (readManager == nil) {
        readManager = [[self alloc] init];
    }
    return readManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        readManager = [super allocWithZone:zone];
    });
    return readManager;
}

+ (CGRect)readViewBounds {
    CGRect bounds = CGRectMake(kReadViewMarginTop,
                               kReadViewMarginLeft,
                               DEVICE_MAIN_SCREEN_WIDTH_XDSR-kReadViewMarginLeft-kReadViewMarginRight,
                               DEVICE_MAIN_SCREEN_HEIGHT_XDSR-kReadViewMarginTop-kReadViewMarginBottom);
    return bounds;
}

- (YGReadViewController *)readViewWithChapter:(NSInteger *)chapter page:(NSInteger *)page pageUrl:(NSString *)pageUrl {
    
    YGChapterModel *currentChapterModel = _bookModel.chapters[*chapter];
    if (currentChapterModel.isReadConfigChanged) {
        [CURRENT_BOOK_MODEL loadContentInChapter:currentChapterModel];
        if (currentChapterModel == CURRENT_RECORD.chapterModel) {
            *page = CURRENT_RECORD.currentPage;
        }
    }
    
    if (*page < 0){
        *page = currentChapterModel.pageCount - 1;
    }
    
    YGReadViewController *readView = [[YGReadViewController alloc] init];
    readView.chapterNum = *chapter;
    readView.pageNum = *page;
    readView.pageUrl = pageUrl;
    return readView;
}

//MARK: - 更新阅读记录
-(void)updateReadModelWithChapter:(NSInteger)chapter page:(NSInteger)page {
    
    if (chapter < 0) {
        chapter = 0;
    }
    if (page < 0) {
        page = 0;
    }
    _bookModel.record.chapterModel = _bookModel.chapters[chapter];
    _bookModel.record.location = [_bookModel.record.chapterModel.pageLocations[page] integerValue];
    _bookModel.record.currentChapter = chapter;
    [YGBookModel updateLocalModel:_bookModel url:_resourceURL];
    
    if (self.rmDelegate && [self.rmDelegate respondsToSelector:@selector(readViewDidUpdateReadRecord)]) {
        [self.rmDelegate readViewDidUpdateReadRecord];
    }
}

@end
