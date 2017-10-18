//
//  YGReadOperation.h
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGReadOperation : NSObject

/// 拆分txt
+ (void)seperateChapter:(NSMutableArray *)chapters content:(NSString *)content;

/// epub格式处理, 返回章节信息数组
+ (NSArray *)ePubFileHandle:(NSString *)path bookInfoModel:(YGBookInfoModel *)bookInfoModel;


@end
