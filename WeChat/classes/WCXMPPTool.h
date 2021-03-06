//
//  WCXMPPTool.h
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    XMPPResultTypeLogInSuccess,//登陆成功
    XMPPResultTypeLogInFailure,//登录失败
    XMPPResultTypeRegisterSuccess,//登陆成功
    XMPPResultTypeRegisterFailure,//登录失败
}XMPPResultType;
/**
 *  与服务器交互的结果
 */
typedef void(^XMPPResultBlock)(XMPPResultType) ;

@interface WCXMPPTool : NSObject
singleton_interface(WCXMPPTool);


@property(nonatomic,assign,getter=isRegisterOperation)BOOL registerOperation;
/**
 *  xmpp 用户登录
 */
-(void)xmppLogin:(XMPPResultBlock)resultBlock;

/**
 *  注销用户
 */
-(void)xmpplogOut;
/**
 *  用户注册
 */

-(void)xmppRegister:(XMPPResultBlock)resultBlock;

@end
