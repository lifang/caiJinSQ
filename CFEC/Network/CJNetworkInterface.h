//
//  CJNetworkInterface.h
//  CFEC
//
//  Created by 徐宝桥 on 14-8-25.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

//服务地址
#define kServiceURL @"http://www.cfec.pro/webservice/AddressBookService"

/*
 方法名
 */

//注册
#define kRegister  @"registerMember"

//登录
#define kUserLogin @"getUser"

//找回密码
#define kFindPassword @"retrievePassword"

//修改密码
#define kModifyPassword @"editPassword"

//添加个人信息
#define kAddPersonalInformation @"alterPersonalInformation"

//修改个人信息
#define kModifyUserInformation @"editPersonalInformation"

//上传头像
#define kUploadImage  @"uploadHeadPhoto"

//返回活动标题
#define kGetActivityTitle @"getActivityTitle"

//活动内容
#define kGetActivityContent @"getActivityContent"

//生成订单
#define kCreateOrder @"createMobileOrder"

//获取订单
#define kGetOrder @"getMobileOrder"

//获取礼品
#define kGetGoods @"getBatchGood" 

//获取分类礼品
#define kGetMobileGoods @"getMobileGood"

//获取收货地址
#define kGetDeliveryAddress  @"getDeliveryAddress"

//用户订单
#define kGetMobileOrder @"getMobileOrder"

//优惠劵
#define kGetCoupon  @"getCoupon"

//可用优惠劵
#define kGetUserCoupon  @"getUserCoupon"

//验证优惠劵
#define kJudgeCoupon  @"getCouponExist"

//支付前
#define kBeforePay @"mobilePaymentBefore"

//添加地址
#define kAddress @"addMobileAddress"

//删除或取消订单
#define kDelete @"deleteMobileOrder"

//邀请通讯录好友
#define kInvite @"insertAddressBook"

//手机注册获取验证码
#define kMobileRegisterWithCode @"telRegister"

//手机注册信息
#define kMobileRegister @"registerByMobilephone"

//手机登陆
#define kMobileLogin @"getMobilephoneByEmail"

//站内信
#define kWebMessage @"getAllUserMessage"

//删除站内信
#define kDeleteMessage @"deleteMobileMessage"