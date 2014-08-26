//
//  CJActivityCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJActivityCell.h"

@implementation CJActivityCell

@synthesize titleImage = _titleImage;
@synthesize holdImage = _holdImage;
@synthesize spendImage = _spendImage;
@synthesize mainContentLabel = _mainContentLabel;
@synthesize holdLable = _holdLable;
@synthesize spendLabel = _spendLabel;

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
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 12, 25,25)];
    _titleImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_titleImage];
    
    _mainContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 3, 320 - 52, 20)];
    _mainContentLabel.backgroundColor = [UIColor greenColor];
    _mainContentLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_mainContentLabel];
    
    _holdImage = [[UIImageView alloc] initWithFrame:CGRectMake(55, 25, 15, 15)];
    _holdImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_holdImage];
    
    _holdLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 60, 15)];
    _holdLable.backgroundColor = [UIColor greenColor];
    _holdLable.font = [UIFont systemFontOfSize:11.0f];
    [self.contentView addSubview:_holdLable];
    
    _spendImage = [[UIImageView alloc] initWithFrame:CGRectMake(140, 25, 15, 15)];
    _spendImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_spendImage];
    
    _spendLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 25, 60, 15)];
    _spendLabel.backgroundColor = [UIColor greenColor];
    _spendLabel.font = [UIFont systemFontOfSize:11.0f];
    [self.contentView addSubview:_spendLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height+2, self.contentView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:1];
    [self.contentView addSubview:lineView];
}
@end
