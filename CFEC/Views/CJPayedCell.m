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
    [self.contentView addSubview:_deleteButton];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,124, self.contentView.frame.size.width, 6)];
    line.backgroundColor = kColor(208, 208, 208, 1);
    [self.contentView addSubview:line];
}
@end
