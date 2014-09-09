//
//  CJPayedCell.h
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJPayedCell : UITableViewCell
@property (nonatomic, strong) UIImageView *giftImage;
@property (nonatomic, strong) UILabel *giftTitleLabel;
@property (nonatomic, strong) UILabel *organizerLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@end
