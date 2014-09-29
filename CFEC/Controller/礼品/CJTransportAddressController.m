//
//  CJTransportAddressController.m
//  CFEC
//
//  Created by SumFlower on 14-9-5.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJTransportAddressController.h"

@interface CJTransportAddressController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *provinceArray;//所有省
    NSMutableDictionary *shengshiDic;
    int index;//区别label
}
@property (nonatomic, assign) CGRect focusRect;

@property (nonatomic, strong) UITableView *transportTableview;
@property (nonatomic, strong) UILabel *shengLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *xianLabel;
@property (nonatomic, strong) UITextField *text1;
@property (nonatomic, strong) UITextField *text2;
@property (nonatomic, strong) UITextField *text3;
@property (nonatomic, strong) UITextField *text4;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) float height;

@property (nonatomic, strong) NSDictionary *placeDic;

@end

@implementation CJTransportAddressController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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
-(void)setRightNavBarItemWithImageName:(NSString *)name {
    UIBarButtonItem *rightbt = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    rightbt.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightbt;
}
-(void)back:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_shengLabel.text forKey:@"province"];
    [dic setObject:_cityLabel.text forKey:@"city"];
    [dic setObject:_xianLabel.text forKey:@"county"];
    [dic setObject:_text1.text forKey:@"address"];
    [dic setObject:_text2.text forKey:@"post"];
    [dic setObject:_text3 forKey:@"name"];
    [dic setObject:_text4 forKey:@"tel"];
    if ([self.delegate respondsToSelector:@selector(sendAddress:)]) {
        [self.delegate sendAddress:dic];
    }
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
-(void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"配送地址";
    [self setLeftNavBarItemWithImageName:@"订单_03@2x.png"];
    [self setRightNavBarItemWithImageName:@"保存"];
    
    _transportTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _transportTableview.delegate = self;
    _transportTableview.dataSource = self;
    [self.view addSubview:_transportTableview];
    
    _shengLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 12,50, 20)];
    _shengLabel.font = [UIFont systemFontOfSize:13.0f];
    _shengLabel.text = @"北京市";
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 12,100, 20)];
    _cityLabel.font = [UIFont systemFontOfSize:13.0f];
    _cityLabel.text = @"北京市";
    
    _xianLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 12,100, 20)];
    _xianLabel.font = [UIFont systemFontOfSize:13.0f];
    _xianLabel.text = @"东城区";
    
    _height = [[UIScreen mainScreen] bounds].size.height;
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _height, 320, 44)];
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(outForView:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                           target:nil
                                                                           action:nil];
    space.width = 255;
    [_toolBar setItems:[NSArray arrayWithObjects:space,finish, nil]];
    _toolBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_toolBar];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _height, 320, 216)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    
    _text1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
    _text1.delegate = self;
    _text1.font = [UIFont systemFontOfSize:13.0f];
    _text1.placeholder = @"具体地址";
    _text1.returnKeyType = UIReturnKeyDone;
    _text1.borderStyle = UITextBorderStyleNone;
    _text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _text2 = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
    _text2.delegate = self;
    _text2.font = [UIFont systemFontOfSize:13.0f];
    _text2.placeholder = @"邮政编码";
    _text2.returnKeyType = UIReturnKeyDone;
    _text2.borderStyle = UITextBorderStyleNone;
    _text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _text3 = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
    _text3.delegate = self;
    _text3.font = [UIFont systemFontOfSize:13.0f];
    _text3.placeholder = @"收件人姓名";
    _text3.returnKeyType = UIReturnKeyDone;
    _text3.borderStyle = UITextBorderStyleNone;
    _text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _text4 = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
    _text4.delegate = self;
    _text4.font = [UIFont systemFontOfSize:13.0f];
    _text4.placeholder = @"收件人电话";
    _text4.returnKeyType = UIReturnKeyDone;
    _text4.borderStyle = UITextBorderStyleNone;
    _text4.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self getPlaceFromPlist];//获取各地地址
    provinceArray = [NSMutableArray array];
    [self getAllShen];
}
#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_items objectAtIndex:row];
}

