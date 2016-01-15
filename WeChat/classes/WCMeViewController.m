//
//  WCMeViewController.m
//  WeChat
//
//  Created by 王亚帅 on 16/1/15.
//  Copyright © 2016年 stephen. All rights reserved.
//

#import "WCMeViewController.h"
#import "AppDelegate.h"

@interface WCMeViewController ()

@end

@implementation WCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (IBAction)logoutButtonClick:(UIBarButtonItem *)sender {
    //注销用户
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [[WCXMPPTool sharedWCXMPPTool] xmpplogOut];
    [WCAccount shareAccount].login = NO;
    [[WCAccount shareAccount] saveAccount];
    
    //切换导航控制器到注册
    [UIStoryboard showInitialVCWithName:@"Login"];
}

@end
