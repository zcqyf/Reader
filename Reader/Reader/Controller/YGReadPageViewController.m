//
//  YGReadPageViewController.m
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGReadPageViewController.h"

@interface YGReadPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIGestureRecognizerDelegate>
{
    //  当前显示的章节
    NSInteger _chapter;
    //  当前显示的页数
    NSInteger _page;
    //  将要变化的章节
    NSInteger _chapterChange;
    //  将要变化的页数
    NSInteger _pageChange;
    //  是否正在翻页
    NSInteger _isDoingAnnimation;
}

/// 翻页视图控制器
@property (nonatomic,strong) UIPageViewController *pageViewController;
//@property (strong, nonatomic) XDSReadMenu *readMenuView;//菜单



@end

@implementation YGReadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readPageViewControllerDataInit];
    [self createReadPageViewControllerUI];
}

//MARK: - ABOUT UI
- (void)createReadPageViewControllerUI {
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    _chapter = CURRENT_RECORD.currentChapter;
    _page = CURRENT_RECORD.currentPage;
    
    YGReadViewController *readVC = [[YGReadManager sharedManager] readViewWithChapter:&_chapter page:&_page pageUrl:nil];
    [_pageViewController setViewControllers:@[readVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    
}



#pragma mark - UIPageViewControllerDataSource
/// 前一个viewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"前一个viewController");
    if (_isDoingAnnimation) {
        return nil;
    }
    
    _pageChange = _page;
    _chapterChange = _chapter;
    
    if (_chapterChange + _pageChange == 0) {
        //  已经是第一页了，显示菜单准备返回
        [self showToolMenu];
        return nil;
    }
    
    if (_pageChange == 0) {
        _chapterChange--;
    }

    return [[YGReadManager sharedManager] readViewWithChapter:&_chapterChange page:&_pageChange pageUrl:nil];
}

/// 后一个viewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSLog(@"后一个viewController");
    
    if (_isDoingAnnimation) {
        return nil;
    }
    
    _pageChange = _page;
    _chapterChange = _chapter;
    if (_pageChange == CURRENT_BOOK_MODEL.chapters.lastObject.pageCount - 1 && _chapterChange == CURRENT_BOOK_MODEL.chapters.count - 1) {
        //最后一页，这里可以处理一下，添加已读完页面。
        [self showToolMenu];//已经是最后一页了，显示菜单准备返回
        return nil;
    }
    if (_pageChange == CURRENT_RECORD.totalPage - 1) {
        _chapterChange++;
        _pageChange = 0;
    } else{
        _pageChange++;
    }
    
    
//    _isDoingAnnimation = YES;
    return [[YGReadManager sharedManager] readViewWithChapter:&_chapterChange
                                                          page:&_pageChange
                                                       pageUrl:nil];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    NSLog(@"将要转到下一个VC");
    
    _chapter = _chapterChange;
    _page = _pageChange;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"已经转到下一个VC");
    
    _isDoingAnnimation = !finished;
    if (!completed)
    {
        YGReadViewController *readView = (YGReadViewController *)previousViewControllers.firstObject;
        _page = readView.pageNum;
        _chapter = readView.chapterNum;
    }
    else
    {
        _chapter = _chapterChange;
        _page = _pageChange;
        [[YGReadManager sharedManager] updateReadModelWithChapter:_chapter page:_page];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - ABOUT REQUEST
//MARK: - ABOUT EVENTS
-(void)showToolMenu{
//    YGReadViewController *readView = _pageViewController.viewControllers.firstObject;
//    [readView.readView cancelSelected];
//    [self.view addSubview:self.readMenuView];
}
//MARK: - OTHER PRIVATE METHODS
//- (YGReadMenu *)readMenuView{
//    if (nil == _readMenuView) {
//        _readMenuView = [[XDSReadMenu alloc] initWithFrame:self.view.bounds];
//        _readMenuView.backgroundColor = [UIColor clearColor];
//    }
//    return _readMenuView;
//}

//MARK: - ABOUT MEMERY
- (void)readPageViewControllerDataInit{}

@end
