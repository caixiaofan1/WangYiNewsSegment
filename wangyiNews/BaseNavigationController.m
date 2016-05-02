//
//  BaseNavigationController.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/23.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "BaseNavigationController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//       [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xD70004)];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];

       
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return  UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
