//
//  CJGiftController.m
//  CFEC
//
//  Created by SumFlower on 14-8-22.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGiftController.h"
#import "CJAllgiftController.h"
#import "CJHouseholdController.h"
#import "CJLifeController.h"
#import "CBookController.h"
#import "CJHotGoodController.h"
#import "CJServiceController.h"
@interface CJGiftController ()
@property (nonatomic, strong) UIButton *allGiftBt;//全部礼物
@property (nonatomic, strong) UIButton *applianceBt;//数码家电
@property (nonatomic, strong) UIButton *lifeBt;//品质生活
@property (nonatomic, strong) UIButton *bookBt;//书籍分享
@property (nonatomic, strong) UIButton *hotGiftBt;//热门礼物
@property (nonatomic, strong) UIButton *serviceBt;//专业服务

@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation CJGiftController

@synthesize allGiftBt = _allGiftBt;
@synthesize applianceBt = _applianceBt;
@synthesize lifeBt = _lifeBt;
@synthesize bookBt = _bookBt;
@synthesize hotGiftBt = _hotGiftBt;
@synthesize serviceBt = _serviceBt;

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
    self.navigationItem.title = @"礼品";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -12, self.view.frame.size.width, kScreenHeight - 40)];
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, 134 + 382 - 84 );
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroll];
    
    _allGiftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _allGiftBt.frame = CGRectMake(15, 84-40-10, 134, 134);
    [_allGiftBt setBackgroundImage:[UIImage imageNamed:@"礼品_03-06@2x.png"] forState:UIControlStateNormal];
    [_allGiftBt addTarget:self action:@selector(allGiftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_allGiftBt];
    
    _applianceBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _applianceBt.frame = CGRectMake(164, 84-40-10, 134, 134);
    [_applianceBt setBackgroundImage:[UIImage imageNamed:@"礼品_03@2x.png"] forState:UIControlStateNormal];
    [_applianceBt addTarget:self action:@selector(applianceAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_applianceBt];
    
    _lifeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _lifeBt.frame = CGRectMake(15, 233-40-10, 134, 134);
    [_lifeBt setBackgroundImage:[UIImage imageNamed:@"礼品_03-11@2x.png"] forState:UIControlStateNormal];
    [_lifeBt addTarget:self action:@selector(lifeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_lifeBt];
    
    _bookBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _bookBt.frame = CGRectMake(164, 233-40-10, 134, 134);
    [_bookBt setBackgroundImage:[UIImage imageNamed:@"礼品_03-13@2x.png"] forState:UIControlStateNormal];
    [_bookBt addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_bookBt];
    
    _hotGiftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _hotGiftBt.frame = CGRectMake(15, 382-40-10, 134, 134);
    [_hotGiftBt setBackgroundImage:[UIImage imageNamed:@"礼品_03-17@2x.png"] forState:UIControlStateNormal];
    [_hotGiftBt addTarget:self action:@selector(hotGiftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_hotGiftBt];
    
    _serviceBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _serviceBt.frame = CGRectMake(164, 382-40-10, 134, 134);
    [_serviceBt setBackgroundImage:[UIImage imageNamed:@"礼品_03-19@2x.png"] forState:UIControlStateNormal];
    [_serviceBt addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_serviceBt];


}
#pragma mark -Actions
-(void)allGiftAction:(id)sender {
    CJAllgiftController *giftControl = [[CJAllgiftController alloc] init];
    giftControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:giftControl animated:YES];
}
-(void)applianceAction:(id)sender {
    CJHouseholdController *householdControl = [[CJHouseholdController alloc] init];
    householdControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:householdControl animated:YES];
}
-(void)lifeAction:(id)sender {
    CJLifeController *lifeControl = [[CJLifeController alloc] init];
    lifeControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lifeControl animated:YES];
}
-(void)bookAction:(id)sender {
    CBookController *bookControl = [[CBookController alloc] init];
    bookControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bookControl animated:YES];
}
-(void)hotGiftAction:(id)sender {
    CJHotGoodController *hotgoodControl = [[CJHotGoodController alloc] init];
    hotgoodControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotgoodControl animated:YES];
}
-(void)serviceAction:(id)sender {
    CJServiceController *serviceControl = [[CJServiceController alloc] init];
    serviceControl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:serviceControl animated:YES];
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

@end
