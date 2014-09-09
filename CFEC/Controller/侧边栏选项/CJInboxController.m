//
//  CJInboxController.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJInboxController.h"
#import "CJAppDelegate.h"
#import "CJMainViewController.h"
@interface CJInboxController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arr;
}
@property (nonatomic, strong) UITableView *emailTable;
@end

@implementation CJInboxController
@synthesize  emailTable =_emailTable;
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
    arr = [[NSMutableArray alloc] initWithObjects:@"您刚刚报名参加了一项活动",@"您刚刚报名参加了一项活动",@"您刚刚报名参加了一项活动", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.navigationItem.title = @"收件箱";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavBarItemWithImageName];
    _emailTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _emailTable.delegate = self;
    _emailTable.dataSource = self;
    [self.view addSubview:_emailTable];
    [self hiddenExtraCellLine];

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
    CJMainViewController *mainC = [[CJMainViewController alloc] init];
    [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:mainC withCloseAnimation:YES completion:nil];
}
-(void)setRightNavBarItemWithImageName {
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(edit:)];
    rightbutton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightbutton;
}
-(void)edit:(id)sender {
     static BOOL change = NO;
    _emailTable.editing = change;
    change = !change;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *first = @"first";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:first];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:first];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, cell.contentView.frame.size.width - 40, 40)];
    [cell.contentView addSubview:label];
    label.text = arr[indexPath.row];
    return cell;
}
- (void)hiddenExtraCellLine {
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [_emailTable setTableFooterView:view];
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [arr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
@end
