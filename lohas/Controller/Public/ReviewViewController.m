//
//  ReviewViewController.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "ReviewViewController.h"
#import "TSMessage.h"

@interface ReviewViewController (){
    NSArray *btnArray;
    BOOL flag;
    int score;
    NSArray *btnGoodList;
    NSString* btnScore;
    
}

@end

@implementation ReviewViewController
@synthesize subID,type;

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
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:@"点评"];
    
    self.btnCommit.layer.cornerRadius=4.0;
    [self.btnCommit setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnCommit addBtnAction:@selector(actCommit) target:self];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    flag=YES;
    score=0;
    btnScore=@"";
    
    btnArray =[[NSArray alloc]initWithObjects:self.btn1,self.btn2,self.btn3,self.btn4,self.btn5, nil];
    btnGoodList = [[NSArray alloc]initWithObjects:self.btnGood1,self.btnGood2,self.btnGood3,self.btnGood4, nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.labTag.hidden=YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textContent.text.length==0) {
        self.labTag.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actBtnStar:(id)sender {
    UIButton *btn=(UIButton*)sender;
    
    for (UIButton *subBtn in btnArray) {
        
        if (flag) {
            subBtn.selected=YES;
        }
        else if(flag==NO){
            subBtn.selected=NO;
        }
        
        if (btn==subBtn) {
            flag=NO;
        }        
    }
    
    score=btn.tag;
    flag=YES;
}

//提交
-(void)actCommit{
    if (self.textContent.text.length==0) {
        [TSMessage showNotificationInViewController:self title:@"请先输入评价内容" subtitle:nil type:TSMessageNotificationTypeError];
        return;
    }
    else if (btnScore.length==0) {
       [TSMessage showNotificationInViewController:self title:@"请先选择评价标签" subtitle:nil type:TSMessageNotificationTypeError];
       return;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"submit_comment"];
    [api submit_comment:subID type:type score:score content:self.textContent.text tag:btnScore];
    
}


-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
     [self closeLoadingView];
    if ([tag isEqual:@"submit_comment"]) {
      [TSMessage showNotificationInViewController:self title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        
        
        [self performBlock:^{
            [self.delegate reviewBack];
            [self.navigationController popViewControllerAnimated:YES];
        }afterDelay:1.0];
    }
}

- (IBAction)actGood:(id)sender {
    UIButton *btn=(UIButton*)sender;
    
    for (UIButton *btns in btnGoodList) {
        if (btn==btns) {
            btn.selected=YES;
        }else{
            btns.selected=NO;
        }
    }
    
    btnScore=btn.titleLabel.text;;
    
}
@end
