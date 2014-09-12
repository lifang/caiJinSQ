//
//  CJGiftDetailController.m
//  CFEC
//
//  Created by SumFlower on 14-9-4.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGiftDetailController.h"
#import "CJOrderController.h"

@interface CJGiftDetailController ()
@property (nonatomic, strong) UILabel *giftNameLabel;//礼品名称
@property (nonatomic, strong) UIImageView *giftImage;//礼品图片
@property (nonatomic, strong) UILabel *priceLabel;//价格
@property (nonatomic, strong) UILabel *giftDiscribe;//礼品描述
@property (nonatomic, strong) UIButton *buyButton;//立即购买
@end

@implementation CJGiftDetailController

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"礼品详情";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    _giftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, 320, 20)];
    _giftNameLabel.text = self.giftModel.name;
    [self.view addSubview:_giftNameLabel];
    
    _giftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 110, 280, 180)];
    NSURL *imgUrl = [NSURL URLWithString:self.giftModel.picture];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    _giftImage.image = [UIImage imageWithData:imgData];
    [self.view addSubview:_giftImage];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 160, 20)];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = [NSString stringWithFormat:@"￥ %@",self.giftModel.price];
    [self.view addSubview:_priceLabel];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(190, 305, 15, 15)];
    img1.image = [UIImage imageNamed:@"礼品资料_03@2x.png"];
    [self.view addSubview:img1];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(208, 304, 30, 15)];
    label1.font = [UIFont systemFontOfSize:11.0f];
    label1.text = @"礼品";
    [self.view addSubview:label1];
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 305, 15, 15)];
    img2.image = [UIImage imageNamed:@"礼品资料_03@2x.png"];
    [self.view addSubview:img2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(268, 304, 50, 15)];
    label2.font = [UIFont systemFontOfSize:11.0f];
    label2.text = @"可用积分";
    [self.view addSubview:label2];
    
    self.giftDiscribe = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 300, 100)];
//    [_giftDiscribe loadHTMLString:self.giftModel.content baseURL:nil];
//    _giftDiscribe.editable = NO;
//    _giftDiscribe.numberOfLines = 0;
    _giftDiscribe.text = self.giftModel.describe;
    _giftDiscribe.textColor = [UIColor blackColor];
    NSLog(@"!!!%@",_giftDiscribe.text);
    [self.view addSubview:_giftDiscribe];
    
    //两个button
    UIView *bottomView = [[UIView alloc] init];
    bottomView.layer.frame = CGRectMake(0, kScreenHeight - 37, 320, 37);
    bottomView.layer.backgroundColor = kColor(232, 250, 210, 1).CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0, 3);//阴影偏移量
    bottomView.layer.shadowRadius = 10.0f;//阴影半径
    bottomView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    bottomView.layer.shadowOpacity = 1.0f;
    [self.view addSubview:bottomView];
    
    //立即报名
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.frame = CGRectMake(100, 5, 120, 30);
    [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [_buyButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    _buyButton.layer.borderWidth = 1.0f;
    _buyButton.layer.cornerRadius = 8.0f;
    _buyButton.layer.borderColor = [UIColor greenColor].CGColor;
    _buyButton.layer.masksToBounds = YES;
    [bottomView addSubview:_buyButton];

}
-(void)buy:(id)sender {
    CJOrderController *orderControl = [[CJOrderController alloc] init];
    orderControl.giftModel = self.giftModel;
    [self.navigationController pushViewController:orderControl animated:YES];
}
@end
