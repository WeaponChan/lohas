//
//  PubishDynamicViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "PubishDynamicViewController.h"
#import "TSMessage.h"
#import "PublishImageViewController.h"
#import "SelectAddressViewController.h"

@interface PubishDynamicViewController ()<deleteImageDelegate>{
    NSString *imageStr;
}

@end

@implementation PubishDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"发布动态"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self addNavBar_RightBtnWithTitle:@"发送" action:@selector(actSend)];
    
    [self.btnImage addBtnAction:@selector(actImage:) target:self];

}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([AppDelegate sharedAppDelegate].selectAddress.length==0) {
        self.labAddress.text=@"所在位置";
    }else{
        self.labAddress.text=[AppDelegate sharedAppDelegate].selectAddress;
    }
 
}

-(void)actSend{
    
    if (imageStr.length==0) {
        [TSMessage showNotificationInViewController:self title:@"请先上传照片" subtitle:nil type:TSMessageNotificationTypeError];
        return;
    }
    
    if (self.textContent.text.length==0) {
        self.textContent.text=@"";
    }
    
    [self.textContent resignFirstResponder];
    
    if([self.labAddress.text isEqual:@"所在位置"]){
        self.labAddress.text=@"不显示位置";
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"submitSaid"];
    [api submitSaid:self.textContent.text picture:imageStr address:self.labAddress.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.labTag.hidden=YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    int count=textView.text.length;
    
    if (count>100) {
        
        self.textContent.text=[textView.text substringToIndex:100];
        count=textView.text.length;
        
    }
    
    self.labNum.text=[NSString stringWithFormat:@"%d/100",count];
    
}



-(void)actImage:(id)sender{
  
    if (imageStr==nil) {
        [self selectPhotoPicker];
    }else{
    
        PublishImageViewController *viewCtrl = [[PublishImageViewController alloc]initWithNibName:@"PublishImageViewController" bundle:nil];
        
        viewCtrl.delegate=self;
        viewCtrl.imagestr = imageStr;
        [self.navigationController pushViewController:viewCtrl animated:NO];
        
    }
    
}

-(void)deleteSuccess{
    self.imageHead.image=[UIImage imageNamed:@"1.png"];
}

-(void)pickerCallback:(UIImage *)img
{
    self.imageHead.image=img;

    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"upload"];
    [api upload:img];
}

- (IBAction)actSelectImage:(id)sender {
    [self selectPhotoPicker];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationWithTitle:message
                                subtitle:nil
                                    type:TSMessageNotificationTypeError];
    
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"upload"]) {
        imageStr=[response objectForKeyNotNull:@"photo"];
    }
    else if ([tag isEqual:@"submitSaid"]){
        
        [AppDelegate sharedAppDelegate].isNeedRefreshDynamic=YES;
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (IBAction)actCurrentplace:(id)sender {

    SelectAddressViewController *viewCtrl=[[SelectAddressViewController alloc]initWithNibName:@"SelectAddressViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}


@end
