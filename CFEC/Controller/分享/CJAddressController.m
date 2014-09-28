//
//  CJAddressController.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJAddressController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CJAddressModel.h"
#import "ChineseToPinyin.h"
@interface CJAddressController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *sumArray;
    NSMutableArray *sectionArray;
    NSMutableArray *tableViewArray;
    NSArray *allArr;
}
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
    allArr = [self readABAddressBook];
    sumArray = [NSMutableArray array];
    sectionArray = [NSMutableArray array];
    tableViewArray = [NSMutableArray array];
    for ( int i = 0; i<26; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [sumArray addObject:arr];
    }
    [self classArray:allArr andSumArr:sumArray];
    tableViewArray = sumArray;
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
    _searchBar.delegate =self;
    [self.view addSubview:_searchBar];
    
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 50, self.view.frame.size.width, kScreenHeight - _searchBar.frame.origin.y + _searchBar.frame.size.height - 104) style:UITableViewStylePlain];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    [self.view addSubview:_searchTableView];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<26; i++) {
        NSMutableArray *a = [NSMutableArray array];
        [array addObject:a];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (CJAddressModel *model in allArr) {
        if ([model.addressChinese rangeOfString:searchText].location != NSNotFound) {
            [arr addObject:model];
        }
    }
    [self classArray:arr andSumArr:array];
    tableViewArray = array;
    [sectionArray removeAllObjects];
    for (int i = 0; i <array.count;i++ ) {
        NSMutableArray *arr = array[i];
        CJAddressModel *model = arr[0];
        NSString *s = [model.addressEnglish substringToIndex:1];
        [sectionArray addObject:s];
    }
    [_searchTableView reloadData];
    
    
    if ([searchText isEqualToString:@""]) {
        tableViewArray = sumArray;
        [sectionArray removeAllObjects];
        for (int i = 0; i <sumArray.count;i++ ) {
            NSMutableArray *arr = sumArray[i];
            CJAddressModel *model = arr[0];
            NSString *s = [model.addressEnglish substringToIndex:1];
            [sectionArray addObject:s];
        }
        [_searchTableView reloadData];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<26; i++) {
        NSMutableArray *a = [NSMutableArray array];
        [array addObject:a];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (CJAddressModel *model in allArr) {
        if ([model.addressChinese rangeOfString:searchBar.text].location != NSNotFound) {
            [arr addObject:model];
        }
    }
    [self classArray:arr andSumArr:array];
    tableViewArray = array;
    [sectionArray removeAllObjects];
    for (int i = 0; i <array.count;i++ ) {
        NSMutableArray *arr = array[i];
        CJAddressModel *model = arr[0];
        NSString *s = [model.addressEnglish substringToIndex:1];
        [sectionArray addObject:s];
    }
    [_searchTableView reloadData];
    
    
    if ([searchBar.text isEqualToString:@""]) {
        tableViewArray = sumArray;
        [sectionArray removeAllObjects];
        for (int i = 0; i <sumArray.count;i++ ) {
            NSMutableArray *arr = sumArray[i];
            CJAddressModel *model = arr[0];
            NSString *s = [model.addressEnglish substringToIndex:1];
            [sectionArray addObject:s];
        }
        [_searchTableView reloadData];
    }
    [searchBar resignFirstResponder];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSMutableArray *arr = [tableViewArray objectAtIndex:indexPath.section];
    CJAddressModel *model = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.addressChinese;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arr = [tableViewArray objectAtIndex:section];
    return arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableViewArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableArray *arr = [tableViewArray objectAtIndex:section];
    CJAddressModel *model = [arr objectAtIndex:0];
    NSString *head = [model.addressEnglish substringToIndex:1];
    return head;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionArray;
}
-(NSArray *)readABAddressBook{
    NSArray *array;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
        {
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_release(sema);
    }
    else
    {
        addressBook = ABAddressBookCreate();
    }
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);//这是个数组的引用
    
    if (people){
        for(int i = 0; i<CFArrayGetCount(people); i++){
            
            CJAddressModel *addressModel = [[CJAddressModel alloc] init];
            
            NSMutableDictionary *localUserDic = [[NSMutableDictionary alloc] init];
            
            //parse each person of addressbook
            ABRecordRef record=CFArrayGetValueAtIndex(people, i);//取出一条记录
            //以下的属性都是唯一的，即一个人只有一个FirstName，一个Organization。。。
            CFStringRef firstName = ABRecordCopyValue(record,kABPersonFirstNameProperty);
            CFStringRef lastName = ABRecordCopyValue(record,kABPersonLastNameProperty);
            
            if (lastName==NULL) {
                [localUserDic setObject:[NSString stringWithFormat:@"%@",firstName] forKey:@"xxx"];
            }else {
                if (firstName ==NULL){
                    [localUserDic setObject:[NSString stringWithFormat:@"%@",lastName] forKey:@"xxx"];
                }else{
                    [localUserDic setObject:[NSString stringWithFormat:@"%@%@",firstName,lastName] forKey:@"xxx"];
                }
            }
//            NSLog(@"%@",[localUserDic objectForKey:@"xxx"]);
            addressModel.addressChinese = [localUserDic objectForKey:@"xxx"];
            NSString *english = [ChineseToPinyin pinyinFromChiniseString:addressModel.addressChinese];
            addressModel.addressEnglish = english;
            //"CFStringRef"这个类型也是个引用，可以转成NSString*
            
            //......
            //所有这些应用都是要释放的，手册里是说“you are responsible to release it"
            (firstName==NULL)?:CFRelease(firstName);
            (lastName==NULL)?:CFRelease(lastName);
            //.......
            //有些属性不是唯一的，比如一个人有多个电话：手机，主电话，传真。。。
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            //所有ABMutableMultiValueRef这样的引用的东西都是这样一个元组（id，label，value）
            multiPhone = ABRecordCopyValue(record, kABPersonPhoneProperty);
            for (CFIndex i = 0; i < ABMultiValueGetCount(multiPhone); i++) {
//                CFStringRef labelRef = ABMultiValueCopyLabelAtIndex(multiPhone, i);
                CFStringRef numberRef = ABMultiValueCopyValueAtIndex(multiPhone, i);
                //可以通过元组的label来判定这个电话是哪种电话，比如下面就包括：主电话，手机，工作传真
//                if([[NSString stringWithFormat:@"%@",labelRef] isEqualToString:(NSString *) kABPersonPhoneMobileLabel]){
                    NSString *moblie = [NSString stringWithFormat:@"%@",numberRef];
                    
                    moblie = [moblie stringByReplacingOccurrencesOfString:@" (" withString:@""];
                    moblie = [moblie stringByReplacingOccurrencesOfString:@") " withString:@""];
                    moblie = [moblie stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    if (moblie) {
                        [localUserDic setObject:[NSString stringWithFormat:@"%@",moblie] forKey:@"xx"];
                    }else {
                        [localUserDic setObject:@"\"\"" forKey:@"xx"];
                    }
                    
//                }
//                NSLog(@"%@",[localUserDic objectForKey:@"xx"]);
                addressModel.addressPhone = moblie;
                [tempArray addObject:addressModel];
//                NSLog(@"%@",localUserDic);
                // CFRelease(labelRef);
                // CFRelease(numberRef);
            }
            CFRelease(multiPhone);
//            for (int i = 0; i < tempArray.count; i++) {
//                CJAddressModel *model = [[CJAddressModel alloc] init];
//                model = tempArray[i];
//                if ([model.addressChinese isEqualToString:@""]) {
//                    [tempArray removeObject:model];
//                }
//            }
            array = [tempArray sortedArrayUsingComparator:^NSComparisonResult(CJAddressModel *obj1, CJAddressModel *obj2) {
                NSComparisonResult result = [obj1.addressEnglish compare:obj2.addressEnglish];
                if (result == NSOrderedDescending) {
                    CJAddressModel *model = [[CJAddressModel alloc] init];
                    model = obj1;
                    obj1 = obj2;
                    obj2 = model;
                }
                return result;
            }];
        }
        //释放资源
        CFRelease(people);
        CFRelease(addressBook);
    }
    return array;
}
-(void)classArray:(NSArray *)arr andSumArr:(NSMutableArray *)sumArr {
    for (CJAddressModel *model in arr) {
        NSString *str = [model.addressEnglish substringToIndex:1];
        if ([str isEqualToString:@"A"]) {
            model.number = 0;
            [[sumArr objectAtIndex:0] addObject:model];
        }else if ([str isEqualToString:@"B"]) {
            model.number = 1;
            [[sumArr objectAtIndex:1] addObject:model];
        }else if ([str isEqualToString:@"C"]) {
            model.number = 2;
            [[sumArr objectAtIndex:2] addObject:model];
        }else if ([str isEqualToString:@"D"]) {
            model.number = 3;
            [[sumArr objectAtIndex:3] addObject:model];
        }else if ([str isEqualToString:@"E"]) {
            model.number = 4;
            [[sumArr objectAtIndex:4] addObject:model];
        }else if ([str isEqualToString:@"F"]) {
            model.number = 5;
            [[sumArr objectAtIndex:5] addObject:model];
        }else if ([str isEqualToString:@"G"]) {
            model.number = 6;
            [[sumArr objectAtIndex:6] addObject:model];
        }else if ([str isEqualToString:@"H"]) {
            model.number= 7;
            [[sumArr objectAtIndex:7] addObject:model];
        }else if ([str isEqualToString:@"I"]) {
            model.number = 8;
            [[sumArr objectAtIndex:8] addObject:model];
        }else if ([str isEqualToString:@"J"]) {
            model.number= 9;
            [[sumArr objectAtIndex:9] addObject:model];
        }else if ([str isEqualToString:@"K"]) {
            model.number = 10;
            [[sumArr objectAtIndex:10] addObject:model];
        }else if ([str isEqualToString:@"L"]) {
            model.number = 11;
            [[sumArr objectAtIndex:11] addObject:model];
        }else if ([str isEqualToString:@"M"]) {
            model.number= 12;
            [[sumArr objectAtIndex:12] addObject:model];
        }else if ([str isEqualToString:@"N"]) {
            model.number = 13;
            [[sumArr objectAtIndex:13] addObject:model];
        }else if ([str isEqualToString:@"O"]) {
            model.number = 14;
            [[sumArr objectAtIndex:14] addObject:model];
        }else if ([str isEqualToString:@"P"]) {
            model.number = 15;
            [[sumArr objectAtIndex:15] addObject:model];
        }else if ([str isEqualToString:@"Q"]) {
            model.number = 16;
            [[sumArr objectAtIndex:16] addObject:model];
        }else if ([str isEqualToString:@"R"]) {
            model.number = 17;
            [[sumArr objectAtIndex:17] addObject:model];
        }else if ([str isEqualToString:@"S"]) {
            model.number = 18;
            [[sumArr objectAtIndex:18] addObject:model];
        }else if ([str isEqualToString:@"T"]) {
            model.number = 10;
            [[sumArr objectAtIndex:19] addObject:model];
        }else if ([str isEqualToString:@"U"]) {
            model.number = 20;
            [[sumArr objectAtIndex:20] addObject:model];
        }else if ([str isEqualToString:@"V"]) {
            model.number= 21;
            [[sumArr objectAtIndex:21] addObject:model];
        }else if ([str isEqualToString:@"W"]) {
            model.number= 22;
            [[sumArr objectAtIndex:22] addObject:model];
        }else if ([str isEqualToString:@"X"]) {
            model.number = 23;
            [[sumArr objectAtIndex:23] addObject:model];
        }else if ([str isEqualToString:@"Y"]) {
            model.number = 24;
            [[sumArr objectAtIndex:24] addObject:model];
        }else if ([str isEqualToString:@"Z"]) {
            model.number = 25;
            [[sumArr objectAtIndex:25] addObject:model];
        }
    }
    
    for (int i = 0; i<sumArr.count; i++) {
        NSMutableArray *arr = sumArr[i];
        if (arr.count == 0) {
            [sumArr removeObject:arr];
        }
    }
    
    for (int i = 0; i <sumArr.count;i++ ) {
        NSMutableArray *arr = sumArr[i];
        CJAddressModel *model = arr[0];
        NSString *s = [model.addressEnglish substringToIndex:1];
        [sectionArray addObject:s];
    }
}
@end
