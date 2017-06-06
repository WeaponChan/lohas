//
//  DynamicJubaoCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicJubaoCell.h"
#import "DynamicJubaoListViewController.h"

@implementation DynamicJubaoCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"NO"]) {
        self.btnSele.selected=NO;
    }else{
        self.btnSele.selected=YES;
    }
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actSelect:(id)sender {

    
    if ([parent isKindOfClass:[DynamicJubaoListViewController class]]) {
        DynamicJubaoListViewController *viewCtrl=(DynamicJubaoListViewController*)parent;
        [viewCtrl selectJubao:[item objectForKeyNotNull:@"id"]];
    }
    
}
@end
