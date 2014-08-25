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
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 12, 20, 20)];
    [self.contentView addSubview:_headImage];
    
    _infoName = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 150, 30)];
    _infoName.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_infoName];
    
    _peopleInfo = [[UILabel alloc] initWithFrame:CGRectMake(140, 8, 150, 30)];
    _peopleInfo.textAlignment = NSTextAlignmentRight;
    _peopleInfo.font = [UIFont systemFontOfSize:13.0f];
//    _peopleInfo.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_peopleInfo];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height+2, self.contentView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:1];
    [self.contentView addSubview:lineView];
}
@end
