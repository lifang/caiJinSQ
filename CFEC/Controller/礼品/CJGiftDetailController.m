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

-(void)initUI {
    self.navigationItem.title = @"礼品详情";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 37)];
    _scrollView.backgroundColor = kColor(250, 250, 250, 1);
    [self.view addSubview:_scrollView];
    
    _giftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 320, 20)];
    _giftNameLabel.text = self.giftModel.name;
    [_scrollView addSubview:_giftNameLabel];
    
    _giftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 46, 280, 180)];
    [self downloadDetailImageWithURL:_giftModel.picture];
    [_scrollView addSubview:_giftImage];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 236, 160, 20)];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = [NSString stringWithFormat:@"￥ %@",self.giftModel.price];
    [_scrollView addSubview:_priceLabel];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(190, 241, 15, 15)];
    img1.image = [UIImage imageNamed:@"礼品资料_03@2x.png"];
    [_scrollView addSubview:img1];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(208, 240, 30, 15)];
    label1.font = [UIFont systemFontOfSize:11.0f];
    label1.text = @"礼品";
    [_scrollView addSubview:label1];
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 241, 15, 15)];
    img2.image = [UIImage imageNamed:@"礼品资料_03@2x.png"];
    [_scrollView addSubview:img2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(268, 240, 50, 15)];
    label2.font = [UIFont systemFontOfSize:11.0f];
    label2.text = @"可用积分";
    [_scrollView addSubview:label2];
    
    UIView *whiteLine = [[UIView alloc] initWithFrame:CGRectMake(10, 260, 300, 2)];
    whiteLine.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    [_scrollView addSubview:whiteLine];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 300, 20)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:15];
    title.text = @"商品信息";
    [_scrollView addSubview:title];
    
    _giftDiscribe = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, 300, 100)];
    _giftDiscribe.font = [UIFont systemFontOfSize:15];
    _giftDiscribe.layer.borderWidth = 1;
    _giftDiscribe.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    _giftDiscribe.layer.cornerRadius = 4;
    _giftDiscribe.layer.masksToBounds = YES;
    _giftDiscribe.numberOfLines = 0;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIFont systemFontOfSize:15],NSFontAttributeName,
                          nil];
    CGRect rect = [_giftModel.describe boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:dict
                                                    context:nil];
    _giftDiscribe.frame = CGRectMake(10, 300, 300 + 2, rect.size.height + 2);
    _giftDiscribe.text = self.giftModel.describe;
    _giftDiscribe.textColor = [UIColor blackColor];
    [_scrollView addSubview:_giftDiscribe];
    _scrollView.contentSize = CGSizeMake(300, _giftDiscribe.frame.origin.y + _giftDiscribe.frame.size.height);
    
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

- (void)downloadDetailImageWithURL:(NSString *)urlstring {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:urlstring];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                _giftImage.frame = [self positionWithSize:image.size];
                _giftImage.image = image;
            }
        });
    });
}

- (CGRect)positionWithSize:(CGSize)size {
    CGFloat maxHeight = 180;
    CGFloat maxWidth = 320;
    CGRect rect = CGRectMake((320 - size.width) / 2, 46, size.width, size.height);
    if (size.height > maxHeight) {
        rect.size.height = maxHeight;
        rect.size.width = size.width / size.height * maxHeight;
        rect.origin.x = (320 - rect.size.width) / 2;
        size.width = rect.size.width;
        size.height = rect.size.height;
    }
    if (size.width > maxWidth) {
        rect.size.width = maxWidth;
        rect.size.height = size.height / size.width * maxWidth;
        rect.origin.x = 0;
        size.width = rect.size.width;
        size.height = rect.size.height;
    }
    return rect;
}

-(void)buy:(id)sender {
    CJOrderController *orderControl = [[CJOrderController alloc] init];
    orderControl.giftModel = self.giftModel;
    [self.navigationController pushViewController:orderControl animated:YES];
}
@end
