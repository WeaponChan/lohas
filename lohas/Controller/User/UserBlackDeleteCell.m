//
//  UserBlackDeleteCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/29.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "UserBlackDeleteCell.h"
#import "UserBlackViewController.h"
#import "DynamicUserInfoViewController.h"

@implementation UserBlackDeleteCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
    
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    
    self.labName.text=[item objectForKeyNotNull:@"nick"];
    self.labTime.text=[NSString stringWithFormat:@"拉黑时间:%@",[item objectForKeyNotNull:@"created_at"]];
}

+ (int)Height:(NSDictionary *)itemData{
    return 55;
}

- (IBAction)actDelete:(id)sender {
    if ([parent isKindOfClass:[UserBlackViewController class]]) {
        UserBlackViewController *viewCtrl=(UserBlackViewController*)parent;
        [viewCtrl deleteBlack:[item objectForKeyNotNull:@"t_user_id"]];
    }
}

- (IBAction)actClick:(id)sender {
    DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
    viewCtrl.user_id=[item objectForKeyNotNull:@"t_user_id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end
