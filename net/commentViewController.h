//
//  commentViewController.h
//  net
//
//  Created by jhx on 15/12/6.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSArray *comments;//评论数据

@end
