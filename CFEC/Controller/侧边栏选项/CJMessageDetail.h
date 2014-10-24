//
//  CJMessageDetail.h
//  CFEC
//
//  Created by SumFlower on 14-10-24.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJMessageModel.h"
@interface CJMessageDetail : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic ,strong) CJMessageModel *message;
@end
