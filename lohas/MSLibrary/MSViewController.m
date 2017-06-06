//
//  MSViewController.m
//
//  Created by xmload shen on 12-1-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MSViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "AlixPayResult.h"
//#import "AlixPayOrder.h"
//#import "DataVerifier.h"
#import "UserSigninViewController.h"

@implementation MSViewController

@synthesize isModal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isModal = NO;
        isKeyboardShowing = false;
    }
    return self;
}

#pragma mark - ViewCtrl 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self initNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString* classname = NSStringFromClass([self class]);
    NSLog(@"%@",classname);
}

- (void) viewDidAppear:(BOOL)animated
{
}

- (void) viewWillDisappear:(BOOL)animated
{
}

- (void) viewDidDisappear:(BOOL)animated
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    labCustomTitle = nil;
    naviTitleView  = nil;
    HUD  = nil;
    viewCloseKeyboard  = nil;
    
    [super viewDidUnload];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ([MSUIUtils getIOSVersion] >= 7.0){
        return UIStatusBarStyleDefault;
    }else{
        return UIStatusBarStyleBlackOpaque;
    }
}

#pragma mark - 窗体初始化 — 导航栏
//设置导航栏 self viewDidLoad 时调用
- (void)initNavigationBar
{
    //自动添加返回按钮
    [self addNavBar_BackBtn];
}

//设置导航栏标题
- (void)setNavBarTitle:(NSString *)title
{
    if (!naviTitleView) {
        naviTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.navigationItem.titleView = naviTitleView;
    }
    if (!labCustomTitle) {
        labCustomTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        labCustomTitle.backgroundColor = [UIColor clearColor];
        labCustomTitle.font = [UIFont boldSystemFontOfSize:18.0];
        [labCustomTitle setTextAlignment:NSTextAlignmentCenter];
        labCustomTitle.textColor = labCustomTitleColor;
        
        [naviTitleView addSubview:labCustomTitle];
    }
    labCustomTitle.text = title;
}

//设置导航栏标题图片
- (void)setNavBarImg:(NSString *)imgName {
    UIImageView *imgLogo= [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    [naviTitleView addSubview:imgLogo];
[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];

}

//设置导航栏返回按钮，initNavigationBar时自动调用
- (void)addNavBar_BackBtn
{
    if (self.navigationController) {
        if (!isModal && [self.navigationController.viewControllers objectAtIndex:0] == self) {
            return;
        }
        if ([MSUIUtils getIOSVersion] >= 7.0){
            [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
        }else{
            [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                          Highlight:[UIImage imageNamed:@"navbar_back"]
                             action:@selector(actNavBar_Back:)];
        }
    }
}

//设置导航栏返回按钮点击事件
-(void)actNavBar_Back:(id)sender
{
    if (!isModal && self.navigationController) {
        
        if (HUD) {
            [HUD hide:true];
        }
        
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

//设置导航栏左按钮
- (void)addNavBar_LeftBtn:(NSString*)imageName action:(SEL)action{
    if (self.navigationController) {
        if ([MSUIUtils getIOSVersion] >= 7.0){
            UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]init];
            
            [leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
            
            [leftBarButtonItem setImage:[UIImage imageNamed:imageName]];
            [leftBarButtonItem setTarget:self];
            [leftBarButtonItem setAction:action];
            
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
            
        }else{
            [self addNavBar_LeftBtn:[UIImage imageNamed:imageName]
                          Highlight:[UIImage imageNamed:imageName]
                             action:action];
        }
    }
}

//设置导航栏左按钮，自定义高亮图片
- (void)addNavBar_LeftBtn:(UIImage*)btnImage Highlight:(UIImage*)highlightImage action:(SEL)action{
    if (self.navigationController) {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        btn.frame = CGRectMake(0.0, 0.0, 44, 44);
        
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImage:highlightImage forState:UIControlStateHighlighted];
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        [leftBarButtonItem setCustomView:btn];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}

//设置导航栏左按钮，文字按钮
- (void)addNavBar_LeftBtnWithTitle:(NSString*)title action:(SEL)action{
    if (self.navigationController) {
        if ([MSUIUtils getIOSVersion] >= 7.0){
            UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]init];
            [leftBarButtonItem setTitle:title];
            [leftBarButtonItem setTarget:self];
            [leftBarButtonItem setAction:action];
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        }else{
            UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]init];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
            btn.frame = CGRectMake(0.0, 0.0, 44, 44);
            
            [btn setBackgroundColor:[UIColor clearColor]];
            //[btn setBackgroundColor:[UIColor redColor]];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:MS_RGBA(51, 128, 51, 1.0) forState:UIControlStateNormal];
            [btn setTitleColor:MS_RGBA(51, 128, 51, 0.5) forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            
            [leftBarButtonItem setCustomView:btn];
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        }
    }
}

