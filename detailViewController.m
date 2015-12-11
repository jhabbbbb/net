//
//  detailViewController.m
//  net
//
//  Created by jhx on 15/11/26.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController
@synthesize titleView;
@synthesize contentView;
@synthesize comment;
@synthesize comments;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置Navigation Item
    self.navigationItem.title = @"新闻";
    comment.title = [[NSString alloc]initWithFormat:@"评论(%@)", self.commentNumber];
    
    //网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[[NSString alloc]initWithFormat:@"http://open.twtstudio.com/api/v1/news/%@", self.index] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *news = [dic objectForKey:@"data"];
        
        //获取评论
        comments = [news objectForKey:@"comments"];
        
        //题目
        titleView.text = [news objectForKey:@"subject"];
        
        //内容html解析
        NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];
        NSString *contentText = [news objectForKey:@"content"];
        [html appendString:contentText];
        [html appendString:@"</body></html>"];
        [contentView loadHTMLString:[html description] baseURL:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"comment"]){
        
        commentViewController *vc = segue.destinationViewController;
        vc.comments = [[NSArray alloc]initWithArray:comments];
    }
}//push评论页

@end
