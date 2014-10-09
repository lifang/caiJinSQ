//
//  CJSendToFriendController.m
//  CFEC
//
//  Created by SumFlower on 14-10-9.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJSendToFriendController.h"
#import "CJRequestFormat.h"
@interface CJSendToFriendController ()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UIButton *sendBt;
@end

@implementation CJSendToFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邀请";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initUI {
    _name = [[UILabel alloc] initWithFrame:CGRectMake(40, 84, 80, 30)];
    _name.text = [NSString stringWithFormat:@"%@",_addressModel.addressChinese];
    [self.view addSubview:_name];
    _phone = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x + _name.frame.size.width, _name.frame.origin.y, self.view.frame.size.width - _phone.frame.origin.x, _name.frame.size.height)];
    _phone.text = [NSString stringWithFormat:@"%@",_addressModel.addressPhone];
    [self.view addSubview:_phone];
    
    _sendBt= [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBt.frame = CGRectMake(0, _name.frame.origin.y + _name.frame.size.height + 50, 320, 44);
    [_sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_sendBt setTitle:@"确认邀请" forState:UIControlStateNormal];
    _sendBt.backgroundColor = kColor(93, 201, 16, 1);
    [_sendBt addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBt];
}
-(void)send:(UIButton *)bt {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_phone.text forKey:@"addressbook"];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [CJRequestFormat inviteFriend:jsonStr finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            [self returnAlert:@"邀请成功"];
        }else if (status == 1) {
            [self returnAlert:@"网络故障"];
        }else if (status == 2) {
            [self returnAlert:@"请求成功返回出错"];
        }
    }];
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
