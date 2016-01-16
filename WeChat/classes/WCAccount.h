//
//  WCAccount.h
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCAccount : NSObject
/**
 *  登录名和密码
 */
@property(nonatomic,copy)NSString *loginUser;
@property(nonatomic,copy)NSString *loginPwd;
@property(nonatomic,assign,getter=isLogIn)BOOL login;
/**
 *  注册名和密码
 */
@property(nonatomic,copy)NSString *registerUser;
@property(nonatomic,copy)NSString *registerPwd;




+(instancetype)shareAccount;
-(void)saveAccount;


@end
