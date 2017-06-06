//
//  EmptyDataCell.h
//  AppCard
//
//  Created by xmload on 12-11-2.
//  Copyright (c) 2012年 onuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
- (void)update:(NSString *)value;

+ (int)Height;

@end
