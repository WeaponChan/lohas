//
//  SceneryInfoCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SceneryInfoCell.h"
#import "MapViewController.h"
#import "WapViewController.h"
#import "TSMessage.h"

@implementation SceneryInfoCell
@synthesize countryInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    
    [super update:itemData Parent:parentCtrl];
    
    self.labAddress.text=[countryInfo objectForKeyNotNull:@"address"];
    self.labPhone.text=[countryInfo objectForKeyNotNull:@"phone"];

}

//电话
- (IBAction)actPhone:(id)sender {
    
    if ([self.labPhone.text rangeOfString:@"-"].location!=NSNotFound) {
        
        NSArray *array=[self.labPhone.text componentsSeparatedByString:@"-"];
        
        NSString *str;
        for (NSString *phoneStr in array) {
            if (str.length==0) {
                str=phoneStr;
            }else
                str=[NSString stringWithFormat:@"%@%@",str,phoneStr];
        }
        
        [parent phonecall:str];
        
    }else{
        [parent phonecall:self.labPhone.text];
    }
    
}

//地址
- (IBAction)actLocation:(id)sender {
    MapViewController *viewCtrl=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    viewCtrl.lat=[countryInfo objectForKeyNotNull:@"lat"];
    viewCtrl.lng=[countryInfo objectForKeyNotNull:@"lng"];
    viewCtrl.title=[countryInfo objectForKeyNotNull:@"title"];
    viewCtrl.address=[NSString stringWithFormat:@"中国%@",self.labAddress.text];;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actWeb:(id)sender {
    NSString *url=[countryInfo objectForKeyNotNull:@"url"];
    if (url.length==0 || [url isEqual:@"无"]) {
        [TSMessage showNotificationInViewController:parent title:@"当前景点还没有网站" subtitle:nil type:TSMessageNotificationTypeError];
        return;
        
    }else{
        
        NSString *sub=[url substringToIndex:4];
        if (![sub isEqual:@"http"]) {
             url=[NSString stringWithFormat:@"http://%@",url];
        }
        
        WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.linkStr=url;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
}



+ (int)Height:(NSDictionary *)itemData{
    return 132;
}

@end
