//
//  CJUserModel.h
//  CFEC
//
//  Created by SumFlower on 14-9-2.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJUserModel : NSObject<NSCoding>
//用户名
@property (nonatomic, strong) NSString *username;
//密码
@property (nonatomic, strong) NSString *password;
//名称
@property (nonatomic, strong) NSString *name;
//阵营
@property (nonatomic, strong) NSString *camp;
//公司邮箱
@property (nonatomic, strong) NSString *companyEmail;
//公司名称
@property (nonatomic, strong) NSString *companyName;
//注册邮箱
@property (nonatomic, strong) NSString *email;
//giftTicet
@property (nonatomic, strong) NSString *giftTicet;
//headPhotoUrl头像地址
@property (nonatomic, strong) NSString *headPhotoUrl;
//integral
@property (nonatomic, strong) NSString *integral;
//memberType
@property (nonatomic, strong) NSString *memberType;
//手机号码
@property (nonatomic, strong) NSString *mobilephone;
//msg
@property (nonatomic, strong) NSString *msg;
//职位
@property (nonatomic, strong) NSString *position;
//specialty
@property (nonatomic, strong) NSString *specialty;
//userid
@property (nonatomic, strong) NSString *userId;
@end
