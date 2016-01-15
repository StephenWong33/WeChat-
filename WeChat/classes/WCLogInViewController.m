//
//  WCLogInViewController.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "WCLogInViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD+HM.h"

@interface WCLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;

@end

@implementation WCLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)LongIn:(UIButton *)sender {
    //1,判断是否有用户名，和密码
    if (self.userTextField.text.length == 0 || self.psdTextField.text.length == 0) {
        NSLog(@"请输入用户名和密码");
        return;
    }
    //给用户提示
    [MBProgressHUD showMessage:@"正在登陆ing。。。"];

    //2，登录服务器
    //2.1把用户名和密码保存到沙盒
    [WCAccount shareAccount].user = self.userTextField.text;

    [WCAccount shareAccount].pwd = self.psdTextField.text;

    //2.2调用AppDelegate的xmmpplogin的方法
    //用block传值，自己创建的block，强引用的时候，改成若引用，系统穿件的不用管
    __weak typeof(self) selfVc = self;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate xmppLogin:^(XMPPResultType result) {
        [selfVc handleResult:result];
        NSLog(@"%s",__func__);
        
    }];

    
}
#pragma mark 处理回调结果‘

-(void)handleResult:(XMPPResultType)result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (result == XMPPResultTypeLogInSuccess) {
            NSLog(@"%s登陆成功",__FUNCTION__);
            [UIStoryboard showInitialVCWithName:@"Main"];
            [WCAccount shareAccount].login = YES;
            [[WCAccount shareAccount ]saveAccount];
            
            
        }else{
            NSLog(@"登录失败");
            [MBProgressHUD showError:@"用户名或者密码错误"];
        }
    });
    
}


@end
