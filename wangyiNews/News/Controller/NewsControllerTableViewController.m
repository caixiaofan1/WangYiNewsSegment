//
//  NewsControllerTableViewController.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/23.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "NewsControllerTableViewController.h"
#import "SegmentView.h"
#import "BtnCollectionView.h"
@interface NewsControllerTableViewController ()

@end

@implementation NewsControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
//    这个问题iOS7就出现了，只要scrollView是其父视图上的第一个子视图，且navigationBar不隐藏的情况下，添加到scrollView里的视图，都会默认下移64个像素。 导致scrollview里面的内容向下偏移了64 添加此方法 从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    

    /*
     *添加标题
     *下载ttf字体文件 在info中添加Fonts provided by application  在build phases 的copy哩添加
     *
     */
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
             titleLabel.text = @"網易";
            [titleLabel setFont:[UIFont fontWithName:@"LiSu" size:30]];
             titleLabel.textColor = [UIColor whiteColor];
             titleLabel.textAlignment = NSTextAlignmentCenter;
             [self.navigationController.navigationBar addSubview:titleLabel];
             titleLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 28);
    
    UIButton *NavLeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NavLeBtn.frame = CGRectMake(0, 0, 30, 30);
    [NavLeBtn setBackgroundImage:[UIImage imageNamed:@"search_icon_highlighted"] forState:UIControlStateNormal];
    [NavLeBtn addTarget:self action:@selector(SearchNews) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:NavLeBtn];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    FileSave *filesave = [FileSave shareFileSave];
   NSArray *btnlist = [filesave loadGameData:@"BtnList.txt"];
    
    //添加SegmentView 
    SegmentView *seg = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) titles:btnlist selectedBtn:^(NSInteger selectedItem) {
        
        NSLog(@"%ld",(long)selectedItem);
        
    }];

    [self.view addSubview:seg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)SearchNews
{
    
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
