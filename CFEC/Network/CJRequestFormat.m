//
//  CJRequestFormat.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

/*
@"<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">"
"<s:Body>"
"<registerMember xmlns=\"http://service.manager.cfec.com/\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\">"
"<arg0 xmlns=\"\">asdfadf@</arg0>"
"<arg1 xmlns=\"\">asdfasdf</arg1>"
"</registerMember>"
"</s:Body>"
"</s:Envelope>";
*/
 
#import "CJRequestFormat.h"
#import "GDataXMLNode.h"

@implementation CJRequestFormat

inline static NSString * setPostBody(NSString *methodName,NSDictionary *params) {
    NSString *paramString = @"";
    for (NSString *key in params) {
        NSString *param = [NSString stringWithFormat:@"\"<%@ xmlns=\"\">%@</%@>\"",key,[params objectForKey:key],key];
        paramString = [paramString stringByAppendingString:param];
    }
    return [NSString stringWithFormat:@"<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">"
            "<s:Body>"
            "<%@ xmlns=\"http://service.manager.cfec.com/\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\">"
            "%@"
            "</%@>"
            "</s:Body>"
            "</s:Envelope>",methodName,paramString,methodName];
}

//注册
+ (void)registerWithEmail:(NSString *)email
                 password:(NSString *)password
                 finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    [params setObject:password forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kRegister, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//登录
+ (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
              finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    [params setObject:password forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kUserLogin, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//找回密码
+ (void)findPasswordWithEmail:(NSString *)email
                     finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kFindPassword, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//修改密码
+ (void)modifyPasswordWithEmail:(NSString *)email
                    oldPassword:(NSString *)oldPassword
                    newPassword:(NSString *)newPassword
                       finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    [params setObject:oldPassword forKey:@"arg1"];
    [params setObject:newPassword forKey:@"arg2"];
    NSString *soapMessage = setPostBody(kModifyPassword, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//添加用户信息
+ (void)addPersonalInformationWithJson:(NSString *)userJson
                             groupType:(GroupType)type
                              finished:(Result)result {
    NSString *groupString = @"I";
    switch (type) {
        case GroupA:{
            groupString = @"A";
        }
            break;
        case GroupE:{
            groupString = @"E";
        }
            break;
        case GroupF:{
            groupString = @"F";
        }
            break;
        case GroupI:{
            groupString = @"I";
        }
            break;
        case GroupP:{
            groupString = @"P";
        }
            break;
        default:
            break;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userJson forKey:@"arg0"];
    [params setObject:groupString forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kAddPersonalInformation, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//修改用户信息
+ (void)modifyUserInformationWithUserID:(NSString *)userID
                               userJson:(NSString *)userJson
                               finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"arg0"];
    [params setObject:userJson forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kModifyUserInformation, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//上传头像
+ (void)uploadUserHeaderPhotoWithUserID:(NSString *)userID
                      headerImageString:(NSString *)imageString
                               finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"arg0"];
    [params setObject:imageString forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kUploadImage, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//活动标题
+ (void)getActivityTitleFinished:(Result)result {
    NSString *soapMessage = setPostBody(kGetActivityTitle, nil);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//活动详情
+ (void)getActivityContentWithArticleID:(NSString *)articleID
                               finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:articleID forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetActivityContent, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//生成订单
+ (void)createOrderWithOrderJson:(NSString *)orderJson
                        finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:orderJson forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kCreateOrder, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取用户订单
+ (void)getUserOrderWithUserID:(NSString *)userID
                      finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetOrder, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取礼品
+ (void)getGoodWithType:(GoodsType)goodType
               finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%d",goodType] forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetGoods, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取分类礼品
+ (void)getMobileGoodWithType:(GoodsType)goodType
                     finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%d",goodType] forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetMobileGoods, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取收货地址
+ (void)getDeliveryAddressWithUserID:(NSString *)userID
                            finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetDeliveryAddress, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取用户订单
+ (void)getMobileOrderWithUserID:(NSString *)userID
                        finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userID forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetMobileOrder, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取优惠劵
+ (void)getAllCouponWithUserEmail:(NSString *)email
                         finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kGetCoupon, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//获取可用优惠劵
+ (void)getUsableCouponWithUserEmail:(NSString *)email
                              goodID:(NSString *)goodId
                            finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    [params setObject:goodId forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kGetUserCoupon, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

//验证优惠劵是否存在
+ (void)couponIsExistWithNumber:(NSString *)couponNumber
                       finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:couponNumber forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kJudgeCoupon, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}

+ (void)setHttpRequestWithParams:(NSString *)param responseResult:(Result)result {
    NSURL *url = [NSURL URLWithString:kServiceURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSString *soapLength = [NSString stringWithFormat:@"%lu", (unsigned long)[param length]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:soapLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request startAsynchronous];
    __weak ASIHTTPRequest *wRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"!!%@",[wRequest responseString]);
        ResponseStatus status = ResponseSuccess;
        NSString *jsonString = nil;
        if ([[wRequest responseString] rangeOfString:@"<soap:Fault>"].length != 0) {
            //服务返回错误
            status = ResponseError;
            jsonString = [wRequest responseString];
        }
        else {
            NSData *data = [wRequest responseData];
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
            if (!doc) {
                status = ResponseError;
                return ;
            }
            //return中得json内容
            jsonString = [[[[doc rootElement] elementsForName:@"soap:Body"] lastObject] stringValue];
        }
        result(status,jsonString);
    }];
    [request setFailedBlock:^{
        result(ResponseFail,[wRequest responseString]);
    }];
}
//支付前上传信息
+ (void)payInfomationWithUserID:(NSString *)email
                        payJson:(NSString *)payInfoJson
                       finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email forKey:@"arg0"];
    [params setObject:payInfoJson forKey:@"arg1"];
    NSString *soapMessage = setPostBody(kBeforePay, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];
}
//添加地址
+ (void)addAddressBefor:(NSString *)addressInfo
               finished:(Result)result {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:addressInfo forKey:@"arg0"];
    NSString *soapMessage = setPostBody(kAddress, params);
    [[self class] setHttpRequestWithParams:soapMessage responseResult:^(ResponseStatus status, NSString *response) {
        result(status,response);
    }];

}


@end
