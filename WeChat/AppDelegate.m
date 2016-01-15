//
//  AppDelegate.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/14.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //判断是否登录
    if ([WCAccount shareAccount].isLogIn) {
        id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
        self.window.rootViewController = vc;
        //自动登录
        
        [[WCXMPPTool sharedWCXMPPTool] xmppLogin:nil];

        
    }
       return YES;
}



@end
