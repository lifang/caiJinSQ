//
//  CJMessageDetail.m
//  CFEC
//
//  Created by SumFlower on 14-10-24.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJMessageDetail.h"

@interface CJMessageDetail ()

@end

@implementation CJMessageDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kDevice > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.text = self.message.content;
    self.navigationItem.title = self.message.title;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];

    // Do any additional setup after loading the view from its nib.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
