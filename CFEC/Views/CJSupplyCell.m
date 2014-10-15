//
//  CJSupplyCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-27.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJSupplyCell.h"

@implementation CJSupplyCell
@synthesize infoName = _infoName;
@synthesize info = _info;
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
    _infoName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 30)];
    _infoName.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_infoName];
    
    _info = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, self.contentView.frame.size.width - 80, 30)];
    _info.textAlignment = NSTextAlignmentRight;
    _info.font = [UIFont systemFontOfSize:13.0f];
//    [self.contentView addSubview:_info];
}
@end
