//
//  EmptyDataCell.m
//  AppCard
//
//  Created by xmload on 12-11-2.
//  Copyright (c) 2012年 onuo. All rights reserved.
//

#import "EmptyDataCell.h"

@implementation EmptyDataCell
@synthesize labTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)update:(NSString *)value{
    
    [labTitle setText:value];
}

+ (int)Height{
    return 120;
}

@end
