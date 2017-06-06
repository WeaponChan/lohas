//
//  DynamicViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicViewController.h"
#import "PubishDynamicViewController.h"
#import "PhotoGetMoreCell.h"
#import "DynamicCollectionViewCell.h"
#import "IQKeyboardManager.h"
#import "DynamicJubaoListViewController.h"
#import "TSMessage.h"
#import "ShareSdkUtils.h"
#import "DynamicSearchViewController.h"
#import "MJRefresh.h"

@interface DynamicViewController (){
    int page;
    NSArray *saidList;
    NSMutableArray *photoList;
    
    BOOL isFirstInAttention;
    BOOL isFirstInMessage;
    
    NSString *said_id;
    NSString *user_id1;
    NSString *own_id;
    
    NSDictionary *saidDic;
    NSDictionary *shareDic;
    
    UIRefreshControl *refreshControl;
    
    NSNumber *more;
    
}

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    page=1;
    photoList=[[NSMutableArray alloc]init];
    
    self.btnFabu.hidden=YES;
    
    self.viewDot.layer.cornerRadius=5;
    self.viewDot.layer.masksToBounds=YES;
    self.viewDot.hidden=YES;
    
    self.navigationItem.titleView=self.viewHead;
    self.viewStatus.layer.cornerRadius=4;
    self.viewStatus.layer.masksToBounds=YES;
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(16, 51, 92) UI:self.viewStatus];
    
    [self.collection registerClass:[DynamicCollectionViewCell class] forCellWithReuseIdentifier: @"DynamicCollectionViewCell"];
    [self.collection registerClass:[PhotoGetMoreCell class] forCellWithReuseIdentifier: @"PhotoGetMoreCell"];
    
    if ( [self  isLogin]) {
        [self showLoadingView];
        [self reloadDynamic];
    }
    
    Api *api2=[[Api alloc]init:self tag:@"shareUrl"];
    [api2 shareUrl];
   
    [self setCollectionInfo];
    [self addFooter];
    
    self.btnSend.layer.cornerRadius=4;
    self.btnSend.layer.masksToBounds=YES;
    
    isFirstInAttention=YES;
    isFirstInMessage=YES;
    self.mDynamicList.hidden=YES;
    self.mDyMessageList.hidden=YES;
    
    [self openKeyboardNotification];
    Api *api = [[Api alloc] init:self tag:@"userInfo"];
    [api get_user_info];
}

-(void)setCollectionInfo{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.collection.collectionViewLayout = flowLayout;
    self.collection.alwaysBounceVertical = YES;
    
     refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(controlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.collection addSubview:refreshControl];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collection addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        [self reloadDynamic];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [vc.collection reloadData];
            // 结束刷新
            [vc.collection footerEndRefreshing];
            if (more.intValue==0) {
                [vc.collection setFooterHidden:YES];
            }
            
        });
    }];
}

-(void)controlEventValueChanged{
    
    if (! [self isLogin]) {
        [self showAlert:@"立即登录？" message:nil tag:1];
        return;
    }
    
    [self.collection setFooterHidden:NO];
    
    page=1;
    photoList=[[NSMutableArray alloc]init];
    [self reloadDynamic];
}

