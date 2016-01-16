//
//  WCRegisterController.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/16.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "WCRegisterController.h"

@interface WCRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
- (IBAction)registerBtnClick:(UIButton *)sender;
- (IBAction)cancelBtnClick:(UIBarButtonItem *)sender;

@end

@implementation WCRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (IBAction)registerBtnClick:(UIButton *)sender {
    //保存账号密码
    [WCAccount shareAccount].registerUser = self.userTextField.text;
    [WCAccount shareAccount].registerPwd = self.pwdTextField.text;
    [WCXMPPTool sharedWCXMPPTool].registerOperation = YES;
    [MBProgressHUD showMessage:@"正在注册。。。"];
    //发送注册请求
    [[WCXMPPTool sharedWCXMPPTool] xmppRegister:^(XMPPResultType result) {
        
        [MBProgressHUD hideHUD];
        dispatch_async(dispatch_get_main_queue(), ^{
        if (result == XMPPResultTypeRegisterSuccess) {
            [MBProgressHUD showMessage:@"注册成功"];
            [UIStoryboard showInitialVCWithName:@"Main"];
            [MBProgressHUD hideHUD];
       
            
            } else {
                [MBProgressHUD showMessage:@"注册失败"];
                
            }
        });
       
    }];
    
}

- (IBAction)cancelBtnClick:(UIBarButtonItem *)sender {
}
@end
