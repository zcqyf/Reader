//
//  YGReadViewController.m
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGReadViewController.h"
#import "YGReadView.h"

@interface YGReadViewController ()

@property (strong, nonatomic) YGChapterModel *chapterModel;

@end

@implementation YGReadViewController

- (instancetype)initWithChapterNumber:(NSInteger)chapterNum pageNumber:(NSInteger)pageNum {
    if (self = [super init]) {
        self.chapterNum = chapterNum;
        self.pageNum = pageNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [YGReadConfig shareInstance].currentTheme ? [YGReadConfig shareInstance].currentTheme : [YGReadConfig shareInstance].cacheTheme;
    
    CGRect frame = [YGReadManager readViewBounds];
    self.readView = [[YGReadView alloc] initWithFrame:frame chapterNum:self.chapterNum pageNum:self.pageNum];
    self.readView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.readView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"YGReadViewController dealloc");
}


@end
