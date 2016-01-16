//
//  WCXMPPTool.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "WCXMPPTool.h"
#import "XMPPFramework.h"
@interface WCXMPPTool()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;
    XMPPResultBlock _resultBlock ;
}

/**
 *  设置stream
 */
-(void)setupStream;
/**
 *  建立长连接，链接服务器，传递jid
 */
-(void)connectToHost;
/**
 *  链接成功，发送密码
 */
-(void)sendPwdToHost;
/**
 *  发送一个“在线消息”给服务器
 */
-(void)sendOnline;


@end



@implementation WCXMPPTool
singleton_implementation(WCXMPPTool);
#pragma mark 私有方法
-(void)setupStream
{
    //创建XMPPStream对象
    _xmppStream = [[XMPPStream alloc]init];
    //设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}
-(void)connectToHost
{
    if (_xmppStream == nil) {
        [self setupStream];
    }
    XMPPJID *myjid = nil;
    
    if (self.registerOperation) {
        NSString *registerUser = [WCAccount shareAccount].registerUser;
        //1,设置用户的jid，用户名，域名，上网设备
        myjid = [XMPPJID jidWithUser:registerUser domain:@"wong.local" resource:@"iphone"];
        _xmppStream.myJID = myjid;
    } else {
        NSString *loginUser = [WCAccount shareAccount].loginUser;
        //1,设置用户的jid，用户名，域名，上网设备
         myjid = [XMPPJID jidWithUser:loginUser domain:@"wong.local" resource:@"iphone"];
        _xmppStream.myJID = myjid;
    }
   
    //设置主机地址
    _xmppStream.hostName = @"127.0.0.1";
    //设置主机端口号
    _xmppStream.hostPort = 5222;
    //发起链接
    NSError *error;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"%@",error);
    } else {
        NSLog(@"发起链接成功");
    }
}
-(void)disconnectToHost
{
    [_xmppStream disconnect];
}

-(void)sendPwdToHost
{
    NSError *error;
    
    if (self.registerOperation) {
        NSString *registerPwd = [WCAccount shareAccount].registerPwd;
        [_xmppStream registerWithPassword:registerPwd error:&error];
        
    } else {
        NSString *pwd = [WCAccount shareAccount].loginPwd;
        [_xmppStream authenticateWithPassword:pwd error:&error];
    }
   
    if (error) {
        NSLog(@"%@",error);
    } else {
        NSLog(@"发送密码成功");
    }
}

-(void)sendOnline
{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}
-(void)sendOffLine
{
    XMPPPresence *offLine = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offLine];
}

#pragma mark XMPPStream的代理方法
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"%s",__func__);
    
    [self sendPwdToHost];
    
    
    
    
}
#pragma mark 登陆成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%s",__func__);
    [self sendOnline];
    if (_resultBlock) {
        
        _resultBlock(XMPPResultTypeLogInSuccess);
        
    }
}
#pragma mark 登录失败

-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"%s %@",__func__,error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLogInFailure);
    }
    
}
#pragma mark 注册账号代理\

-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"%s",__func__);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
      NSLog(@"%s %@",__func__,error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    
    }
}

//用户登陆流程

//1,初始化XMPPStream

//2，链接服务器，传第一个jid

//3,链接成功传递密码

//4。发送一个在线消息给服务器，高速去他用户，自己上线啦

#pragma mark 公共方法
#pragma mark 用户登录

-(void)xmppLogin:(XMPPResultBlock)resultBlock
{
    //再次连接时，应该先断开链接
    [_xmppStream disconnect ];
    _resultBlock = resultBlock;
 
    //链接服务器
    [self connectToHost];
    
}
#pragma mark 用户注销
-(void)xmpplogOut
{
    //发送离线消息
    [self sendOffLine];
    //断开连接
    [self disconnectToHost];
    
}
#pragma mark 注册用户
-(void)xmppRegister:(XMPPResultBlock)resultBlock
{
    _resultBlock = resultBlock;
    //每次请求前断开连接
    [_xmppStream disconnect];
    
    //建立链接
    [self connectToHost];

    
}


@end
