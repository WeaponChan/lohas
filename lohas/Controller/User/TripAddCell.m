//
//  TripAddCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "TripAddCell.h"
#import "AddTripViewController.h"

#import "MyTripListViewController.h"

@implementation TripAddCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.btnAdd.layer.cornerRadius=4;
    self.btnAdd.layer.masksToBounds=YES;
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(17, 50, 86) UI:self.btnAdd];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 50;
}

- (IBAction)actAdd:(id)sender {
    AddTripViewController *viewCtrl=[[AddTripViewController alloc]initWithNibName:@"AddTripViewController" bundle:nil];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
    
}
@end