- (IBAction)outForView:(id)sender {
    if (index == 0) {
        self.shengLabel.text = [_items objectAtIndex:[_pickerView selectedRowInComponent:0]];
    }else if (index == 1) {
        self.cityLabel.text = [_items objectAtIndex:[_pickerView selectedRowInComponent:0]];
    }else {
        self.xianLabel.text = [_items objectAtIndex:[_pickerView selectedRowInComponent:0]];
    }
    [UIView animateWithDuration:0.3f animations:^{
        _pickerView.frame = CGRectMake(0, _height, 320, 216);
        _toolBar.frame = CGRectMake(0, _height, 320, 44);
    }];
}

-(void)save:(id)sender {
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else {
        return 4;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 50, 20)];
    label1.font = [UIFont systemFontOfSize:13.0f];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(280, 12, 20, 20)];
    img.image = [UIImage imageNamed:@"礼品箭头@2x.png"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            label1.text = @"省份";
            [cell.contentView addSubview:_shengLabel];
        }else if (indexPath.row == 1) {
            label1.text = @"城市";
            [cell.contentView addSubview:_cityLabel];
        }else {
            label1.text = @"县城镇";
            [cell.contentView addSubview:_xianLabel];
        }
        [cell.contentView addSubview:img ];
        [cell.contentView addSubview:label1];
    }else {
        if (indexPath.row == 0) {
            [cell.contentView addSubview:_text1];
        }else if (indexPath.row == 1) {
            [cell.contentView addSubview:_text2];
        }else if (indexPath.row == 2) {
            [cell.contentView addSubview:_text3];
        }else {
            [cell.contentView addSubview:_text4];
        }
        [cell addSubview:label1];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        index = indexPath.row;
        if (indexPath.row == 0) {
            _items = provinceArray;
            _cityLabel.text = nil;
            _xianLabel.text = nil;
        }else if (indexPath.row == 1) {
            NSString *province = _shengLabel.text;
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic = [shengshiDic objectForKey:province];
            _items = [dic allKeys];
        }else {
            NSString *province = _shengLabel.text;
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic = [shengshiDic objectForKey:province];
            NSArray *xianarr =[NSArray arrayWithArray:[dic objectForKey:self.cityLabel.text]];
            _items = xianarr;
        }
        [_pickerView reloadAllComponents];
    }
    [UIView animateWithDuration:0.3f animations:^{
        _pickerView.frame = CGRectMake(0, _height - 216, 320, 216);
        _toolBar.frame = CGRectMake(0, _height - 216 - 44, 320, 44);
    }];
}
#pragma mark - 取地址
-(void)getPlaceFromPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _placeDic = [NSDictionary dictionaryWithContentsOfFile:path];
}
#pragma mark - 取所有省份
-(void)getAllShen{
    shengshiDic = [NSMutableDictionary dictionary];
    for (NSString *key in _placeDic) {
       NSDictionary *dic = [_placeDic objectForKey:key];
//        NSLog(@"%@",[[dic allKeys] lastObject]);
        [provinceArray addObject:[[dic allKeys] lastObject]];
        NSDictionary *dic1 = [dic objectForKey:[[dic allKeys] lastObject]];
        NSMutableDictionary *shixianDic = [NSMutableDictionary dictionary];
        for (NSString *cityid in dic1) {
            NSDictionary *dic2 = [dic1 objectForKey:cityid];
//            NSLog(@"%@",[[dic2 allKeys] lastObject]);//市
            NSArray *arr = [dic2 objectForKey:[[dic2 allKeys] lastObject]];
//            for (NSString *town in arr) {
//                NSLog(@"%@",town);//县
//            }
            [shixianDic setObject:arr forKey:[[dic2 allKeys] lastObject]];
        }
        [shengshiDic setObject:shixianDic forKey:[[dic allKeys] lastObject]];
    }
}
- (void)keyboardHeightChanged:(NSNotification *)notification {
    if (!([_text1 isFirstResponder] || [_text2 isFirstResponder]||[_text3 isFirstResponder]||[_text4 isFirstResponder])) {
        return;
    }
    NSDictionary *info = [notification userInfo];
    CGRect startFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat bottomHeight = 100;
    CGFloat offset = 0;
    NSLog(@"%@,%@",NSStringFromCGRect(startFrame),NSStringFromCGRect(endFrame));
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

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    _focusRect = textField.frame;
//}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self resetViewFrame];
    return YES;
}
-(void)resetViewFrame {
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat originY = 0;
        CGRect rect = CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
    }];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
