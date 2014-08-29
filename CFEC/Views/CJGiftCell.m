//
//  CJGiftCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-28.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJGiftCell.h"

@implementation CJGiftCell
@synthesize giftImage = _giftImage;
@synthesize giftNameLabel = _giftNameLabel;
@synthesize priceLabel = _priceLabel;
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
    _giftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 60)];
//    _giftImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_giftImage];
    
    _giftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 100, 20)];
//    _giftNameLabel.backgroundColor = [UIColor greenColor];
    _giftNameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_giftNameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 100, 20)];
//    _priceLabel.backgroundColor = [UIColor greenColor];
    _priceLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:_priceLabel];
}
@end
