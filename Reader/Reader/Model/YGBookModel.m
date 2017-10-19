//
//  YGBookModel.m
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGBookModel.h"
#import "YGReadManager.h"

@implementation YGBookModel

- (instancetype)initWithContent:(NSString *)content {
    self = [super init];
    if (self) {
        /// custom
        
        
        
    }
    return self;
}

- (instancetype)initWithePub:(NSString *)ePubPath {
    self = [super init];
    if (self) {
        _bookBasicInfo = [YGBookInfoModel new];
        _chapters = [YGReadOperation ePubFileHandle:ePubPath bookInfoModel:_bookBasicInfo];
        //  XDSRecordModel  TODO
        
        _bookType = YGEBookTypeEpub;
    }
    return self;
}

+ (void)updateLocalModel:(YGBookModel *)bookModel url:(NSURL *)url {
    NSString *key = [url.path lastPathComponent];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:bookModel forKey:key];
    [archiver finishEncoding];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getLocalModelWithURL:(NSURL *)url {
    
    NSString *key = [url.path lastPathComponent];
    //  TODO 数据存放位置有待改善
    NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:key];
    if (!data) {
        if ([[key pathExtension].lowercaseString isEqualToString:@"txt"]) {
            
            
            
            
            
            
        } else if ([[key pathExtension].lowercaseString isEqualToString:@"epub"]) {
            YGBookModel *model = [[YGBookModel alloc] initWithePub:url.path];
            model.resource = url;
            [YGBookModel updateLocalModel:model url:url];
            return model;
        } else {
            //  TODO throw 和 NSException 的使用
            @throw [NSException exceptionWithName:@"FileException" reason:@"文件格式错误" userInfo:nil];
        }
    }
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //  主线程操作
    YGBookModel *model = [unArchiver decodeObjectForKey:key];
    return model;
}

- (void)loadContentInChapter:(YGChapterModel *)chapterModel {
    [chapterModel paginateEpubWithBounds: [YGReadManager readViewBounds]];
}


@end
