//
//  CJCreatePayOrder.m
//  CFEC
//
//  Created by 徐宝桥 on 14-9-12.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "CJCreatePayOrder.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayOrder.h"

@implementation CJCreatePayOrder

+ (NSString *)createGiftOrderWithGift:(CJGiftModel *)gift
                          countNumber:(int)count {
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [[self class] createTradeNo];
    order.productName = gift.name;
    order.productDescription = gift.describe;
    order.amount = [NSString stringWithFormat:@"%.2f",[gift.price floatValue] * count];
    order.notifyURL = @"http%3A%2F%2Fwww.xxx.com";
    
    NSString *orderInfo = [order description];
    NSString *signedStr = [[self class] doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo,signedStr,@"RSA"];
    return orderString;
}

+ (NSString *)createActivityOrderWithActivity:(CJActivityModel *)activity
                                  countNumber:(int)count {
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [[self class] createTradeNo];
    order.productName = activity.title;
    order.productDescription = activity.title;
    order.amount = [NSString stringWithFormat:@"%.2f",[activity.meetingCost floatValue] * count];
    order.notifyURL = @"http%3A%2F%2Fwww.xxx.com";
    
    NSString *orderInfo = [order description];
    NSString *signedStr = [[self class] doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo,signedStr,@"RSA"];
    return orderString;
}

+ (NSString *)createTradeNo {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *now = [NSDate date];
    NSString *dateString = [format stringFromDate:now];
    return [NSString stringWithFormat:@"M%@",dateString];
}

+ (NSString*)doRsa:(NSString*)orderInfo {
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

@end
