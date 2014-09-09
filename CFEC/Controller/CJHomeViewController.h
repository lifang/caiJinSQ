//
//  CJHomeViewController.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) NSMutableArray *newsArray;//最新的六个活动
@end
