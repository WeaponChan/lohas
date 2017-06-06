//
//  UserHelpViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserHelpViewController.h"
#import "TSMessage.h"

@interface UserHelpViewController ()

@end

@implementation UserHelpViewController

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
    [self setNavBarTitle:@"常见问题"];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_help_info"];
    [api get_help_info:self.id];
    
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
    if ([tag isEqual:@"get_help_info"]) {
        
        self.labTitle.text=[NSString stringWithFormat:@"%@",[response objectForKeyNotNull:@"title"]];
        self.labInfo.text=[NSString stringWithFormat:@"%@",[response objectForKeyNotNull:@"content"]];
        
        [self.labInfo sizeToFit];
        int height=self.labInfo.frame.size.height;
        [MSViewFrameUtil setHeight:50+height+10 UI:self.labMainView];
        
        [self.scrollView setContentSize:CGSizeMake(320, 10+self.labMainView.frame.size.height)];
         self.scrollView.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