//设置导航栏右按钮
- (void)addNavBar_RightBtn:(NSString*)imageName action:(SEL)action{
    if (self.navigationController) {
        if ([MSUIUtils getIOSVersion] >= 7.0){
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]init];
            
            [rightBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
            
            [rightBarButtonItem setImage:[UIImage imageNamed:imageName]];
            [rightBarButtonItem setTarget:self];
            [rightBarButtonItem setAction:action];
            
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        }else{
            [self addNavBar_RightBtn:[UIImage imageNamed:imageName]
                           Highlight:[UIImage imageNamed:imageName]
                              action:action];
        }
    }
}

//设置导航栏右按钮，自定义高亮图片
- (void)addNavBar_RightBtn:(UIImage*)btnImage Highlight:(UIImage*)highlightImage action:(SEL)action{
    if (self.navigationController) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        btn.frame = CGRectMake(0.0, 0.0, 44, 44);
        
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImage:highlightImage forState:UIControlStateHighlighted];
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
        [rightBarButtonItem setCustomView:btn];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

//设置导航栏右按钮，文字按钮
- (void)addNavBar_RightBtnWithTitle:(NSString*)title action:(SEL)action{
    if (self.navigationController) {
        if ([MSUIUtils getIOSVersion] >= 7.0){
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]init];
            [rightBarButtonItem setTitle:title];
            [rightBarButtonItem setTarget:self];
            [rightBarButtonItem setAction:action];
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        }else{
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]init];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            btn.frame = CGRectMake(0.0, 0.0, 66, 44);
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
            
            [btn setBackgroundColor:[UIColor clearColor]];
            //[btn setBackgroundColor:[UIColor redColor]];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:MS_RGBA(51, 128, 51, 1.0) forState:UIControlStateNormal];
            [btn setTitleColor:MS_RGBA(51, 128, 51, 0.5) forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            
            [rightBarButtonItem setCustomView:btn];
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        }
    }
}

#pragma mark - 窗体初始化 — 软键盘
//打开软键盘监听事件
- (void)openKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

//设置点击空白处关闭软键盘，需要传入UITextField等类似对象
- (void)setMainViewTapCloseKeyboard:(UIView *)view{
    viewCloseKeyboard = view;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboardAct)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

//关闭软键盘事件
- (void)closeKeyboardAct{
    if (isKeyboardShowing) {
        [viewCloseKeyboard becomeFirstResponder];
        [viewCloseKeyboard resignFirstResponder];
    }
}

