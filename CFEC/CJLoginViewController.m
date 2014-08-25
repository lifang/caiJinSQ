//
//  CJLoginViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJLoginViewController.h"
#import "CJForgotPasswordController.h"
#import "CJRegisterController.h"
#import "CJAppDelegate.h"

@interface CJLoginViewController ()
@property (nonatomic, assign) CGRect focusRect;
@end

@implementation CJLoginViewController

@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;

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
    //设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = kColor(234, 234, 234, 1);
    [self setUserNameAndPasswordUI];
    [self setLoginButtonUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)login:(id)sender {
    CJRootViewController *rootC = [[CJAppDelegate shareCJAppDelegate] rootController];
    [rootC showMainController];
}
-(void)setUserNameAndPasswordUI {
    //用户名框
    UIView *userBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, 20, 20)];
    userImageView.image = [UIImage imageNamed:@"登录_03@2x.png"];
    [userBackView addSubview:userImageView];
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 130, 320, 46)];
    _usernameField.returnKeyType = UIReturnKeyDone;
    _usernameField.borderStyle = UITextBorderStyleNone;
    _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _usernameField.leftViewMode = UITextFieldViewModeAlways;
    _usernameField.leftView = userBackView;
    _usernameField.placeholder = @"输入手机号/邮箱号";
    _usernameField.font = [UIFont fontWithName:nil size:13.0f];
    _usernameField.backgroundColor = [UIColor whiteColor];
    _usernameField.delegate = self;
    [_usernameField addTarget:self action:@selector(getUserInfo) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_usernameField];
    //密码框
    UIView *psdBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    UIImageView *psdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, 20, 20)];
    psdImageView.image = [UIImage imageNamed:@"登录_03-07@2x.png"];
    [psdBackView addSubview:psdImageView];
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 177, 320, 46)];
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.secureTextEntry = YES;
    _passwordField.borderStyle = UITextBorderStyleNone;
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.leftView = psdBackView;
    _passwordField.placeholder = @"输入密码";
    _passwordField.font = [UIFont fontWithName:nil size:13.0f];
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.delegate = self;
    [self.view addSubview:_passwordField];
    
    //记住密码
    UIButton *rememberBt = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberBt.frame = CGRectMake(30, 235, 16, 16);
    rememberBt.backgroundColor = [UIColor whiteColor];
    [rememberBt addTarget:self action:@selector(rememberpassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rememberBt];
    UILabel *rememberLab = [[UILabel alloc] initWithFrame:CGRectMake(55, 227, 64, 32)];
    rememberLab.text = @"记住密码";
    rememberLab.font = [UIFont fontWithName:nil size:13.0f];
    rememberLab.textColor = kColor(135, 135, 146, 1);
    [self.view addSubview:rememberLab];
}
-(void)rememberpassword:(id)sender {
    //读取用户信息
    UIButton *bt = (UIButton *)sender;
    static BOOL rememberBool = NO;
    if (rememberBool) {
        rememberBool = NO;
        [bt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else {
        [bt setBackgroundImage:[UIImage imageNamed:@"登录_03-11@2x.png"] forState:UIControlStateNormal];
        rememberBool = YES;
    }
}
-(void)setLoginButtonUI {
    //登陆
    UIButton *loginButton= [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(0, 258, 320, 44);
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.backgroundColor = kColor(93, 201, 16, 1);
    [loginButton addTarget:self action:@selector(userLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    //找回密码
    UIButton *getBackPassWordBt = [UIButton buttonWithType:UIButtonTypeCustom];
    getBackPassWordBt.frame = CGRectMake(25, 315, 64, 32);
    [getBackPassWordBt setTitle:@"找回密码" forState:UIControlStateNormal];
    getBackPassWordBt.titleLabel.textAlignment = NSTextAlignmentLeft;
    getBackPassWordBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    getBackPassWordBt.titleLabel.textColor = [UIColor blackColor];
    [getBackPassWordBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getBackPassWordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [getBackPassWordBt addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getBackPassWordBt];
    
    //成为会员
    UIButton *becomeVIPBt = [UIButton buttonWithType:UIButtonTypeCustom];
    becomeVIPBt.frame = CGRectMake(200, 315, 100, 32);
    [becomeVIPBt setTitle:@"成为CFEC会员" forState:UIControlStateNormal];
    becomeVIPBt.titleLabel.textAlignment = NSTextAlignmentLeft;
    becomeVIPBt.titleLabel.tintColor = [UIColor blackColor];
    becomeVIPBt.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [becomeVIPBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [becomeVIPBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [becomeVIPBt addTarget:self action:@selector(becomevip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:becomeVIPBt];
    
    _focusRect = loginButton.frame;
}

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    if (isShow) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    else {
       [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark - 请求
-(void)getUserInfo
{
    //usernameField的请求事件
    NSLog(@"输入完毕");
}
#pragma mark - 登陆
-(void)userLogin:(id)sender {
    //登陆成功记住密码,根据bool值判断是否要记住密码
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"savePWD"];
    [defaults synchronize];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"userInfo.plist"];
    //    [NSKeyedArchiver archiveRootObject:_usernameField.text toFile:filename];

    CJRootViewController *rootC = [[CJAppDelegate shareCJAppDelegate] rootController];
    [rootC showMainController];

}

#pragma mark - 找回密码
-(void)forgetPassword:(id)sender {
    NSLog(@"找回密码");
    CJForgotPasswordController *forgotController = [[CJForgotPasswordController alloc] init];
    [self.navigationController pushViewController:forgotController animated:YES];
}

#pragma mark - 成为会员
-(void)becomevip:(id)sender{
    CJRegisterController *registerControl = [[CJRegisterController alloc] init];
    [self.navigationController pushViewController:registerControl animated:YES];
}
- (void)keyboardHeightChanged:(NSNotification *)notification {
    if (!([_usernameField isFirstResponder] || [_passwordField isFirstResponder])) {
        return;
    }
    NSDictionary *info = [notification userInfo];
    CGRect startFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat bottomHeight = screenHeight - _focusRect.origin.y - _focusRect.size.height;
    CGFloat offset = 0;
    NSLog(@"%@,%@",NSStringFromCGRect(startFrame),NSStringFromCGRect(endFrame));
    if (startFrame.origin.y >= screenHeight) {
        //键盘弹出
        NSLog(@"弹出");
        offset = bottomHeight - endFrame.size.height > 0 ? 0 : bottomHeight - endFrame.size.height;
    }
    else {
        if (startFrame.size.height != endFrame.size.height) {
            //键盘高度改变
            NSLog(@"改变");
            offset = startFrame.size.height - endFrame.size.height;
            
            if (fmaxf(startFrame.size.height, endFrame.size.height) < bottomHeight) {
                offset = 0;
            }
        }
        else {
            if (CGRectEqualToRect(startFrame, endFrame)) {
                //键盘切换
                offset = bottomHeight - endFrame.size.height > 0 ?
                -self.view.frame.origin.y :
                bottomHeight - endFrame.size.height - self.view.frame.origin.y;
                
            }
            else {
                NSLog(@"收回");
            }
        }
    }
    CGRect newRect = self.view.frame;
    newRect.origin.y += offset;
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = newRect;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    return YES;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//#pragma mark - textField
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    _focusRect = textField.frame;
//}
//#pragma mark - UITextFieldDelegate
//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    [self resetViewFrame];
//    return YES;
//}
//#pragma mark - keyboard
//-(void)keyboardWillShow:(NSNotification *)notification {
//    NSLog(@"%@",[notification userInfo]);
//    if ([_usernameField isFirstResponder]||[_passwordField isFirstResponder]) {
//        NSDictionary *info = [notification userInfo];
//        CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        int offset = kScreenHeight - 347 - kbRect.size.height;
//        if (offset < 0) {
//            [UIView animateWithDuration:0.3 animations:^{
//                CGRect rect = self.view.frame;
//                rect.origin.y -= (-offset);
//                self.view.frame = rect;
//            }];
//        }
//    }
//}
//-(void)resetViewFrame {
//    [UIView animateWithDuration:0.3 animations:^{
//        CGFloat originY = 0;
//        CGRect rect = CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height);
//        self.view.frame = rect;
//    }];
//}
@end
