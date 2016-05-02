//
//  BaseTabbarController.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/23.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "BaseTabbarController.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
self.tabBar.tintColor=[UIColor redColor];
    // 拿到 TabBar 在拿到想应的item
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    // 对item设置相应地图片
    item0.selectedImage = [[UIImage imageNamed:@"tabbar_icon_news_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image = [[UIImage imageNamed:@"tabbar_icon_news_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.selectedImage = [[UIImage imageNamed:@"tabbar_icon_reader_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image = [[UIImage imageNamed:@"tabbar_icon_reader_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"tabbar_icon_media_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.image = [[UIImage imageNamed:@"tabbar_icon_media_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item3.selectedImage = [[UIImage imageNamed:@"tabbar_icon_bar_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.image = [[UIImage imageNamed:@"tabbar_icon_bar_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"tabbar_icon_me_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item4.image = [[UIImage imageNamed:@"tabbar_icon_me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
