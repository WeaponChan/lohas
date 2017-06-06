//
//  DiscoverDetailViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverDetailViewController.h"
#import "NewTabSubTitleCell.h"
#import "ShareSdkUtils.h"

@interface DiscoverDetailViewController (){
    NSArray *recommend;
    
    NSDictionary *guideDic;
}

@end

@implementation DiscoverDetailViewController
@synthesize detailID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"详情"];
    
    bannerView = (DetailBanner *)[self newViewWithNibNamed:@"DetailBanner" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:self];
    
    [self addNavBar_RightBtn:[UIImage imageNamed:@"nShare.png"] Highlight:[UIImage imageNamed:@"nShare.png"] action:@selector(actDoFav)];
    
    
    [self getDetail];
}

//分享
-(void)actDoFav{
    
    NSString *SUrl=[NSString stringWithFormat:@"http://lohas2.dev.lohas-travel.com/wap/share/guideShare?id=%@",detailID];
    
    NSString *content=[NSString stringWithFormat:@"%@ %@",self.labTitle.text, SUrl];
    
    NSString *firstPic;
    NSArray *list=[guideDic objectForKeyNotNull:@"pics"];
    if (list.count>0) {
        firstPic=list[0];
    }
    if(firstPic.length==0){
        
        MSImageView *img=[[MSImageView alloc]init];
        [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
        
        [ShareSdkUtils share:self.labTitle.text url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:nil];
    }else{
        
        [ShareSdkUtils share:self.labTitle.text url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
    }
    
}


-(void)getDetail{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"guideDetail"];
    
    [api guideDetail:detailID lat:[AppDelegate sharedAppDelegate].ownLocation.coordinate.latitude lng:[AppDelegate sharedAppDelegate].ownLocation.coordinate.longitude];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"guideDetail"]) {
        
        guideDic=response;
        
        self.labTitle.text=[response objectForKeyNotNull:@"title"];
        
        NSString *content=[response objectForKeyNotNull:@"content"];
        NSString *str=[NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=1\"><style>body{font-size:16px;} img { display:block;width:100%%; margin:0 auto;}</style></head><body style=\"width:95%%;padding:0px;\">%@</body></html>",content];
         [self.webView  loadHTMLString:str baseURL:nil];
        
        
        NSArray *pics=[response objectForKeyNotNull:@"pics"];
        NSMutableArray *list=[[NSMutableArray alloc]init];
        for (NSString *imgStr in pics) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:imgStr forKey:@"image"];
            [list addObject:dic];
        }
        [bannerView reload:list];
        
        recommend=[response objectForKeyNotNull:@"recommend"];
    }
    else if ([tag isEqual:@"guideShare"]){
        
        
            
            NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
            
            NSString* title11 = [response objectForKeyNotNull:@"title"];
            NSString* url = [response objectForKeyNotNull:@"url"];
            NSString *SUrl=[NSString stringWithFormat:@"%@?type=1&invite_tel=%@&id=%@",url,phone,[response objectForKeyNotNull:@"id"]];
            
            NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
            
            /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
             NSString *firstPic;
             if (picture_lists.count>0) {
             firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
             }*/
            
            NSString *firstPic;
            NSArray *list=[response objectForKeyNotNull:@"pics"];
            if (list.count>0) {
                firstPic=list[0];
            }
            if(firstPic.length==0){
                
                MSImageView *img=[[MSImageView alloc]init];
                [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
                
                [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:nil];
            }else{
                
                [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
                
                /* UIImage *imageS=[self getImageFromURL:firstPic];
                 if (!imageS) {
                 imageS=[UIImage imageNamed:@"default_bg180x180.png"];
                 [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:imageS textStr:nil];
                 }else{
                 [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
                 }*/
                
            }
            
        }
        
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self closeLoadingView];
    
    self.webView.scrollView.scrollEnabled=NO;
    
    float sizeHeight = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    sizeHeight = [MSViewFrameUtil setHeight:sizeHeight+10 UI:self.webView];
    sizeHeight = [MSViewFrameUtil setTop:sizeHeight+10 UI:self.labTitleTag];
    
    if (recommend.count==0) {
        self.labTitleTag.hidden=YES;
    }
    
    for (NSDictionary *dic in recommend) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"NewTabSubTitleCell" owner:self options:nil];
        NewTabSubTitleCell *viewCtrl=(NewTabSubTitleCell*)nib[0];
        
        [MSViewFrameUtil setWidth:SCREENWIDTH UI:viewCtrl];
        
        viewCtrl.category_id=@"2";
        [viewCtrl update:dic Parent:self];
        
        [self.scrollView addSubview:viewCtrl];
        sizeHeight=[MSViewFrameUtil setTop:sizeHeight+10 UI:viewCtrl];
        
    }
    
    [self.scrollView setContentSize:CGSizeMake(320, sizeHeight+10)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
