//
//  CJleftListCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJleftListCell.h"

@implementation CJleftListCell
@synthesize leftImage = _leftImage;
@synthesize leftLable = _leftLable;
@synthesize rightLable = _rightLable;
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
    self.contentView.backgroundColor = kColor(24, 24, 19, 1);    
    _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 20, 20)];
    [self.contentView addSubview:_leftImage];
    
    _leftLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 12, 70, 20)];
    _leftLable.textColor = [UIColor whiteColor];
    _leftLable.font = [UIFont systemFontOfSize:11.0f];
    [self.contentView addSubview:_leftLable];
    
    _rightLable= [[UILabel alloc] initWithFrame:CGRectMake(135, 12, 70, 20)];
    _rightLable.textColor = [UIColor redColor];
    _rightLable.font = [UIFont systemFontOfSize:11.0f];

    [self.contentView addSubview:_rightLable];
    
}
@end
