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
#import "CJUserModel.h"
#import "CJRequestFormat.h"
#import "CJMessageModel.h"
#import "CJMessageDetail.h"
@interface CJInboxController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CJUserModel *user;
    NSMutableArray *arr;
    NSMutableArray *dataArray;
}
@property (nonatomic, strong) UITableView *emailTable;
@property (nonatomic, assign)  BOOL change;
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
    user = [CJAppDelegate shareCJAppDelegate].user;
    _change = YES;
    dataArray = [NSMutableArray array];
    arr = [[NSMutableArray alloc] initWithObjects:@"您刚刚报名参加了一项活动",@"您刚刚报名参加了一项活动",@"您刚刚报名参加了一项活动", nil];
    [self getInterMessage];
    [self initUI];
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
    _emailTable.editing = _change;
    _change = !_change;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CJMessageDetail *messageC = [[CJMessageDetail alloc] initWithNibName:@"CJMessageDetail" bundle:nil];
    messageC.message = dataArray[indexPath.row];
    [self.navigationController pushViewController:messageC animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *first = @"first";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:first];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:first];
    }
    CJMessageModel *model = dataArray[indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, cell.textLabel.frame.origin.y, cell.contentView.frame.size.width - 40, 40)];
    label.font = [UIFont systemFontOfSize:13.0];
    [cell.contentView addSubview:label];
    label.text = model.content;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.time;
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CJMessageModel *model = [[CJMessageModel alloc] init];
        model = dataArray[indexPath.row];
        [dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteMessageWithid:model.messageid andUserid:user.userId];
    }
}
-(void)getInterMessage {
    [CJRequestFormat getWebMessages:user.userId finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
            id objc = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
            if ([objc isKindOfClass:[NSArray class]]) {
                NSArray *objcArray = (NSArray *)objc;
                NSLog(@"%d",objcArray.count);
                for (int i = 0; i < objcArray.count; i++) {
                    CJMessageModel *model = [[CJMessageModel alloc] init];
                    NSDictionary *dic = [NSDictionary dictionary];
                    dic = objcArray[i];
                    model.content = [dic objectForKey:@"content"];
                    model.time = [dic objectForKey:@"createTime"];
                    model.title = [dic objectForKey:@"title"];
                    model.messageid = [dic objectForKey:@"id"];
                    [dataArray addObject:model];
                }
                NSLog(@"%d",dataArray.count);
                if (dataArray.count == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有邮件" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    alert.tag = 100;
                    [alert show];
                }
                [_emailTable reloadData];
            }
        }
    }];
}
-(void)deleteMessageWithid:(NSString *)messageid andUserid:(NSString *)userid
{
    [CJRequestFormat deleteMObileMessage:messageid andUserId:userid finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            if ([response isEqualToString:@"true"]) {
                NSLog(@"修改成功");
                [self returnAlert:@"修改成功"];
            }else {
                NSLog(@"修改失败");
                [self returnAlert:@"修改失败"];
            }
        }else if (status == 1) {
            NSLog(@"网络出错");
            [self returnAlert:@"网络故障"];
        }else if (status == 2) {
            NSLog(@"请求成功,返回失败");
            [self returnAlert:@"服务出错"];
        }
    }];
}
-(void)returnAlert:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        CJMainViewController *mainC = [[CJMainViewController alloc] init];
        [[[[CJAppDelegate shareCJAppDelegate] rootController] navController] setCenterViewController:mainC withCloseAnimation:YES completion:nil];
    }
}

@end