-(void)viewWillAppear:(BOOL)animated{
    if (! [self isLogin]) {
        [self showAlert:@"立即登录？" message:nil tag:1];
        return;
    }else{
    
        Api *api=[[Api alloc]init:self tag:@"isNewMessage"];
        [api isNewMessage];
        
        
        [[IQKeyboardManager sharedManager] setEnable:NO];
    
        if ([AppDelegate sharedAppDelegate].isNeedRefreshDynamic) {
        [AppDelegate sharedAppDelegate].isNeedRefreshDynamic=NO;
        
        photoList=[[NSMutableArray alloc]init];
        
        page=1;
        [self reloadDynamic];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.textComment resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(buttonIndex==alertView.cancelButtonIndex){
        return;
    }
    
    if(alertView.tag==1){
        [self reloadDynamic];
        [self presentToLoginView:self];
    }
}


//显示软键盘处理函数，子类重写
- (void)keyboardWillShowUIToDo:(float)keyboardHeight{
    NSLog(@"super.keyboardWillShowUIToDo 子类未重写");
    
    CGFloat offset=self.view.frame.size.height-50-keyboardHeight;
    
    [UIView animateWithDuration:2.0 animations:^{
        
        CGRect frame=self.viewBottom.frame;
        frame.origin.y=offset;
        self.viewBottom.frame=frame;
        
    }];
    
}

//关闭软键盘处理函数，子类重写
- (void)keyboardWillHideUIToDo{
    NSLog(@"super.keyboardWillHideUIToDo 子类未重写");
    
    [self.textComment resignFirstResponder];
    self.viewBottom.hidden=YES;
}

//加载动态
-(void)reloadDynamic{
    Api *api=[[Api alloc]init:self tag:@"saidList"];
    [api saidList:page limit:18];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"userInfo"]) {
        own_id = [response objectForKeyNotNull:@"uid"];
    }
    
    
    if ([tag isEqual:@"saidList"]) {
        
        if (refreshControl) {
            [refreshControl endRefreshing];
        }
        
        more=[response objectForKeyNotNull:@"more"];
        
        if (more.intValue==0) {
            [self.collection setFooterHidden:YES];
        }
        
        saidList=[response objectForKeyNotNull:@"items"];
        
        page++;
        [photoList addObjectsFromArray:saidList];
        
        [self.collection reloadData];
        
    }
    else if ([tag isEqual:@"saidComment"]){
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        [self.mDynamicList refreshData];
    }
    else if ([tag isEqual:@"attentionAction"]){
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        
        [self.mDyMessageList refreshData];
    }
    else if ([tag isEqual:@"submitBlack"]){
        [TSMessage showNotificationInViewController:self title:@"成功拉入黑名单" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    else if ([tag isEqual:@"goodAction"]){
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        [self.mDynamicList refreshData];
    }
    else if ([tag isEqual:@"isNewMessage"]){
        
        NSNumber *isNew=[response objectForKeyNotNull:@"isNew"];
        if (isNew.intValue>0) {
            self.viewDot.hidden=NO;
        }else{
            self.viewDot.hidden=YES;
        }
        
    }
    else if ([tag isEqual:@"shareUrl"]){
        shareDic=response;
    }
    else if ([tag isEqual:@"share"]){
        
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [saidDic objectForKeyNotNull:@"content"];
        NSString* url = [response objectForKeyNotNull:@"url"];
       // NSString *SUrl=[NSString stringWithFormat:@"%@?type=1&invite_tel=%@&id=%@",url,phone,[saidDic objectForKeyNotNull:@"id"]];
        
        //NSString *SUrl=@"http://a.app.qq.com/o/simple.jsp?pkgname=com.lohas.app";
        NSString *SUrl=[shareDic objectForKeyNotNull:@"download"];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic=[saidDic objectForKeyNotNull:@"picture"];
        
        if(firstPic.length==0){
            
            MSImageView *img=[[MSImageView alloc]init];
            [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
            
            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
        }else{
            
                                       [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
            
           /* UIImage *imageS=[self getImageFromURL:firstPic];
            if (!imageS) {
                imageS=[UIImage imageNamed:@"default_bg180x180.png"];
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:imageS textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
            }
            else{
                           [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"]; 
            }
            */

        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//动态
- (IBAction)actDynamic:(id)sender {
    
    self.btnFabu.hidden=YES;
    self.btnSearch.hidden=NO;
    
    self.collection.hidden=NO;
    self.mDynamicList.hidden=YES;
    self.mDyMessageList.hidden=YES;
    
    [self.btnDynamic setBackgroundColor:MS_RGB(41, 141, 250)];
    [self.btnAttention setBackgroundColor:[UIColor clearColor]];
    [self.btnMessage setBackgroundColor:[UIColor clearColor]];
    [self.textComment resignFirstResponder];
   // page=1;
   // [self reloadDynamic];
    
}
//关注
- (IBAction)actAttention:(id)sender {
    
    self.btnFabu.hidden=NO;
    self.btnSearch.hidden=YES;
    
    self.collection.hidden=YES;
    self.mDynamicList.hidden=NO;
    self.mDyMessageList.hidden=YES;
    
    [self.btnDynamic setBackgroundColor:[UIColor clearColor]];
    [self.btnAttention setBackgroundColor:MS_RGB(41, 141, 250)];
    [self.btnMessage setBackgroundColor:[UIColor clearColor]];
    
    if (isFirstInAttention) {
        isFirstInAttention=NO;
        [self.mDynamicList initial:self];
    }else{
        [self.mDynamicList refreshData];
    }
}

#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photoList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   /* if (photoList.count%21==0 && indexPath.row+2>photoList.count && saidList.count>0 && photoList.count>0) {
        
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    if (saidList.count>0 && photoList.count>0 && photoList.count>=21*(page-1)) {
        [self reloadDynamic];
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }*/
    //else{
        static NSString * CellIdentifier = @"DynamicCollectionViewCell";
        DynamicCollectionViewCell *cell = (DynamicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (photoList.count>0) {
            NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
            [cell updateCell:self itemData:dic];
        }
       
        return cell;
   // }
    
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
    cell.backgroundColor = [UIColor clearColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//消息
- (IBAction)actMessage:(id)sender {
    
    self.btnFabu.hidden=YES;
    self.btnSearch.hidden=YES;
    
    self.collection.hidden=YES;
    self.mDynamicList.hidden=YES;
    self.mDyMessageList.hidden=NO;
    
    if (isFirstInMessage) {
        isFirstInMessage=NO;
        [self.mDyMessageList initial:self];
    }else{
        [self.mDyMessageList refreshData];
    }
    
    [self.btnDynamic setBackgroundColor:[UIColor clearColor]];
    [self.btnAttention setBackgroundColor:[UIColor clearColor]];
    [self.btnMessage setBackgroundColor:MS_RGB(41, 141, 250)];
    [self.textComment resignFirstResponder];
}

//发布动态
- (IBAction)actFabu:(id)sender {
    
    if (![self isLogin]) {
        [self presentToLoginView:self];
        return;
    }
    
    [AppDelegate sharedAppDelegate].selectAddress=@"";
    
    PubishDynamicViewController *viewVtrl=[[PubishDynamicViewController alloc]initWithNibName:@"PubishDynamicViewController" bundle:nil];
    viewVtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewVtrl animated:YES];
}

//点击评论
-(void)sendComment:(NSString*)saidID{
    
    said_id=saidID;
    
    self.viewBottom.hidden=NO;
    [self.textComment becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (range.location >=50) {
        return NO;
    }
    return YES;
}

//点击举报
-(void)juBao:(NSString*)saidID userid:(NSString*)userid{
    
    said_id=saidID;
    user_id1=userid;
    
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拉入黑名单" otherButtonTitles:@"举报", nil];
    [sheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    //举报
    if (buttonIndex==1) {
        if ([user_id1 isEqual:own_id]) {
            [self showAlert:@"不能举报自己"];
        }else{
        DynamicJubaoListViewController *viewCtrl=[[DynamicJubaoListViewController alloc]initWithNibName:@"DynamicJubaoListViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.typeID=said_id;
        viewCtrl.type=@"1";
        [self.navigationController pushViewController:viewCtrl animated:YES];
        }
    }
    else if (buttonIndex==0){
        if ([user_id1 isEqual:own_id] ) {
            
            [self showAlert:@"不能拉自己进入黑名单"];
            
        }else{
        
            Api *api=[[Api alloc]init:self tag:@"submitBlack"];
            [api submitBlack:user_id1];
        }
    }
    
}


- (IBAction)actSend:(id)sender {
    
    [self.textComment resignFirstResponder];
    self.viewBottom.hidden=YES;
    
    Api *api=[[Api alloc]init:self tag:@"saidComment"];
    [api saidComment:self.textComment.text said_id:said_id];
    
}

-(void)refreshMessage:(NSString*)user_id type:(NSString*)type{
    Api *api=[[Api alloc]init:self tag:@"attentionAction"];
    [api attentionAction:user_id type:type];
}

-(void)getMore{
    [self reloadDynamic];
}

-(void)actZan:(NSString*)saidID type:(NSString*)type{
    
    Api *api=[[Api alloc]init:self tag:@"goodAction"];
    [api goodAction:saidID type:type];
    
}

-(void)actShare:(NSString*)saidID saidItem:(NSDictionary*)saidItem{
    
    saidDic=saidItem;
    
    Api *api=[[Api alloc]init:self tag:@"share"];
    [api share];
      
}

- (IBAction)actEdit:(id)sender {
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (IBAction)actSearch:(id)sender {
    DynamicSearchViewController *viewCtrl=[[DynamicSearchViewController alloc]initWithNibName:@"DynamicSearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}
@end
