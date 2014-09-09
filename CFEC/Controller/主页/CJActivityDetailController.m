//
//  CJActivityDetailController.m
//  CFEC
//
//  Created by SumFlower on 14-8-26.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJActivityDetailController.h"
#import "CJSupplyController.h"
#import "WXApiObject.h"
#import "WXApi.h"

#define startHeight 10
@interface CJActivityDetailController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView *mainScrooll;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *themeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *inviteLabel;
@property (nonatomic, strong) UILabel *activityThemeLabel;//活动主题
@property (nonatomic, strong) UILabel *activityTimeLabel;//活动时间
@property (nonatomic, strong) UILabel *activityPlaceLabel;//活动地点
@property (nonatomic, strong) UILabel *activityInviteLabel;//邀请对象
@property (nonatomic, strong) UILabel *detailContentText;//具体内容
@property (nonatomic, strong) UIButton *supplyBt;//立即报名
@property (nonatomic, strong) UIButton *contactBt;//联系我们

@end

@implementation CJActivityDetailController

@synthesize titleImage = _titleImage;
@synthesize themeLabel = _themeLabel;
@synthesize timeLabel = _timeLabel;
@synthesize placeLabel = _placeLabel;
@synthesize inviteLabel = _inviteLabel;
@synthesize activityTimeLabel = _activityTimeLabel;
@synthesize activityPlaceLabel = _activityPlaceLabel;
@synthesize activityInviteLabel = _activityInviteLabel;
@synthesize detailContentText = _detailContentText;
@synthesize supplyBt = _supplyBt;
@synthesize contactBt = _contactBt;

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
    self.navigationItem.title = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavBarItemWithImageName:@"订单_03-05@2x"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 270-64)];
    NSURL *url = [NSURL URLWithString:_activityModel.pictures];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imageData];
    _titleImage.image = img;
    _titleImage.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_titleImage];
    
    //scrollview
    //文本高度

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.0f],NSFontAttributeName, nil];
    CGRect rect = [self.activityModel.mobileContent boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    NSLog(@" rect =%@, %f,%f",self.activityModel.mobileContent,rect.size.height,rect.size.width);
    _mainScrooll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 206, 320, kScreenHeight - 206 - 37)];
    _mainScrooll.contentSize = CGSizeMake(320, 151 + rect.size.height);
    _mainScrooll.backgroundColor = [UIColor whiteColor];
//    _mainScrooll.pagingEnabled = YES;
    _mainScrooll.showsHorizontalScrollIndicator = NO;
    _mainScrooll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrooll];
    
    _themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, startHeight, 50, 20)];
    _themeLabel.text = @"活动主题";
    _themeLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_themeLabel];
    
    _activityThemeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, startHeight, self.view.frame.size.width - 70, 20)];
    _activityThemeLabel.text = _activityModel.title;
    _activityThemeLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_activityThemeLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _themeLabel.frame.origin.y + _themeLabel.frame.size.height, 50, 20)];
    _timeLabel.text = @"活动时间";
    _timeLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_timeLabel];
    
    _activityTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, _themeLabel.frame.origin.y + _themeLabel.frame.size.height, self.view.frame.size.width - 70, 20)];
    _activityTimeLabel.text = [NSString stringWithFormat:@"%@--%@",_activityModel.startTime,_activityModel.endTime];
    _activityTimeLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_activityTimeLabel];
    
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _timeLabel.frame.origin.y + _timeLabel.frame.size.height, 50, 20)];
    _placeLabel.text = @"活动地点";
    _placeLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_placeLabel];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(70,_timeLabel.frame.origin.y + _timeLabel.frame.size.height + 2 , 15, 15)];
    image.image= [UIImage imageNamed:@"活动2_03@2x.png"];
    [_mainScrooll addSubview:image];
    
    _activityPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, _timeLabel.frame.origin.y + _timeLabel.frame.size.height, self.view.frame.size.width - 85, 20)];
    _activityPlaceLabel.text = _activityModel.meetingAddress;
    _activityPlaceLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_activityPlaceLabel];
    
    
    _inviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _placeLabel.frame.origin.y + _placeLabel.frame.size.height, 50, 20)];
    _inviteLabel.text = @"邀请对象";
    _inviteLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_inviteLabel];
    
    _activityInviteLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, _placeLabel.frame.origin.y + _placeLabel.frame.size.height, self.view.frame.size.width - 70, 20)];
    _activityInviteLabel.text = _activityModel.inviteTarget;
    _activityInviteLabel.font = [UIFont systemFontOfSize:11.0f];
    [_mainScrooll addSubview:_activityInviteLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, _inviteLabel.frame.origin.y + _inviteLabel.frame.size.height + 10, 280, 1)];
    lineView.backgroundColor = kColor(215, 214, 214, 1);
    [_mainScrooll addSubview:lineView];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(20, lineView.frame.origin.y + 1, 100, 40)];
    detail.text = @"活动详情";
    detail.font = [UIFont systemFontOfSize:13.0f];
    [_mainScrooll addSubview:detail];
    
    _detailContentText = [[UILabel alloc] initWithFrame:CGRectMake(20, detail.frame.origin.y + detail.frame.size.height + 10, 280, rect.size.height)];
    _detailContentText.font = [UIFont systemFontOfSize:13.0f];
    _detailContentText.text = _activityModel.mobileContent;
    _detailContentText.numberOfLines = 0;
