//
//  WCAccount.h
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCAccount : NSObject
@property(nonatomic,copy)NSString *user;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,assign,getter=isLogIn)BOOL login;

+(instancetype)shareAccount;
-(void)saveAccount;


@end
