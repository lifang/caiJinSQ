//
//  CJRequestFormat.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJNetworkInterface.h"
#import "ASIHttpHeaders.h"

#define kRequestURL @"requestURL"

typedef enum {
    ResponseSuccess = 0,   //请求成功无误
    ResponseFail,          //请求失败
    ResponseError,         //请求成功，服务端返回错误
}ResponseStatus;

typedef enum {
    GroupNone = 0,
    GroupA,             //在职财务
    GroupE,             //财务圈相关人士
    GroupF,             //财务专业学生
    GroupI,             //待业
    GroupP,             //感兴趣
}GroupType;  //阵营

typedef enum {
    GoodsAll = 0,      //全部礼品
    GoodsHousehold,    //数码家电
    GoodsLife,         //品质生活
    GoodsBook,         //书籍分享
    GoodsHot,          //热门礼品
    GoodsService,      //专业服务
}GoodsType; //礼品类型

/*请求返回的结果

 response:返回的json
 */
typedef void (^Result)(ResponseStatus status, NSString *response);

@interface CJRequestFormat : NSObject

/*!
 @method
 @abstract 用户注册
 @param email 邮箱
 @param password 密码
 @result 请求结果
 */
+ (void)registerWithEmail:(NSString *)email
                 password:(NSString *)password
                 finished:(Result)result;

/*!
 @abstract 用户登录
 @param email 邮箱
 @param password 密码
 @result 请求结果
 */