//即将显示软键盘监听事件 在openKeyboardNotification进行注册事件
- (void)keyboardWillShow:(NSNotification *)notification {
    
    //NSLog(@"keyboardWillShowx");
    //if(isKeyboardShowing) return;
    
    isKeyboardShowing = true;
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    CGRect keyboardFrame;
    
    [userInfo [UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    float keyboardHeight = CGRectGetHeight(keyboardFrame);
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    [self keyboardWillShowUIToDo:keyboardHeight];
    
    
    [UIView commitAnimations];
}

//即将关闭软键盘监听事件 在openKeyboardNotification进行注册事件
- (void)keyboardWillHide:(NSNotification *)notification {
    
    //if(!isKeyboardShowing) return;
    
    isKeyboardShowing = false;
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    [self keyboardWillHideUIToDo];
    
    [UIView commitAnimations];
}

//显示软键盘处理函数，子类重写
- (void)keyboardWillShowUIToDo:(float)keyboardHeight{
    NSLog(@"super.keyboardWillShowUIToDo 子类未重写");
}

//关闭软键盘处理函数，子类重写
- (void)keyboardWillHideUIToDo{
    NSLog(@"super.keyboardWillHideUIToDo 子类未重写");
}

#pragma mark - 窗体加载进度条
- (void)showLoadingView
{
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	// Set the hud to display with a color
    if(loadingColor){
        HUD.color = loadingColor;
    }else{
        HUD.color = MS_RGBA(64, 64, 64, 0.7);
    }
	
	HUD.delegate = self;
	HUD.delegate = self;
	HUD.labelText = @"正在加载…";
    [HUD show:true];
}

- (void)closeLoadingView
{
    if (HUD) {
        [HUD hide:true];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

#pragma mark -动态对view生成加载进度条
- (UIActivityIndicatorView *)showLoadingByView:(UIView *)view Indicator:(UIActivityIndicatorView *)indicator{
    if (view) {
        if (indicator) {
            //NSLog(@"==============showLoadingByView indicator.hidden = false");
            [view bringSubviewToFront:indicator];
            indicator.hidden = false;
            [indicator startAnimating];
        }else{
            //NSLog(@"==============showLoadingByView UIActivityIndicatorView alloc");
            indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            indicator.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
            [view addSubview:indicator];
            [indicator setCenter:view.center];
            [indicator startAnimating];
        }
    }
    return indicator;
}

- (void)CloseLoadingByView:(UIActivityIndicatorView *)indicator{
    if (indicator) {
        //NSLog(@"==============CloseLoadingByView");
        [indicator stopAnimating];
        indicator.hidden = true;
    }
}

#pragma mark - 对话框
- (void)showAlert:(NSString*)title message:(NSString*)msg tag:(int)tag
{
    UIAlertView *dialog = [[UIAlertView alloc]initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    dialog.tag = tag;
    dialog.alertViewStyle = UIAlertViewStyleDefault;
    [dialog show];
}

- (void)showOKAlert:(NSString*)title tag:(int)tag
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setTitle:title];
    [dialog setDelegate:self];
    dialog.tag = tag;
    [dialog addButtonWithTitle:@"确定"];
    dialog.alertViewStyle = UIAlertViewStyleDefault;
    [dialog show];
}

- (void)showAlert:(NSString*)title
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setTitle:title];
    [dialog addButtonWithTitle:@"确定"];
    dialog.alertViewStyle = UIAlertViewStyleDefault;
    [dialog show];
}

- (void)showInputAlert:(NSString*)title message:(NSString*)msg tag:(int)tag
{
    UIAlertView *dialog = [[UIAlertView alloc]initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    dialog.tag = tag;
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog show];
}

- (void)showMessage:(NSString*)message
{
    NSLog(@"showMessage:%@", message);
    if(self && self.navigationController) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}


-(void)selectVideoPicker:(int)maximumDuration
{
    
    NSLog(@"maximumDuration=%d", maximumDuration);
    if(maximumDuration<=0) {
        maximumDuration = 8;
    }
    UIImagePickerController* pickerView = [[UIImagePickerController alloc] init];
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerView.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
    [self presentViewController:pickerView animated:YES completion:nil];
    pickerView.videoMaximumDuration = maximumDuration*60;
    pickerView.delegate = self;
}

#pragma mark - 拍照
-(void)selectPhotoPicker
{
    UIActionSheet* myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"打开照相机", @"从相册获取",nil];
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        [self showMessage:@"模拟机不能测试相机"];
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    NSLog(@"info:%@", info);
    
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [mediaType isEqualToString:@"public.movie" ])
    {
        NSURL *url =  [info objectForKey:UIImagePickerControllerMediaURL];
        if ([self respondsToSelector:@selector(pickerCallback:)])
        {
            [self performSelector:@selector(pickerCallback:) withObject:url];
        }
    } else {
        UIImage* image = [info objectForKey: UIImagePickerControllerOriginalImage];
        if ([self respondsToSelector:@selector(pickerCallback:)])
        {
            [self performSelector:@selector(pickerCallback:) withObject:image];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}



//回传UIImage对象，子类重写
- (void)pickerCallback:(UIImage *)img
{
    NSLog(@"super.pickerCallback 子类未重写");
}

#pragma mark - 应用市场
//查看应用

- (NSString*)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

//查看应用
- (void)appStore_openApp
{
    
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@&mt=8",
                     @"1023257602"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - 消息广播
- (void) postNotification:(NSString*)notification
{
    
    NSLog(@"notification:%@", notification);
    
    NSNotificationCenter * notifyCenter = [NSNotificationCenter defaultCenter];
    NSNotification *nnf = [NSNotification notificationWithName:notification object:nil];
    
    [notifyCenter postNotification:nnf];
}

-(void)phonecall:(NSString*)tel
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)openWebview:(NSString*)url
{
    NSURL * currentURL = [NSURL URLWithString:url];
    UIApplication * app = [UIApplication sharedApplication];
    if([app canOpenURL:currentURL]) {
        [app openURL:currentURL];
    }
}

#pragma mark - 创建对象
//通过storyboard 创建viewCtrl对象
- (id)newViewControllerWithIdentifier:(NSString*)identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

//通过xib 创建view对象
- (id)newViewWithNibNamed:(NSString *)name owner:(id)owner{
    NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:name owner:owner options:nil];
    return [nib1 objectAtIndex: 0];
}

