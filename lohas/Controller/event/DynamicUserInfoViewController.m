//
//  DynamicUserInfoViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicUserInfoViewController.h"
#import "PhotoGetMoreCell.h"
#import "DynamicCollectionViewCell.h"
#import "DynamicZanListViewController.h"
#import "DynamicJubaoListViewController.h"
#import "WatchOtherTripViewController.h"
#import "TSMessage.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface DynamicUserInfoViewController ()<UIActionSheetDelegate>{
    NSNumber *isAttention;
    NSMutableArray *saidList;
    NSArray *items;
    
    NSDictionary *homePageDic;
    
    int pageIndex;
}

@end

@implementation DynamicUserInfoViewController
@synthesize user_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"个人主页"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    saidList=[[NSMutableArray alloc]init];
    
    pageIndex=1;
    
    self.imageHead.layer.cornerRadius=35;
    self.imageHead.layer.masksToBounds=YES;
    self.btnAttention.layer.cornerRadius=4;
    self.btnAttention.layer.masksToBounds=YES;
    
    [self.collectionView registerClass:[DynamicCollectionViewCell class] forCellWithReuseIdentifier: @"DynamicCollectionViewCell"];
    [self.collectionView registerClass:[PhotoGetMoreCell class] forCellWithReuseIdentifier: @"PhotoGetMoreCell"];
    
    [self showLoadingView];
    [self getUserInfo];
}

-(void)getUserInfo{
    Api *api=[[Api alloc]init:self tag:@"homePage"];
    [api homePage:user_id page:pageIndex limit:21];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"homePage"]) {
        
        homePageDic=response;
        
        NSString *avatar=[response objectForKeyNotNull:@"avatar"];
        [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
        
        self.labName.text=[response objectForKeyNotNull:@"nick"];
        self.labInfo.text=[response objectForKeyNotNull:@"sign"];
        
        NSString *sex=[response objectForKeyNotNull:@"sex"];
        if (sex.intValue==1) {
            [self.imageSex setImage:[UIImage imageNamed:@"nan.png"]];
        }else{
            [self.imageSex setImage:[UIImage imageNamed:@"nv.png"]];
        }
        [self.labName sizeToFit];
        [MSViewFrameUtil setHeight:21 UI:self.labName];
        int width=self.labName.frame.size.width;
        [MSViewFrameUtil setLeft:78+width+2 UI:self.imageSex];
        
        isAttention=[response objectForKeyNotNull:@"isAttention"];
        if (isAttention.intValue==0) {
            [self.btnAttention setTitle:@"关注" forState:UIControlStateNormal];
            [self.btnAttention setBackgroundColor:MS_RGB(25, 82, 134)];
        }else{
            [self.btnAttention setTitle:@"取消关注" forState:UIControlStateNormal];
            [self.btnAttention setBackgroundColor:[UIColor grayColor]];
        }
        
        NSString *loginUserid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        if ([loginUserid isEqual:user_id]) {
            self.btnAttention.hidden=YES;
        }else{
            //[self addNavBar_RightBtnWithTitle:@"举报" action:@selector(actJubao)];
            
            [self addNavBar_RightBtn:[UIImage imageNamed:@"navdot.png"] Highlight:[UIImage imageNamed:@"navdot.png"] action:@selector(actClickMore)];
            
        }
        
        self.labNum1.text=[response objectForKeyNotNull:@"said_num"];
        self.labNum2.text=[response objectForKeyNotNull:@"fans_num"];
        self.labNum3.text=[response objectForKeyNotNull:@"attention_num"];
        self.labNum4.text=[response objectForKeyNotNull:@"journey_num"];
        
        pageIndex++;
        
        NSDictionary *said=[response objectForKeyNotNull:@"saidList"];
        items=[said objectForKeyNotNull:@"items"];
        [saidList addObjectsFromArray:items];
        
        [self.collectionView reloadData];
        
    }
    else if ([tag isEqual:@"attentionAction"]){
        [self getUserInfo];
    }
    else if ([tag isEqual:@"submitBlack"]){
        [TSMessage showNotificationInViewController:self title:@"成功拉入黑名单" subtitle:nil type:TSMessageNotificationTypeSuccess];
        
        [AppDelegate sharedAppDelegate].isNeedRefreshDynamic=YES;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

-(void)actClickMore{
    
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拉入黑名单" otherButtonTitles:@"举报", nil];
    [sheet showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //举报
    if (buttonIndex==1) {
        DynamicJubaoListViewController *viewCtrl=[[DynamicJubaoListViewController alloc]initWithNibName:@"DynamicJubaoListViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.typeID=user_id;
        viewCtrl.type=@"2";
        [self.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if (buttonIndex==0){
        Api *api=[[Api alloc]init:self tag:@"submitBlack"];
        [api submitBlack:user_id];
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo = YES;
    }
    
}


#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return saidList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (saidList.count%21==0 && indexPath.row+2>saidList.count && items.count>0) {
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[saidList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    else{
        static NSString * CellIdentifier = @"DynamicCollectionViewCell";
        DynamicCollectionViewCell *cell = (DynamicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[saidList objectAtIndex:indexPath.row];
        [cell updateCell:self itemData:dic];
        return cell;
    }
 
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREENWIDTH-4)/3, (SCREENWIDTH-4)/3);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCollectionViewCell * cell = (DynamicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actAttention:(id)sender {
    
    if (isAttention.intValue==0) {
        Api *api=[[Api alloc]init:self tag:@"attentionAction"];
        [api attentionAction:user_id type:@"1"];
    }else{
        Api *api=[[Api alloc]init:self tag:@"attentionAction"];
        [api attentionAction:user_id type:@"2"];
    }

}

//粉丝
- (IBAction)actFans:(id)sender {
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.isOtherFans=YES;
    viewCtrl.user_id=user_id;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//关注
- (IBAction)actAtten:(id)sender {
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.isOtherFocus=YES;
    viewCtrl.user_id=user_id;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//行程
- (IBAction)actTrip:(id)sender {
    WatchOtherTripViewController *ViewCtrl=[[WatchOtherTripViewController alloc]initWithNibName:@"WatchOtherTripViewController" bundle:nil];
    ViewCtrl.user_id=user_id;
    [self.navigationController pushViewController:ViewCtrl animated:YES];
}

//举报
-(void)actJubao{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

-(void)getMore{
    [self getUserInfo];
}

- (IBAction)actHead:(id)sender {
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    
    // 替换为中等尺寸图片
        
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@",[homePageDic objectForKeyNotNull:@"avatar"]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    photo.srcImageView = self.imageHead;
    [photos addObject:photo];
    
    // 2.显示相册
    NSString *index=@"0";
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index.intValue ; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}


@end
