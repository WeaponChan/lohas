//
//  OtherTripCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "OtherTripCell.h"
#import "OtherTripViewController.h"
@implementation OtherTripCell
@synthesize isOther;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labName.text=[itemData objectForKeyNotNull:@"title"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actClick:(id)sender {
    
    OtherTripViewController *viewCtrl=[[OtherTripViewController alloc]initWithNibName:@"OtherTripViewController" bundle:nil];
    viewCtrl.tripID=[item objectForKeyNotNull:@"id"];
    viewCtrl.userID = [item objectForKeyNotNull:@"user_id"];
    viewCtrl.isOther=isOther;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}
@end