//    _detailContentText.editable = NO;
//    _detailContentText.userInteractionEnabled = NO;
//    _detailContentText.scrollEnabled = YES;
    [_mainScrooll addSubview:_detailContentText];
//    [self textViewSuoJin:_detailContentText];
    
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
    _supplyBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _supplyBt.frame = CGRectMake(35, 5, 120, 30);
    [_supplyBt setTitle:@"立即报名" forState:UIControlStateNormal];
    [_supplyBt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_supplyBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_supplyBt addTarget:self action:@selector(supply:) forControlEvents:UIControlEventTouchUpInside];
    _supplyBt.layer.borderWidth = 1.0f;
    _supplyBt.layer.cornerRadius = 8.0f;
    _supplyBt.layer.borderColor = [UIColor greenColor].CGColor;
    _supplyBt.layer.masksToBounds = YES;
    [bottomView addSubview:_supplyBt];
    
    //联系我们
    _contactBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _contactBt.frame = CGRectMake(170, 5, 120, 30);
    [_contactBt setTitle:@"联系我们" forState:UIControlStateNormal];
    [_contactBt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_contactBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_contactBt addTarget:self action:@selector(contact:) forControlEvents:UIControlEventTouchUpInside];
    _contactBt.layer.borderWidth = 1.0f;
    _contactBt.layer.cornerRadius = 8.0f;
    _contactBt.layer.borderColor = [UIColor greenColor].CGColor;
    _contactBt.layer.masksToBounds = YES;
    [bottomView addSubview:_contactBt];

    
}
//textview首行缩进
-(void)textViewSuoJin:(UITextView *)textview
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 20.0f;
    paragraphStyle.maximumLineHeight = 15.0f;
    paragraphStyle.minimumLineHeight = 15.0f;
    paragraphStyle.firstLineHeadIndent = 20.0f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:kColor(76, 75, 71, 1)};
    textview.attributedText = [[NSAttributedString alloc] initWithString:_activityModel.mobileContent attributes:attributes];
}
#pragma mark - button
-(void)supply:(id)sender {
    CJSupplyController *supplyControl = [[CJSupplyController alloc] init];
    supplyControl.activity = _activityModel;
    [self.navigationController pushViewController:supplyControl animated:YES];
}
-(void)contact:(id)sender {
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
-(void)setRightNavBarItemWithImageName:(NSString *)name {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    [rightButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}
#pragma mark -- 分享
-(void)share:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"转发给微信好友",@"转发给微博好友", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
}
#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 0) {
        //分享给微信好友
    }
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