+ (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
              finished:(Result)result;


/*!
 @abstract 找回密码
 @param email 邮箱
 @result 请求结果
 */
+ (void)findPasswordWithEmail:(NSString *)email
                     finished:(Result)result;


/*!
 @abstract 修改密码
 @param email 邮箱
 @param oldPassword 旧密码
 @param newPassword 新密码
 @result 请求结果
 */
+ (void)modifyPasswordWithEmail:(NSString *)email
                    oldPassword:(NSString *)oldPassword
                    newPassword:(NSString *)newPassword
                       finished:(Result)result;


/*!
 @abstract 注册完成后添加用户信息，先选择阵营类型，根据不同类型添加用户字段
 @param userJson 用户字段json字符串
                 type不为F时 name:姓名
                            companyName:公司名
                            position:职位
                            companyEmail:公司邮箱
                            mobilephone:手机
                            email:用户注册邮箱
                 type为E时 额外字段 business_range:业务范围
                 type为P时 额外字段 interested_reason：感兴趣原因
                 type为F时   name:姓名
                            school:学校
                            specialty:专业
                            companyEmail:公司邮箱
                            email:用户注册邮箱
                            mobilephone:电话
                            graduation_time:毕业时间
 @param type E:财务圈相关人士
             A:在职财务
             F:财务专业学生
             P:感兴趣
             I:待业
 @result 请求结果
 */
+ (void)addPersonalInformationWithJson:(NSString *)userJson
                             groupType:(GroupType)type
                              finished:(Result)result;


/*!
 @abstract 修改用户信息
 @param userID 登录用户ID
 @param userJson 用户字段json字符串 拼接规则参考上方法
 @result 请求结果
 */
+ (void)modifyUserInformationWithUserID:(NSString *)userID
                               userJson:(NSString *)userJson
                               finished:(Result)result;


/*!
 @abstract 上传头像
 @param userID 登录用户ID
 @param imageString 头像data转化的字符串
 @result 请求结果
 */
+ (void)uploadUserHeaderPhotoWithUserID:(NSString *)userID
                      headerImageString:(NSString *)imageString
                               finished:(Result)result;


/*!
 @abstract 活动标题（实际上活动的信息都返回了）
 @result 请求结果
 */
+ (void)getActivityTitleFinished:(Result)result;


/*!
 @abstract 活动详情
 @param articleID 活动的id
 @result 请求结果
 */
+ (void)getActivityContentWithArticleID:(NSString *)articleID
                               finished:(Result)result;


/*!
 @abstract 生成订单
 @param orderJson 订单json字符串
                  userId:用户id
                  orderNo:订单号
                  activityId:活动ID
                  activityName:活动名称
                  activityDescribe:活动描述
                  name:姓名
                  email:邮箱
                  telephone:电话
                  companyName:公司名
                  price:价格
                  orderAmount:总计
                  quantity:数量
 @result 请求结果
 */
+ (void)createOrderWithOrderJson:(NSString *)orderJson
                        finished:(Result)result;


/*!
 @abstract 获取用户订单
 @param userID 用户id
 @result 请求结果
 */
+ (void)getUserOrderWithUserID:(NSString *)userID
                      finished:(Result)result;


/*!
 @abstract 获取礼品
 @param goodType 礼品类型
 @result 请求结果
 */
+ (void)getGoodWithType:(GoodsType)goodType
               finished:(Result)result;

/*!
 @abstract 获取分类礼品
 @param goodType 礼品类型
 @result 请求结果
 */
+ (void)getMobileGoodWithType:(GoodsType)goodType
                     finished:(Result)result;

/*!
 @abstract 获取收货地址
 @param userID 登录用户id
 @result 请求结果
 */
+ (void)getDeliveryAddressWithUserID:(NSString *)userID
                            finished:(Result)result;

/*!
 @abstract 获取用户订单
 @param userID 登录用户id
 @result 请求结果
 */
+ (void)getMobileOrderWithUserID:(NSString *)userID
                        finished:(Result)result;

/*!
 @abstract 获取优惠劵
 @param email 用户登录邮箱
 @result 请求结果
 */
+ (void)getAllCouponWithUserEmail:(NSString *)email
                         finished:(Result)result;

/*!
 @abstract 获取可用优惠劵
 @param email 用户登录邮箱
 @param goodId 商品id
 @result 请求结果
 */
+ (void)getUsableCouponWithUserEmail:(NSString *)email
                              goodID:(NSString *)goodId
                            finished:(Result)result;

/*!
 @abstract 验证优惠劵是否存在
 @param couponNumber 优惠劵号
 @result 请求结果
 */
+ (void)couponIsExistWithNumber:(NSString *)couponNumber
                       finished:(Result)result;


/*!
 @abstract 支付前上传信息
 @param userID 登录用户ID
 @param payInfoJson 支付信息json
                    p_delivery_address:地址
                    p_goodId:商品ID
                    p_quantity:商品数目
                    p_flag:商品类型
                    p_integral:积分
                    p_giftTicket:礼品卡
                    p_coupon:优惠劵
                    p_orderAmount:价格
                    p_total:总价
                    order_no:订单号
 @result 请求结果
 */
+ (void)payInfomationWithUserID:(NSString *)email
                        payJson:(NSString *)payInfoJson
                       finished:(Result)result;
/*
 @abstract 添加地址
 @param user_id 登陆用户ID
 @param addressInfo 地址信息json
                    name:姓名
                    province:省份
                    city:市
                    area:县
                    post_code:邮编
                    street_address:街道
                    mobile:电话
                    telephone:写空" "                
 */
+ (void)addAddressBefor:(NSString *)addressInfo
                       finished:(Result)result;
/*
 @abstract 删除或取消订单
 @param orderNo 订单号
 */
+(void)deleteMobileOrder:(NSString *)orderNo
                         finished:(Result)result;
/*
 @abstract 邀请通讯录好友
 @param address 好友号码
 */
+(void)inviteFriend:(NSString *)address
                    finished:(Result)result;
/*
 @abstract 手机注册获取验证码
 @param phoneNumber 手机号码
 */
+(void)getCodeWithPhoneNumber:(NSString *)phoneNumber
                     finished:(Result)result;

/*
 @abstract 手机注册最后一步
 @param phoneNumber 注册的手机号码
 @param password 密码
 @param email 邮箱地址
 @param userInfo 用户信息json
                 user_name:用户名
                 position:职位
                 companyName:公司名称
 */
+(void)registerByMobilephoneLast:(NSString *)phoneNumber
                     andPassword:(NSString *)password
                        andEmail:(NSString *)email
                     andUserInfo:(NSString *)userInfoJson
                        finished:(Result)result;

/*
 @abstract 手机登陆
 @param phoneNumber 手机号
 @param password 密码
 @param result 请求结果
 */
+(void)loginwithPhone:(NSString *)phoneNumber
          andPassword:(NSString *)password
             finished:(Result)result;

/*
 @abstract 站内信
 @param userid 用户id
 @param result 请求结果
 */
+(void)getWebMessages:(NSString *)userid
             finished:(Result)result;
/*
 @abstract 删除站内信
 @param textid 站内信id
 @param userid 用户id
 */
+(void)deleteMObileMessage:(NSString *)textid
                 andUserId:(NSString *)userid
                  finished:(Result)result;
/*
 @abstract 修改密码
 @param useremail 用户邮箱
 @param oldPassWord 旧密码
 @param newPassWord 新密码
 */
+(void)ChangeOldPassWord:(NSString *)userEmail
                  andOld:(NSString *)oldPassWord
                  andNew:(NSString *)newPassWord
                finished:(Result)result;
/*
 @abstract 找回密码 手机
 @param phoneNumber 手机号
 @param newpassword 新密码
 @param result 请求结果
 */
+(void)findPasswordWithPhone:(NSString *)phoneStr
                 newpassword:(NSString *)newpassword
                    finished:(Result)result;
/*
 @abstract 找回密码返回验证码
 @param phoneNumber 手机号
 @param result 请求结果
 */
+(void)findPasswordWithVerity:(NSString *)phoneStr
                     finished:(Result)result;
@end
