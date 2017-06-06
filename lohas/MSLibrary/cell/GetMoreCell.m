//
//  GetMoreCell.m
//  bbs4iphone
//
//  Created by xmload shen on 11-11-4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GetMoreCell.h"

@implementation GetMoreCell
@synthesize aivLoading,labMoreTips, sepImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    [aivLoading setHidden:true];
    return self;
}

- (void)ShowLoading{
    [aivLoading setHidden:false];
    [aivLoading startAnimating];
    
}
- (void)HiddenLoading{
    [aivLoading setHidden:true];
    [aivLoading stopAnimating];
}

- (void)update:(NSString *)title{
    NSString *t = [NSString stringWithFormat:@"⇣ %@",title];
    [labMoreTips setText:t];
    [self HiddenLoading];
}

- (void)update:(NSString *)title hiddenSepImage:(BOOL)hidden{
    NSString *t = [NSString stringWithFormat:@"⇣ %@",title];
    [labMoreTips setText:t];
    [sepImage setHidden:hidden];
    [self HiddenLoading];
    
}

+ (int)Height{
    return 46;
}
@end
