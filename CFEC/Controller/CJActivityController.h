//
//  CJActivityController.h
//  CFEC
//
//  Created by SumFlower on 14-8-22.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJActivityController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UISegmentedControl *filtrateSegment;//筛选
@property (nonatomic, strong) UITableView *activityTable;
@end
