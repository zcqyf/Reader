//
//  ViewController.m
//  Reader
//
//  Created by qing on 2017/10/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "ViewController.h"



@interface ViewController () <NSXMLParserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)start:(id)sender {
    [self XMLSerialization];
}

- (void)XMLSerialization {
    
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"交锋" ofType:@"epub"];
//
//    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *destination = [document stringByAppendingPathComponent:@"交锋"];
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"交锋" withExtension:@"epub"];
    
    YGBookModel *bookModel = [YGBookModel getLocalModelWithURL:fileURL];
    
    NSLog(@"%@", bookModel);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParserDelegate
/// 当扫描到文档的开始时调用（开始解析）
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"当扫描到文档的开始时调用（开始解析）");
}

/// 当扫描到文档的结束时调用（解析完毕）
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    NSLog(@"当扫描到文档的结束时调用（解析完毕）");
}

/// 当扫描到元素的开始时调用（attributeDict存放着元素的属性）
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    
    NSLog(@"当扫描到元素的开始时调用（attributeDict存放着元素的属性）");
}

/// 当扫描到元素的结束时调用
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    NSLog(@"当扫描到元素的结束时调用");
}


@end
