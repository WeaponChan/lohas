//
//  PublishImageViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/4/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "PublishImageViewController.h"
#import "PubishDynamicViewController.h"

@interface PublishImageViewController ()

@end

@implementation PublishImageViewController
@synthesize imagestr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"发布图片预览"];
    NSLog(@"imagestr =====%@",imagestr);
    NSString *imageStr = [NSString stringWithFormat:@"http://lohas2.dev.lohas-travel.com/%@",imagestr];
    [self.imageView loadImageAtURLString:imageStr placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    [self addNavBar_RightBtn:[UIImage imageNamed:@"delete.png"] Highlight:[UIImage imageNamed:@"delete.png"] action:@selector(actDelete)];
    
    
}


//删除
-(void)actDelete{
    
    [self showAlert:@"确认删除?" message:nil tag:1];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    if(buttonIndex==alertView.cancelButtonIndex){
        return;
    }
    
    if(alertView.tag==1){
        PubishDynamicViewController *viewCtrl = [PubishDynamicViewController new];
        viewCtrl.imageHead.image = nil;
        
        [self.delegate deleteSuccess];
        [self.navigationController popViewControllerAnimated:YES];
        //[self.navigationController popToViewController:viewCtrl animated:NO];
        
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
