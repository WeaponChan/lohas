//
//  AreaCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "AreaCell.h"
#import "subDiscoverListViewController.h"

@implementation AreaCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labName.text=[item objectForKeyNotNull:@"name"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actClick:(id)sender {
    if ([parent isKindOfClass:[subDiscoverListViewController class]]) {
        subDiscoverListViewController *viewCtrl=(subDiscoverListViewController*)parent;
        [viewCtrl refreshInfo:[item objectForKeyNotNull:@"id"]];
    }
    
}
@end
