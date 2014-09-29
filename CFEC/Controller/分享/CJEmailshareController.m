//
//  CJEmailshareController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJEmailshareController.h"
#import <MessageUI/MessageUI.h>

@interface CJEmailshareController () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UITextField *emailTextfield;
@property (nonatomic, strong) UIButton *sendBt;
@end

@implementation CJEmailshareController
@synthesize emailTextfield = _emailTextfield;
@synthesize sendBt = _sendBt;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"填写邮箱";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initUI {
    _emailTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 74, 280, 30)];
//    _emailTextfield.backgroundColor = [UIColor greenColor];
    _emailTextfield.placeholder = @"name@web.com";
    [self.view addSubview:_emailTextfield];
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(20, 104, 280, 1)];
    lineview.backgroundColor = kColor(221, 221, 221, 1);
    [self.view addSubview:lineview];
    _sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBt.backgroundColor = kColor(130, 130, 130, 1);
    _sendBt.frame = CGRectMake(70, 134, 180, 40);
    _sendBt.layer.cornerRadius = 8.0;
    [_sendBt setTitle:@"确认发送邀请" forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_sendBt addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBt];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)sendEmail:(id)sender {
    if ([self isValidateEmail:_emailTextfield.text]) {
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (!mailClass) {
            [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
            return;
        }
        if (![mailClass canSendMail]) {
            [self alertWithMessage:@"用户没有设置邮件账户"];
            return;
        }
        [self displayMailPicker];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮箱格式不正确" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
-(void)alertWithMessage:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"CFEC"];
    //添加收件人
    NSString *emailStr = [NSString stringWithFormat:@"%@",_emailTextfield.text];
    NSArray *toRecipients = [NSArray arrayWithObject: emailStr];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送

    //添加密送

    
    // 添加一张图片
    UIImage *addPic = [UIImage imageNamed: @"Icon29@2x.png"];
    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件

    
    NSString *emailBody = @"<font color='red'>eMail</font> http://as.baidu.com/a/item?docid=4951602&pre=web_am_se";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}
#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"发送成功";
            break;
        case MFMailComposeResultFailed:
            msg = @"保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    [self alertWithMessage:msg];
}
//判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
