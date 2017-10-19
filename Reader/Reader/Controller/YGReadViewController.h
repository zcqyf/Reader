//
//  YGReadViewController.h
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGReadViewController : UIViewController

@property (strong, nonatomic) YGReadView *readView;

@property (assign, nonatomic) NSInteger chapterNum;
@property (assign, nonatomic) NSInteger pageNum;
@property (copy, nonatomic) NSString *pageUrl;


/*
 * 通过章节号与章节内的页码进行初始化
 */
- (instancetype)initWithChapterNumber:(NSInteger)chapterNum pageNumber:(NSInteger)pageNum;


///*
// * 通过url进行初始化，主要是epub目录有可能使用页码进行跳转
// */
//- (instancetype)initWithPageUrl:(NSString *)pageUrl;

@end
