//
//  CJPayedCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-29.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJPayedCell.h"

@implementation CJPayedCell

@synthesize giftImage = _giftImage;
@synthesize giftTitleLabel = _giftTitleLabel;
@synthesize organizerLabel = _organizerLabel;
@synthesize priceLabel = _priceLabel;
@synthesize numberLabel = _numberLabel;
@synthesize sumLabel = _sumLabel;
@synthesize deleteButton = _deleteButton;
@synthesize cancelButton = _cancelButton;
@synthesize payButton = _payButton;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initUI {
    _giftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 55, 42)];
    [self.contentView addSubview:_giftImage];
    
    _giftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 10, self.contentView.frame.size.width - 85, 20)];
    _giftTitleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_giftTitleLabel];
    
    UIImageView *titleimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(85, 40, 15, 15)];
    titleimage1.image = [UIImage imageNamed:@"活动1_06@2x.png"];
    [self.contentView addSubview:titleimage1];
    
    _organizerLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 40, 100, 15)];
    _organizerLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_organizerLabel];
    
    UIImageView *titleimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(205, 40, 15, 15)];
    titleimage2.image = [UIImage imageNamed:@"活动_03@2x.png"];
    [self.contentView addSubview:titleimage2];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 40, 100, 15)];
    _priceLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_priceLabel];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 1)];
    line1.backgroundColor = kColor(214, 213, 213, 1);
    [self.contentView addSubview:line1];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 65, 100, 15)];
    _numberLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_numberLabel];
    
    _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 65, 100, 15)];
    _sumLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_sumLabel];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(20, 85, 280, 1)];
    line2.backgroundColor = kColor(214, 213, 213, 1);
    [self.contentView addSubview:line2];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.frame = CGRectMake(225, 95, 60, 20);
    [_deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _deleteButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.cornerRadius = 5;
    [_deleteButton addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteButton];
    
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(225, 95, 60, 20);
    [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _payButton.layer.borderWidth = 1;
    _payButton.layer.cornerRadius = 5;
    _payButton.hidden = YES;
    [self.contentView addSubview:_payButton];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(225 - 20 - 60, 95, 60, 20);
    [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.layer.cornerRadius = 5;
    _cancelButton.hidden = YES;
    [self.contentView addSubview:_cancelButton];

    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,124, self.contentView.frame.size.width, 6)];
    line.backgroundColor = kColor(208, 208, 208, 1);
    [self.contentView addSubview:line];
}
-(void)deleteOrder:(UIButton *)bt {
    if ([self.delegateDelete respondsToSelector:@selector(deleteAction:)]) {
        [self.delegateDelete deleteAction:bt];
    }
}
-(void)pay:(UIButton *)bt {
    if ([self.delegatePay respondsToSelector:@selector(payAction:)]) {
        [self.delegatePay payAction:bt];
    }
}
-(void)cancel:(UIButton *)bt {
    if ([self.delegateCancel respondsToSelector:@selector(cancelAction:)]) {
        [self.delegateCancel cancelAction:bt];
    }
}
@end
