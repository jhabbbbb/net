//
//  customCell.h
//  net
//
//  Created by jhx on 15/11/25.
//  Copyright © 2015年 jhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) IBOutlet UILabel *visitCount;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
