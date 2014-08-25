//
//  CJLoginViewController.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJLoginViewController.h"
#import "CJAppDelegate.h"

@interface CJLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) CGRect focusRect;

@end

@implementation CJLoginViewController

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 200, 80, 40);
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSArray *items = [NSArray arrayWithObjects:@"时间",@"2",@"3",@"4", nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:items];
    seg.frame = CGRectMake(10, 240, 300, 30);
    [seg setImage:[UIImage imageNamed:@"back.png"] forSegmentAtIndex:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 75, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"时间";
    label.textColor = seg.tintColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 111;
    [seg addSubview:label];
    [self.view addSubview:seg];
    [seg addTarget:self action:@selector(touch:) forControlEvents:UIControlEventValueChanged];
    NSLog(@"");
//    seg.selectedSegmentIndex = 0;
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(120, 400, 80, 40)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.delegate = self;
    [self.view addSubview:text];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHeightChanged:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
}

- (void)touch:(UISegmentedControl *)seg {
    UILabel *label = (UILabel *)[seg viewWithTag:111];
    if (seg.selectedSegmentIndex == 1) {
        label.textColor = [UIColor whiteColor];
    }
    else {
        label.textColor = seg.tintColor;
        NSLog(@"%d",seg.selectedSegmentIndex);
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardHeightChanged:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect startFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat bottomHeight = screenHeight - _focusRect.origin.y - _focusRect.size.height;
    CGFloat offset = 0;
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

#pragma mark - textField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _focusRect = textField.frame;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    return YES;
}

#pragma mark - Action

- (IBAction)login:(id)sender {
    CJRootViewController *rootC = [[CJAppDelegate shareCJAppDelegate] rootController];
    [rootC showMainController];
}

@end