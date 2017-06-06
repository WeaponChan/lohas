//
//  WrongCell.m
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "WrongCell.h"
#import "WrongListViewController.h"

@implementation WrongCell

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
    
    NSString *select=[item objectForKeyNotNull:@"select"];
    if ([select isEqual:@"NO"]) {
        self.btnSelect.selected=NO;
    }else{
        self.btnSelect.selected=YES;
    }
}

+ (int)Height:(NSDictionary *)itemData{
    return 60;
}

- (IBAction)actSelect:(id)sender {
    
    WrongListViewController *viewCtrl=(WrongListViewController*)parent;
     [viewCtrl getSelectId:[item objectForKeyNotNull:@"id"]];
    [viewCtrl.mWrongList selectWrong:[item objectForKeyNotNull:@"id"]];
   
    
}

@end
