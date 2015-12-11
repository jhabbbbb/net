//
//  detailViewController.h
//  net
//
//  Created by jhx on 15/11/26.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "commentViewController.h"
@interface detailViewController : UIViewController

@property (strong, nonatomic) NSString *index;
@property (strong, nonatomic) NSString *commentNumber;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) IBOutlet UITextView *titleView;
@property (strong, nonatomic) IBOutlet UIWebView *contentView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *comment;//去往评论页的按钮

@end
