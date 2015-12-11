//
//  ViewController.m
//  net
//
//  Created by jhx on 15/11/25.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import "mainViewController.h"
#import "detailViewController.h"
@interface mainViewController (){
    int page;//获取新闻的页数
}

@end

@implementation mainViewController
@synthesize list;
@synthesize table;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    list = [[NSMutableArray alloc]initWithCapacity:42];
    page = 0;
    
    //获得tableView数据
    [self getData];
    
    //添加下拉刷新、分页加载控件
    __weak mainViewController *weakSelf = self;
    [table addPullToRefreshWithActionHandler:^{
        [weakSelf refreshTable];
    }];
    [table addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadTable];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数据
- (void)refreshTable{
    
    //延时
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //刷新
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        page = 0;
        [list removeAllObjects];
        [self getData];
    });
}//下拉刷新

- (void)loadTable{
    
    //延时
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    //加载
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getData];
    });
    
}//分页加载

- (void)getData {
    
    page++;
    
    //网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[[NSString alloc]initWithFormat:@"http://open.twtstudio.com/api/v1/news/1/page/%d", page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *news = [dic objectForKey:@"data"];
        for (NSDictionary *dict in news){
            [list addObject:dict];
        }
        
        //加载动画消失
        [table.pullToRefreshView stopAnimating];
        [table.infiniteScrollingView stopAnimating];
        
        [table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}//获取更多新闻

//tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleIdentifier = @"custom";
    
    customCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if (cell == nil){
        cell = [[customCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentifier];
    }
    
    //题目、评论数、访问数、图片
    cell.subject.text = [list[indexPath.row] objectForKey:@"subject"];
    cell.comment.text = [[NSString alloc]initWithFormat:@"评论(%@)", [list[indexPath.row] objectForKey:@"comments"]];
    cell.visitCount.text = [[NSString alloc]initWithFormat:@"访问(%@)", [list[indexPath.row] objectForKey:@"visitcount"]];
    NSString *url = [list[indexPath.row] objectForKey:@"pic"];
    [cell.image setImageWithURL:[NSURL URLWithString:url]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    detailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    vc.index = [list[indexPath.row] objectForKey:@"index"];
    vc.commentNumber = [list[indexPath.row] objectForKey:@"comments"];
    [self.navigationController pushViewController:vc animated:YES];
    
    //取消cell选择
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
}//进入新闻页面





@end
