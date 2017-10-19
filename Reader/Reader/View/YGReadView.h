//
//  YGReadView.h
//  Reader
//
//  Created by qing on 2017/10/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YGReadViewControllerDelegate;
@interface YGReadView : UIView

- (instancetype)initWithFrame:(CGRect)frame chapterNum:(NSInteger)chapterNum pageNum:(NSInteger)pageNum;

- (void)cancelSelected;


@property (nonatomic,strong) id<YGReadViewControllerDelegate> rvDelegate;

@end
