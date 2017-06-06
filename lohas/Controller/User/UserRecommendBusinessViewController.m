//
//  UserRecommendBusinessViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserRecommendBusinessViewController.h"
#import "Validate.h"
#import "TSMessage.h"

@interface UserRecommendBusinessViewController ()

@end

@implementation UserRecommendBusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarTitle:@"推荐商家"];
    
    self.btnCommit.layer.cornerRadius=4.0;
    // Do any additional setup after loading the view from its nib.
    [TSMessage setDefaultViewController:self.navigationController];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actRecommend:(id)sender {
    if (![self judgeText]) {
        return;
    }
    
    NSLog(@"ChangeSuccess");
}

//判断输入合法性
-(BOOL)judgeText{
    if (self.textBusinessName.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入商家名称"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (self.textBusinessPhone.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入联系电话"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![Validate validateUserName:self.textBusinessName.text]) {
        [TSMessage showNotificationWithTitle:@"商家名称中有特殊字符"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![Validate validateMobile:self.textBusinessPhone.text]) {
        [TSMessage showNotificationWithTitle:@"请输入正确的手机号码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    
    return YES;
}

@end
