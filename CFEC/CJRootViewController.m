//
//  CJRootViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJRootViewController.h"
#import "CJLoginViewController.h"
#import "CJMainViewController.h"
#import "CJLeftViewController.h"
#import "CJAppDelegate.h"
#import "CJRequestFormat.h"
#import "CJActivityModel.h"

@interface CJRootViewController ()<UIAlertViewDelegate>

{
    NSMutableArray *activityArr0;//财务沙龙
    NSMutableArray *activityArr1;//财智学院
    NSMutableArray *activityArr2;//行业峰会
    NSMutableArray *activityArr3;//乐活节
    NSMutableArray *activityArr4;//商务学院
    NSMutableArray *activityArr5;//税务学院
    NSMutableArray *activityArr6;
    NSMutableArray *lastArray;//当前显示的活动数组
    
}


@property (strong, nonatomic) CJMainViewController *mainC;
@end

@implementation CJRootViewController

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
    // Do any additional setup after loading the view.
    
    UIImageView *backImgeView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    if (fabsf(self.view.frame.size.height) == 568) {
        backImgeView.image = [UIImage imageNamed:@"1136.png"];
    }else {
        backImgeView.image = [UIImage imageNamed:@"960.png"];
    }
    
    [self.view addSubview:backImgeView];
    
    //获取活动信息
    [self GetActivityMessage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login View Controller

- (void)setLoginController {

    CJLoginViewController *loginC = [[CJLoginViewController alloc] init];
    _loginNav = [[UINavigationController alloc] initWithRootViewController:loginC];
    [CJAppDelegate setNavigationBarTinColor:_loginNav];

    _loginNav.view.frame = self.view.bounds;
    [self.view addSubview:_loginNav.view];
}

- (void)showMainController {
    CJLeftViewController *leftC = [[CJLeftViewController alloc] init];
    UINavigationController *navL = [[UINavigationController alloc] initWithRootViewController:leftC];
    
    _mainC = [[CJMainViewController alloc] init];
    
    _navController = [[MMDrawerController alloc] initWithCenterViewController:_mainC
                                                     leftDrawerViewController:navL];
    [_navController setMaximumLeftDrawerWidth:220];
    [_navController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_navController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapCenterView | MMCloseDrawerGestureModePanningCenterView];
    _navController.view.frame = self.view.bounds;
    [self.view addSubview:_navController.view];
}

- (void)showLoginController {
    
    if (_navController) {
        [UIView beginAnimations:@"disappear" context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _navController.view.transform = CGAffineTransformMakeTranslation(320, 0);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(disappearMainController)];
        [UIView commitAnimations];
    }
}

#pragma mark - Animation

- (void)disappearMainController {
    [_navController.view removeFromSuperview];
    _navController = nil;
}
-(BOOL)getLoginState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *rememberbool = [userDefaults objectForKey:@"savePWD"];
    return [rememberbool boolValue];
}
-(void)getLoginUserInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDiectory = paths[0];
    NSString *savefile = [documentDiectory stringByAppendingPathComponent:@"userFile.plist"];
    CJUserModel *loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile:savefile];
    
    NSString *imageStr = [NSString stringWithFormat:@"%@",loginUser.headPhotoUrl];
    
    NSURL *url = [[NSURL alloc] initWithString:imageStr];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    loginUser.headImage = data;
    [CJAppDelegate shareCJAppDelegate].user = loginUser;
}
-(void)GetActivityMessage {
    
    activityArr0 = [NSMutableArray array];
    activityArr1 = [NSMutableArray array];
    activityArr2 = [NSMutableArray array];
    activityArr3 = [NSMutableArray array];
    activityArr4 = [NSMutableArray array];
    activityArr5 = [NSMutableArray array];
    activityArr6 = [NSMutableArray array];
    lastArray = [NSMutableArray array];
    [CJRequestFormat getActivityTitleFinished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSError *error;
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *titleActivityArray = [NSMutableArray array];
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *receiveArray = (NSArray *)jsonObject;
                for (int i = 0; i<receiveArray.count; i++) {
                    NSDictionary *dic = [receiveArray objectAtIndex:i];
                    CJActivityModel *activityModel = [[CJActivityModel alloc] init];
                    activityModel.activityGenre = [dic objectForKey:@"activityGenre"];
                    activityModel.activityType = [dic objectForKey:@"activityType"];
                    activityModel.commonCost = [dic objectForKey:@"commonCost"];
                    activityModel.diamondCost = [dic objectForKey:@"diamondCost"];
                    activityModel.endTime = [dic objectForKey:@"endTime"];
                    activityModel.goldCost = [dic objectForKey:@"goldCost"];
                    activityModel.ID = [dic objectForKey:@"id"];
                    activityModel.inviteTarget = [dic objectForKey:@"inviteTarget"];
                    activityModel.meetingAddress = [dic objectForKey:@"meetingAddress"];
                    activityModel.meetingCost = [dic objectForKey:@"meetingCost"];
                    activityModel.meetingNumber = [dic objectForKey:@"meetingNumber"];
                    activityModel.mobileContent = [dic objectForKey:@"mobileContent"];
                    activityModel.picture = [dic objectForKey:@"picture"];
                    activityModel.pictures = [dic objectForKey:@"pictures"];
                    activityModel.platinumCost = [dic objectForKey:@"platinumCost"];
                    activityModel.startTime = [dic objectForKey:@"startTime"];
                    activityModel.title = [dic objectForKey:@"title"];
                    [titleActivityArray addObject:activityModel];
                    //                    NSLog(@"%@",activityModel.activityGenre);
                }
                [CJAppDelegate shareCJAppDelegate].allActivityArray = titleActivityArray;
                NSLog(@"count:%d",titleActivityArray.count);
                for (int i = 0; i<titleActivityArray.count;i++) {
                    CJActivityModel *activity = titleActivityArray[i];
                    if ([activity.activityGenre isEqualToString:@"0"]) {
                        [activityArr0 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"1"]) {
                        [activityArr1 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"2"]) {
                        [activityArr2 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"3"]) {
                        [activityArr3 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"4"]) {
                        [activityArr4 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"5"]){
                        [activityArr5 addObject:activity];
                    }else if ([activity.activityGenre isEqualToString:@"6"]){
                        [activityArr6 addObject:activity];
                    }
                }
                //                NSLog(@"count: %d,%d,%d,%d,%d,%d",activityArr0.count,activityArr1.count,activityArr2.count,activityArr3.count,activityArr4.count,activityArr5.count);
            }
            [self getLastArr];
            [[CJAppDelegate shareCJAppDelegate] homeController].newsArray = _newsArray;
            if ([self getLoginState]) {
                //直接登录获取用户信息
                [self getLoginUserInfo];
                [self showMainController];
            }else {
                [self setLoginController];
            }
        }else if (status == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络故障" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alert.tag = 100;
            [alert show];
        }else if (status == 2) {
            [self returnAlert:@"服务请求出错"];
        }
    }];
}
- (NSArray *)getLastArrWay:(NSArray *)contactList {
    return [contactList sortedArrayUsingComparator:^NSComparisonResult(CJActivityModel *model1, CJActivityModel *model2) {
        NSDate *date1 = [self dateWithString:model1.startTime];
        NSDate *date2 = [self dateWithString:model2.startTime];
        NSComparisonResult result = [date1 compare:date2];
        return result;
    }];
}
- (NSDate *)dateWithString:(NSString *)string {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format dateFromString:string];
}
-(void)getLastArr {
    NSArray *paixuarr0 = [self getLastArrWay:activityArr0];
    NSArray *paixuarr1 = [self getLastArrWay:activityArr1];
    NSArray *paixuarr2 = [self getLastArrWay:activityArr2];
    NSArray *paixuarr3 = [self getLastArrWay:activityArr3];
    NSArray *paixuarr4 = [self getLastArrWay:activityArr4];
    NSArray *paixuarr5 = [self getLastArrWay:activityArr5];
    NSArray *paixuarr6 = [self getLastArrWay:activityArr6];
    _newsArray = [NSMutableArray array];
    if ([paixuarr0 count] > 0) {
        [_newsArray addObject:[paixuarr0 objectAtIndex:0]];
    }
    if ([paixuarr1 count] > 0) {
        [_newsArray addObject:[paixuarr1 objectAtIndex:0]];
    }
    if ([paixuarr2 count] > 0) {
        [_newsArray addObject:[paixuarr2 objectAtIndex:0]];
    }
    if ([paixuarr3 count] > 0) {
        [_newsArray addObject:[paixuarr3 objectAtIndex:0]];
    }
    if ([paixuarr4 count] > 0) {
        [_newsArray addObject:[paixuarr4 objectAtIndex:0]];
    }
    if ([paixuarr5 count] > 0) {
        [_newsArray addObject:[paixuarr5 objectAtIndex:0]];
    }
    if([paixuarr6 count] > 0) {
        [_newsArray addObject:[paixuarr6 objectAtIndex:0]];
    }
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self setLoginController];
    }
}
@end
