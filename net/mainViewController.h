//
//  ViewController.h
//  net
//
//  Created by jhx on 15/11/25.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "customCell.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface mainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (copy, nonatomic) NSMutableArray *list;//新闻数据
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