-(void)showVideoConfirmAlert:(id)delegate title:(NSString*)title
{
    NSString* message = [NSString stringWithFormat:@"%@\n立即在线观看\n提示：本地下载后观看更流畅", title];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"选择观看方式" message:message delegate:delegate  cancelButtonTitle:@"取消" otherButtonTitles:@"在线观看" , nil];
    [alter show];
}

-(void)alipay:(NSString*)data
{
    NSString *appScheme = @"cusse";
    
    //data = @"_input_charset=\"utf-8\"&body=\"BODY\"&notify_url=\"http://abc.com\"&out_trade_no=\"ZTEVGVVDLN5OENL\"&partner=\"2088312492046285\"&payment_type=\"1\"&return_url=\"www.xxx.com\"&seller_id=\"2279157960@qq.com\"&service=\"mobile.securitypay.pay\"&show_url=\"www.xxx.com\"&subject=\"title\"&total_fee=\"0.01\"&sign=\"A1ugXwDOVH0u8zv308hl1LAREN6WVx%2BbqzPXIqfc7I44l7GvSbBcqqvoKt6QPju61pUMo10EKAjRebuBJ1nJlcHP1I0LyTrqZX%2B0WwmbUYR%2BnewT4UpMf0RwdvQIU60C4e6E3tuMVWKdhLKa5aUMYwmviiSjTbC7qwjZ%2BJmU9LA%3D\"&sign_type=\"RSA\"";
    
   // [AlixLibService payOrder:data AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
    
    /*
    //获取快捷支付单例并调用快捷支付接口
    AlixPay * alixpay = [AlixPay shared];
    
    int ret = [alixpay pay:data applicationScheme:appScheme];
    
    if (ret == kSPErrorAlipayClientNotInstalled) {
        
        [self showAlert:@"提示" message:@"您还没有安装支付宝快捷支付，请先安装" tag:101];
        
    }
    else if (ret == kSPErrorSignError) {
        NSLog(@"签名错误！");
        [self showAlert:@"签名错误,无法完成支付"];
    }
     */
}
/*
-(void)paymentResult:(NSString *)resultd
{
    
    NSLog(@"paymentResult:%@", resultd);
    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		
		if (result.statusCode == 9000)
        {

        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}*/

//去登录
-(void)presentToLoginView:(MSViewController*)view{
    
    UserSigninViewController *viewCtrl=[[UserSigninViewController alloc]initWithNibName:@"UserSigninViewController" bundle:nil];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    [view presentViewController:navCtrl animated:YES completion:nil];
    
}

//延迟调用
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

#pragma mark - 日期时间相关函数
//将时间戳转换成NSDate,加上时区偏移,时间位数（10位年月日，19位年月日时间）
-(NSString*)zoneChange1:(NSString*)spString bit:(int)bit{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    NSString *date=[[NSString stringWithFormat:@"%@",localeDate]substringToIndex:bit];
    
    return date;
}

