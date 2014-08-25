//
//  CJAppDelegate.m
//  CFEC
//
//  Created by 徐宝桥 on 14-8-19.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//
/*
 
                                .. .vr
                               qBMBBBMBMY
                              8BBBBBOBMBMv
                            iMBMM5vOY:BMBBv
          .r,               OBM;   .: rBBBBBY
          vUL               7BB   .;7. LBMMBBM.
          .@Wwz.           :uvir .i:.iLMOMOBM..
           vv::r;             iY. ...rv,@arqiao.
            Li. i:             v:.::::7vOBBMBL..
            ,i7: vSUi,         :M7.:.,:u08OP. .
             .N2k5u1ju7,..     BMGiiL7   ,i,i.
              :rLjFYjvjLY7r::.  ;v  vr... rE8q;.:,,
             751jSLXPFu5uU@guohezou.,1vjY2E8@Yizero.
             BB:FMu rkM8Eq0PFjF15FZ0Xu15F25uuLuu25Gi.
           ivSvvXL    :v58ZOGZXF2UUkFSFkU1u125uUJUUZ,
          :@kevensun.      ,iY20GOXSUXkSuS2F5XXkUX5SEv.
        .:i0BMBMBBOOBMUi;,       ,;8PkFP5NkPXkFqPEqqkZu.
       .rqMqBBMOMMBMBBBM .         @kexianli.S11kFSU5q5
      .7BBOi1L1MM8BBBOMBB..,        8kqS52XkkU1Uqkk1kUEJ
      .;MBZ;iiMBMBMMOBBBu ,         1OkS1F1X5kPP112F51kU
       .rPY  OMBMBBBMBB2 ,.        rME5SSSFk1XPqFNkSUPZ,.
              ;;JuBML::r:.:.,,      SZPX0SXSP5kXGNP15UBr.
                  L,    :@huhao.     :MNZqNXqSqXk2E0PSXPE .
              viLBX.,,v8Bj. i:r7:,    2Zkqq0XXSNN0NOXXSXOU
          :r2. rMBGBMGi .7Y, 1i::i   vO0PMNNSXXEqP@Secbone.
          .i1r. .jkY,    vE. iY....  20Fq0q5X5F1S2F22uuv1M;
 
                         让你去当死程序员
 */

#import "CJAppDelegate.h"

@implementation CJAppDelegate

+ (CJAppDelegate *)shareCJAppDelegate {
    return [[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _rootController = [[CJRootViewController alloc] init];
    self.window.rootViewController = _rootController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
