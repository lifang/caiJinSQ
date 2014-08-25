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
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 12, 20, 20)];
    _titleImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_titleImage];
    
    _mainContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 12, 100, 30)];
    _mainContentLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_mainContentLabel];
    
    _holdImage = [[UIImageView alloc] initWithFrame:CGRectMake(55, 45, 5, 5)];
    _holdImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_holdImage];
    
    _holdLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 10, 5)];
    _holdLable.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_holdLable];
    
    _spendImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 45, 5, 5)];
    _spendImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_spendImage];
    
    _spendLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 10, 5)];
    _spendLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_spendLabel];
}
@end
