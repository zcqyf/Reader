//
//  YGCatalogueModel.h
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"

@interface YGCatalogueModel : YGRootModel

@property (nonatomic, copy) NSString *catalogueName;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *catalogueId;//如果id为空，则为一级目录

@property (nonatomic, assign) NSInteger chapter;//章节

@end
