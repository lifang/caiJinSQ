//
//  CJPayedCell.h
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
@protocol deleteDelegate <NSObject>

-(void)deleteAction:(UIButton *)bt;

@end

@protocol cancelDelegate <NSObject>

-(void)cancelAction:(UIButton *)bt;

@end
@protocol payDelegate <NSObject>

-(void)payAction:(UIButton *)bt;

@end
#import <UIKit/UIKit.h>
@interface CJPayedCell : UITableViewCell
@property (nonatomic, strong) UIImageView *giftImage;
@property (nonatomic, strong) UILabel *giftTitleLabel;
@property (nonatomic, strong) UILabel *organizerLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, assign) id<deleteDelegate>delegateDelete;
@property (nonatomic, assign) id<cancelDelegate>delegateCancel;
@property (nonatomic, assign) id<payDelegate>delegatePay;
@end
