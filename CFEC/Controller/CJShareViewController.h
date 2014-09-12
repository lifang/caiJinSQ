//
//  CJShareViewController.h
//  CFEC
//
//  Created by SumFlower on 14-8-22.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
//@protocol sendMsgToWeChatViewDelegate <NSObject>
//
//- (void) sendTextContent:(NSString *)mesg;
//
//@end
#import <UIKit/UIKit.h>

@interface CJShareViewController : UIViewController
@property (strong, nonatomic) UIButton *addressFriendBt;
@property (strong, nonatomic) UIButton *weiboFriendBt;
@property (strong, nonatomic) UIButton *weixinFriendBt;
@property (strong, nonatomic) UIButton *emailFriendBt;

//@property (assign, nonatomic) id<sendMsgToWeChatViewDelegate>delegate;
@end
