//
//  CoBtnCell.h
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/25.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoBtnCell : UICollectionViewCell


@property (nonatomic, copy) NSString *itemName; // collectionview 名称
@property (nonatomic,assign) BOOL isSelecting;  //该按钮是否在scrollview中被选中 如果是 则将字体颜色改成红色
@property (nonatomic ,assign) NSIndexPath *indexPath;
@property (nonatomic , weak) IBOutlet UIImageView *imageview;
@property (nonatomic , weak) IBOutlet UILabel *label;
@property (nonatomic , weak) IBOutlet UIButton *deleteBtn;
@end
