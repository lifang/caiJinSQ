//
//  CJUserModel.m
//  CFEC
//
//  Created by SumFlower on 14-9-2.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJUserModel.h"

@implementation CJUserModel
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_camp forKey:@"camp"];
    [aCoder encodeObject:_companyEmail forKey:@"companyEmail"];
    [aCoder encodeObject:_companyName forKey:@"companyName"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_giftTicet forKey:@"giftTicet"];
    [aCoder encodeObject:_headPhotoUrl forKey:@"headPhotoUrl"];
    [aCoder encodeObject:_integral forKey:@"integral"];
    [aCoder encodeObject:_memberType forKey:@"memberType"];
    [aCoder encodeObject:_mobilephone forKey:@"mobilephone"];
    [aCoder encodeObject:_msg forKey:@"msg"];
    [aCoder encodeObject:_position forKey:@"position"];
    [aCoder encodeObject:_specialty forKey:@"specialty"];
    [aCoder encodeObject:_userId forKey:@"userId"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _username = [aDecoder decodeObjectForKey:@"username"];
        _password = [aDecoder decodeObjectForKey:@"password"];
        _camp = [aDecoder decodeObjectForKey:@"camp"];
        _companyEmail = [aDecoder decodeObjectForKey:@"companyEmail"];
        _companyName = [aDecoder decodeObjectForKey:@"companyName"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _giftTicet = [aDecoder decodeObjectForKey:@"giftTicet"];
        _headPhotoUrl = [aDecoder decodeObjectForKey:@"headPhotoUrl"];
        _integral = [aDecoder decodeObjectForKey:@"integral"];
        _memberType = [aDecoder decodeObjectForKey:@"memberType"];
        _mobilephone = [aDecoder decodeObjectForKey:@"mobilephone"];
        _msg = [aDecoder decodeObjectForKey:@"msg"];
        _position = [aDecoder decodeObjectForKey:@"position"];
        _specialty = [aDecoder decodeObjectForKey:@"specialty"];
        _userId = [aDecoder decodeObjectForKey:@"userId"];
    }
    return self;
}
@end
