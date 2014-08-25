//
//  CJActivityCell.h
//  CFEC
//
//  Created by SumFlower on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJActivityCell : UITableViewCell
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIImageView *holdImage;
@property (nonatomic, strong) UIImageView *spendImage;
@property (nonatomic, strong) UILabel *mainContentLabel;
@property (nonatomic, strong) UILabel *holdLable;
@property (nonatomic, strong) UILabel *spendLabel;
@end
