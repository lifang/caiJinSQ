//
//  CJCompleteInfoCell.m
//  CFEC
//
//  Created by SumFlower on 14-8-21.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCompleteInfoCell.h"

@implementation CJCompleteInfoCell

@synthesize headImage = _headImage;
@synthesize infoName = _infoName;
@synthesize peopleInfo = _peopleInfo;

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
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 25, 25)];
    [self.contentView addSubview:_headImage];
    
    _infoName = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 250, 30)];
    _infoName.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_infoName];
    
    _peopleInfo = [[UILabel alloc] initWithFrame:CGRectMake(140, 8, 150, 30)];
    _peopleInfo.textAlignment = NSTextAlignmentRight;
    _peopleInfo.font = [UIFont systemFontOfSize:13.0f];
//    _peopleInfo.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_peopleInfo];
}
@end
