//
//  commentViewController.m
//  net
//
//  Created by jhx on 15/12/6.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import "commentViewController.h"

@interface commentViewController ()

@end

@implementation commentViewController

@synthesize comments;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置Navigation Item
    if ([comments count] == 0){
        self.navigationItem.title = @"没有评论哦～";
    }
    else {
        self.navigationItem.title = @"评论";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleIdentifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleIdentifier];
    }
    
    //评论、用户、时间
    cell.textLabel.text = [comments[indexPath.row] objectForKey:@"ccontent"];
    cell.detailTextLabel.text = [[NSString alloc]initWithFormat:@"%@ %@", [comments[indexPath.row] objectForKey:@"cuser"], [comments[indexPath.row] objectForKey:@"ctime"]];
    
    return cell;
    
}

@end
