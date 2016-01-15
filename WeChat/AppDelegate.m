//
//  AppDelegate.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/14.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"

@interface AppDelegate ()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;
    XMPPResultBlock _resultBlock;
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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //判断是否登录
//    if ([WCAccount shareAccount].isLogIn) {
//        id vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
//        self.window.rootViewController = vc;
//        
//    }
//    
    return YES;
}

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
    NSString *user = [WCAccount shareAccount].user;
    //1,设置用户的jid，用户名，域名，上网设备
    XMPPJID *myjid = [XMPPJID jidWithUser:user domain:@"wong.local" resource:@"iphone"];
    _xmppStream.myJID = myjid;
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

-(void)sendPwdToHost
{
    NSError *error;
    NSString *pwd = [WCAccount shareAccount].pwd;
    [_xmppStream authenticateWithPassword:pwd error:&error];
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
        _resultBlock = nil;
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

@end
