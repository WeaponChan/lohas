//
//  SelectAddressCell.m
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "SelectAddressCell.h"

@implementation SelectAddressCell
@synthesize poiList;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=poiList.name;
    
    self.labAddress.text=[NSString stringWithFormat:@"%@%@",poiList.city,poiList.address];
    
    if ([[AppDelegate sharedAppDelegate].selectAddress isEqual:self.labAddress.text]) {
        self.imageSelect.hidden=NO;
    }else{
        self.imageSelect.hidden=YES;
    }
    
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 50;
}


- (IBAction)actClick:(id)sender {
    
    [AppDelegate sharedAppDelegate].selectAddress=self.labAddress.text;
    
    [parent.navigationController popViewControllerAnimated:YES];
    
}
@end
