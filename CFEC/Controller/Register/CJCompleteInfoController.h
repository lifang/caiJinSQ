//
//  CJCompleteInfoController.h
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJRequestFormat.h"
@interface CJCompleteInfoController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *infoTable;
@property (nonatomic, strong) NSString *campString;//阵营
@property (nonatomic, strong) NSMutableDictionary *commitDic;//提交的字典
@property (nonatomic, strong) NSString *emailRegisterStr;//注册的email
@end
