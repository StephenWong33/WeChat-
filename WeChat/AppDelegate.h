//
//  AppDelegate.h
//  WeChat
//
//  Created by 王亚帅 on 16/1/14.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    XMPPResultTypeLogInSuccess,//登陆成功
    XMPPResultTypeLogInFailure,//登录失败
}XMPPResultType;
/**
 *  与服务器交互的结果
 */
typedef void(^XMPPResultBlock)(XMPPResultType) ;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  xmpp 用户登录
 */
-(void)xmppLogin:(XMPPResultBlock)resultBlock;

/**
 *  注销用户
 */
-(void)xmpplogOut;
@end