//比较2个日期的大小
-(BOOL)judgeTwoDate:(NSString*)firstDate secondDate:(NSString*)secondDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *date1=[dateFormatter dateFromString:firstDate];
    NSDate *date2=[dateFormatter dateFromString:secondDate];

    NSComparisonResult result = [date1 compare:date2];
    
    //secondDate比firstDate早
    if(result==1){
        return NO;
    }
    //secondDate比firstDate晚
    else{
        return YES;
    }
    
}

//获取现在日期
-(NSString*)getNowDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date= [dateFormatter stringFromDate:[NSDate date]];
    return date;
}

//获取现在时间
-(NSString*)getNowTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *date= [dateFormatter stringFromDate:[NSDate date]];
    return date;
}

//获取某个日期的前一天或后一天 tag 1:后一天 0:前一天
-(NSString*)getLastOrNextDate:(NSString*)date tag:(int)tag{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date11=[dateFormatter dateFromString:date];
    NSDate *needDate;
    if (tag==1) {
        needDate=[NSDate dateWithTimeInterval:+(24*60*60) sinceDate:date11];
    }
    else{
        needDate=[NSDate dateWithTimeInterval:-(24*60*60) sinceDate:date11];
    }
    
    NSString *getDate=[dateFormatter stringFromDate:needDate];
    
    return getDate;
}

//获取某个日期是星期几
-(NSString*)getWeek:(NSString*)date {
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",
                       nil];
    NSDate *date11;
    if (!date) {
        date11 = [NSDate date];
    }
    else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        date11=[dateFormatter dateFromString:date];
    }
    
    NSLog(@"date===%@",date);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit |
    
    NSMonthCalendarUnit |
    
    NSDayCalendarUnit |
    
    NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit |
    
    NSMinuteCalendarUnit |
    
    NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:date11];
    
    int week = [comps weekday];
    
    NSString *weekTime=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    return weekTime;
}

//获取某个日期几天之后的日期
-(NSString*)getNextSomeDay:(NSString*)date index:(int)index{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date11=[dateFormatter dateFromString:date];
    NSDate *needDate;
    
    needDate=[NSDate dateWithTimeInterval:+(24*60*60)*index sinceDate:date11];
    
    NSString *getDate=[dateFormatter stringFromDate:needDate];
    
    return getDate;
}

//获取2个日期间隔天数
-(NSString*)getInterval:(NSString*)sdate edate:(NSString*)edate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1=[dateFormatter dateFromString:sdate];
    NSDate *date2=[dateFormatter dateFromString:edate];
    
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%d",days];
    return dateContent;
}


//是否登录
-(BOOL)isLogin{
    NSString *token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token.length==0 || !token) {
        return NO;
    }
    else{
        return YES;
    }
}


-(void)alert:(NSString*)title message:(NSString*)message cancelName:(NSString*)cancelName titleName:(NSString*)titleName tag:(int)tag{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelName otherButtonTitles:titleName, nil];
    alert.tag=tag;
    [alert show];
}

-(void)callback
{
    NSLog(@"super callback");
}

#pragma mark - 经纬度
//获取经纬度
-(void)getLocation{
    
    // 初始化并开始更新,定位
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locManager.distanceFilter = 5.0;
    
    if ([MSUIUtils getIOSVersion] >= 8.0) {
        
        NSLog(@"ios8 Location");
        [self.locManager requestWhenInUseAuthorization];
        
    }
    
    [self.locManager startUpdatingLocation];
}

// 代理方法实现
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    [self callBackByLocation:newLocation];
    [self.locManager stopUpdatingLocation];    
    
}

//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
    
    [self callBackByLocation:nil];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image imageView:(UIImageView*)imageView
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (imageView.frame.size.width / imageView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * imageView.frame.size.height / imageView.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * imageView.frame.size.width / imageView.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
//    if (!result) {
//        result=[UIImage imageNamed:@"default_bg200x200.png"];
//    }
    
    return result;
}


#pragma mark - 苹果手机版本ios？
-(float)getIOSDevice{
    float device=[[[UIDevice currentDevice] systemVersion] floatValue];
    return device;
}


@end
