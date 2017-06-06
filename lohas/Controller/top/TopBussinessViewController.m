//
//  TopBussinessViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "TopBussinessViewController.h"
#import "TSMessage.h"

@interface TopBussinessViewController ()

@end

@implementation TopBussinessViewController
@synthesize HeadDic,NextDic;

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
    [self setNavBarTitle:@"克罗能霍夫大酒店"];
    
    self.viewtag.layer.cornerRadius=4.0;
    [TSMessage setDefaultViewController:self.navigationController];
    
    //1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    NSString *category_id=[HeadDic objectForKeyNotNull:@"category_id"];
    NSString *ID=[NextDic objectForKeyNotNull:@"id"];
    
    [self showLoadingView];
    if (category_id.intValue==1) {
        Api *api=[[Api alloc]init:self tag:@"get_country_info"];
        [api get_country_info:ID];
    }
    else if (category_id.intValue==2) {
        
    }
    else if (category_id.intValue==3) {
        
        Api *api=[[Api alloc]init:self tag:@"get_hotel_info"];
        [api get_hotel_info:ID date:[self getNowDate]];
    }
    else if (category_id.intValue==4) {
        
    }
    else if (category_id.intValue==5) {
        Api *api=[[Api alloc]init:self tag:@"get_shopping_info"];
        [api get_shopping_info:ID];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    NSLog(@"response==%@",response);
    
    if ([tag isEqual:@"get_hotel_info"]) {
        NSString *picture=[response objectForKeyNotNull:@"picture"];
        [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x320.png"]];
        self.labTitle.text=[response objectForKeyNotNull:@"title"];
        self.labAddress.text=[response objectForKeyNotNull:@"address"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
