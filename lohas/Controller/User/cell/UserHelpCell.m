//
//  UserHelpCell.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserHelpCell.h"
#import "UserHelpViewController.h"

@implementation UserHelpCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actHelp:(id)sender {
    UserHelpViewController *viewCtrl=[[UserHelpViewController alloc]initWithNibName:@"UserHelpViewController" bundle:nil];
    viewCtrl.id=[item objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end
