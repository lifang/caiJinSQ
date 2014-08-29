//
//  CJAddressController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJAddressController.h"

@interface CJAddressController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UISearchDisplayController *searchDisplayControl;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;
@end

@implementation CJAddressController
@synthesize searchDisplayControl = _searchDisplayControl;
@synthesize searchBar = _searchBar;
@synthesize searchTableView = _searchTableView;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邀请好友";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
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
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 50)];
    _searchBar.placeholder = @"查找通讯录";
    _searchBar.searchBarStyle = 2;
    [self.view addSubview:_searchBar];
    _searchBar.delegate =self;
//    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_searchBar sizeToFit];
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _searchTableView.frame = CGRectZero;
    _searchDisplayControl = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    [_searchDisplayControl setDelegate:self];
    [_searchDisplayControl setSearchResultsDataSource:self];
    [_searchDisplayControl setSearchResultsDelegate:self];
    [self.view addSubview:_searchTableView];
}
//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    [UIView animateWithDuration:1.0 animations:^{
//        _searchTableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//    return YES;
//}
//-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    [UIView animateWithDuration:1.0 animations:^{
//        _searchTableView.frame = CGRectZero;
//    }];
//    return YES;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"xxx";
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
@end
