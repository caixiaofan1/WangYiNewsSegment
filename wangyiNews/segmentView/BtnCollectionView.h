//
//  BtnCollectionView.h
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>




@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *scrollBtnArray; //scrollview上的按钮 用来在加载的时候设置被选中按钮为红色
@property (nonatomic, assign) BOOL isChangeLocAndDelete; //是否可调换位置和删除
@end
@interface NormalHeader : UICollectionReusableView

@property (strong, nonatomic) UILabel *label;

@end