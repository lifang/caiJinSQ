//
//  CJCampController.m
//  CFEC
//
//  Created by SumFlower on 14-8-30.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCampController.h"
#import "CJCompleteInfoController.h"
@interface CJCampController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *imageshowArray;
    NSIndexPath *selectIndexPath;
}
@property (nonatomic, strong) UITableView *campTable;
@property (nonatomic, strong) NSArray *campArray;
@end

@implementation CJCampController
@synthesize campTable = _campTable;
@synthesize campArray = _campArray;
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
    self.navigationItem.title = @"选择阵营";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavBarItemWithImageName];
    self.view.backgroundColor = [UIColor whiteColor];
    _campTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320) style:UITableViewStyleGrouped];
    _campTable.delegate = self;
    _campTable.dataSource = self;
    _campTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_campTable];
    _campArray = [[NSArray alloc] initWithObjects:@"在职财务",@"财务专业学生",@"感兴趣",@"有工作经验待业人士",@"财务圈相关人士", nil];
    imageshowArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
}
-(void)setLeftNavBarItemWithImageName:(NSString *)name {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)setRightNavBarItemWithImageName {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)next {
    int i = 0;
    for (NSString *s in imageshowArray) {
        if ([s isEqualToString:@"0"]) {
            i++;
        }
    }
    if (i == 5) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"未选择阵营" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
    }else {
        //传阵营参数
        CJCompleteInfoController *infoControl = [[CJCompleteInfoController alloc] init];
        NSLog(@"%d",selectIndexPath.row);
        //传注册email
        NSLog(@"%@",self.registerEmail);
        infoControl.emailRegisterStr = self.registerEmail;
        
        if (selectIndexPath.row == 0) {
            infoControl.campString = @"A";
        }else if (selectIndexPath.row == 1) {
            infoControl.campString = @"F";
        }else if (selectIndexPath.row == 2) {
            infoControl.campString = @"P";
        }else if (selectIndexPath.row == 3) {
            infoControl.campString = @"I";
        }else {
            infoControl.campString = @"E";
        }
        [self.navigationController pushViewController:infoControl animated:YES];

    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _campArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(280, 7, 30, 30)];
//    image.backgroundColor = [UIColor greenColor];
    image.image = [UIImage imageNamed:@"首页-个人资料2_03@2x.png"];
    [cell.contentView addSubview:image];
    NSString *imageshowstr = [imageshowArray objectAtIndex:indexPath.row];
    if ([imageshowstr isEqualToString:@"1"]) {
        image.hidden = NO;
    }else {
        image.hidden = YES;
    }
    cell.textLabel.text = _campArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageshowstr =[imageshowArray objectAtIndex:indexPath.row];
    if ([imageshowstr isEqualToString:@"1"]) {
        [imageshowArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }else {
        for (int i = 0;i<5;i++) {
            [imageshowArray replaceObjectAtIndex:i withObject:@"0"];
        }
        [imageshowArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    selectIndexPath = indexPath;
    [tableView reloadData];
}
@end
