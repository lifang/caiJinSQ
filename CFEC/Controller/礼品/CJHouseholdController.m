//
//  CJHouseholdController.m
//  CFEC
//
//  Created by SumFlower on 14-9-7.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJHouseholdController.h"
#import "CJGiftCell.h"
#import "CJGiftDetailController.h"
#import "CJRequestFormat.h"
#import "CJGiftModel.h"
#import "UIImageView+WebCache.h"

@interface CJHouseholdController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *allGiftArray;
}

@property (nonatomic, strong) UITableView *giftTable;
@end

@implementation CJHouseholdController

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
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"数码家电";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self getDate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI {
    
    _giftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _giftTable.delegate = self;
    _giftTable.dataSource = self;
    [self.view addSubview:_giftTable];
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
-(void)getDate {
    [CJRequestFormat getGoodWithType:GoodsHousehold finished:^(ResponseStatus status, NSString *response) {
        if (status == 0) {
            //            NSLog(@"%@",response);
            allGiftArray = [NSMutableArray array];
            NSError *error;
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *tempArray = (NSArray *)jsonObject;
                for (NSDictionary *dic in tempArray ) {
                    CJGiftModel *model = [[CJGiftModel alloc] init];
                    model.addeFlag = [dic objectForKey:@"addedFlag"];
                    model.bookFlag = [dic objectForKey:@"bookFlag"];
                    model.content = [dic objectForKey:@"content"];
                    model.deleteFlag = [dic objectForKey:@"deleteFlag"];
                    model.describe = [dic objectForKey:@"describe"];
                    model.goodsType = [dic objectForKey:@"goodsType"];
                    model.ID = [dic objectForKey:@"id"];
                    model.labelld = [dic objectForKey:@"labelld"];
                    model.maxPage = [dic objectForKey:@"maxPage"];
                    model.name = [dic objectForKey:@"name"];
                    model.number = [dic objectForKey:@"number"];
                    model.offtime = [dic objectForKey:@"offtime"];
                    model.ontime = [dic objectForKey:@"ontime"];
                    model.operateAccount = [dic objectForKey:@"operateAccount"];
                    model.page = [dic objectForKey:@"page"];
                    model.parentId = [dic objectForKey:@"parentId"];
                    model.picture = [dic objectForKey:@"picture"];
                    model.pictures = [dic objectForKey:@"pictures"];
                    model.price = [dic objectForKey:@"price"];
                    model.purchasedQunantity = [dic objectForKey:@"purchasedQunantity"];
                    model.qunantity = [dic objectForKey:@"qunantity"];
                    model.surplusQunantity = [dic objectForKey:@"surplusQunantity"];
                    [allGiftArray addObject:model];
                }
                [self initUI];
            }
        }else if (status == 1) {
            NSLog(@"请求出错");
        }else if (status == 2) {
            NSLog(@"请求成功,返回出错");
        }
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allGiftArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    CJGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CJGiftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CJGiftModel *model = allGiftArray[indexPath.row];
    [cell.giftImage sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    cell.giftNameLabel.text = model.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",model.price];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJGiftDetailController *giftDetailControl = [[CJGiftDetailController alloc] init];
    [self.navigationController pushViewController:giftDetailControl animated:YES];
}

- (void)hiddenExtraCellLine {
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [self.giftTable setTableFooterView:view];
    
}
@end
