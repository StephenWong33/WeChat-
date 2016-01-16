//
//  WCAccount.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "WCAccount.h"
#define kLoginUserKey @"loginUser"
#define kLoginPwdKey @"loginPwd"
#define kLogInrKey @"login"
#define kRegisterUserKey @"registerUser"
#define kRegisterPwdKey @"registerPwd"
@implementation WCAccount

/**
 *  获得账户信息
 *
 *  @return account
 */
+(instancetype)shareAccount
{
    NSLog(@"%s",__func__);
    return [[self alloc]init];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    NSLog(@"%s",__func__);
    static WCAccount *account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        if (account == nil) {
            account = [super allocWithZone:zone];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            account.loginUser = [defaults objectForKey:kLoginUserKey];
            account.loginPwd = [defaults objectForKey:kLoginPwdKey];
            account.login = [defaults boolForKey:kLogInrKey];
            
        }
    });
    return account;
}
/**
 *  保存账户信息
 */
-(void)saveAccount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.loginUser forKey:kLoginUserKey];
    [defaults setObject:self.loginPwd forKey:kLoginPwdKey];
    [defaults setBool:self.login forKey:kLogInrKey];
    [defaults synchronize];
}

@end
