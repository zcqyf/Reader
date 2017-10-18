//
//  YGRootModel.m
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRootModel.h"
#import <objc/runtime.h>

@implementation YGRootModel

#pragma mark - NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历的属性
    for (int i = 0; i < count; i++) {
        //获取当前遍历的属性的名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        //利用KVC取出对应属性的值
        id value = [self valueForKey:name];
        //归档到文件中
        [aCoder encodeObject:value forKey:name];
    }
    free(propertes);
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count =0;
        //1.取出所有的属性
        objc_property_t *propertes = class_copyPropertyList([self class], &count);
        //2.遍历所有的属性
        for (int i = 0; i < count; i++) {
            //获取当前遍历到的属性名称
            const char *propertyName = property_getName(propertes[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //解归档前遍历得到的属性的值
            id value = [aDecoder decodeObjectForKey:name];
            //             self.className = [decoder decodeObjectForKey:@"className"];
            [self setValue:value forKey:name];
        }
        free(propertes);
    }
    
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    
    YGRootModel *model = [[[self class] allocWithZone:zone] init];
    unsigned int count =0;
    //1.取出所有的属性
    objc_property_t *propertes = class_copyPropertyList([self class], &count);
    //2.遍历所有的属性
    for (int i = 0; i < count; i++) {
        //获取当前遍历到的属性名称
        const char *propertyName = property_getName(propertes[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        [model setValue:[self valueForKey:name] forKey:name];
    }
    free(propertes);

    return model;
}

#pragma mark - log
- (NSString *)description {
    return [self configDescription];
}

- (NSString *)debugDescription {
    return [self configDescription];
}

/// 打印model所以属性
- (NSString *)configDescription {
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name] ?: @"nil";
        [mDict setObject:value forKey:name];
    }
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p> -- %@", [self class], self, mDict];
}

@end
