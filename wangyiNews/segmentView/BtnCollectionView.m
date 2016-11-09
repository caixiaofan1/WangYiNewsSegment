//
//  BtnCollectionView.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "BtnCollectionView.h"
#import "BtnCell.h"
#import "CoBtnCell.h"
#import "ScrollviewHeaderView.h"
#import "SegmentView.h"
@implementation BtnCollectionView

{
    NSMutableArray *addlist; //可添加的栏目
    UIPanGestureRecognizer *pan;
    UILongPressGestureRecognizer *_longGesture;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
       
        self.isChangeLocAndDelete = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];

        
        
//        [self registerClass:[BtnCell class] forCellWithReuseIdentifier:@"Cell"];
        [self registerNib:[UINib nibWithNibName:@"CoBtnCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        [self registerClass:[NormalHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];

//        此处给其增加长按手势，用此手势触发cell移动效果
        _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [self addGestureRecognizer:_longGesture];
        
       //获取可添加栏目数组
        addlist = [[FileSave shareFileSave] loadGameData:@"ADDList.txt"];
        
        //点击 排序删除按钮 收到通知  实现方法
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortDeleted:) name:@"sortDelete" object:nil];
}
    
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (self.isChangeLocAndDelete) {
        return 1;
    }else{
        return 2;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return  _titles.count;
    }else if(section == 1){
        return addlist.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    CoBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIButton *btn = [self.scrollBtnArray  objectAtIndex:indexPath.row];
        cell.itemName = _titles[indexPath.row];
        cell.isSelecting = btn.selected;
        cell.indexPath = indexPath;
        [cell.deleteBtn addTarget:self action:@selector(DeleteAciton:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.hidden = YES;
        cell.imageview.hidden = NO;
        if (self.isChangeLocAndDelete) {
            
            cell.label.textColor = [UIColor blackColor];
            cell.deleteBtn.hidden = NO;
        }
        if (indexPath.row == 0) {
            cell.deleteBtn.hidden = YES;
            cell.imageview.hidden = YES;
        }

    } else
        
    {
        cell.deleteBtn.hidden = YES;
        cell.itemName = addlist[indexPath.row];
        cell.isSelecting = NO;
        cell.indexPath = indexPath;
        
    }

          return  cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UIButton *btn = [self.scrollBtnArray  objectAtIndex:indexPath.row];
        btn.selected = YES;
        [self.scrollBtnArray removeObjectAtIndex:indexPath.row];
        [self.scrollBtnArray insertObject:btn atIndex:indexPath.row];
        
        [self notifation:self.titles btnArray:self.scrollBtnArray isSelectedSectionOne:YES];

    }else if (indexPath.section == 1){
        
        NSString *item = [addlist objectAtIndex:indexPath.row];
        [_titles addObject:item];
        [addlist removeObjectAtIndex:indexPath.row];
        [[FileSave shareFileSave] saveGameData:_titles saveFileName:@"BtnList.txt"];
        [[FileSave shareFileSave] saveGameData:addlist saveFileName:@"ADDList.txt"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.selected = NO;
        [self.scrollBtnArray addObject:btn];
        [self reloadData];
        [self notifation:self.titles btnArray:self.scrollBtnArray isSelectedSectionOne:NO];

    }
    
   
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NormalHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        header.label.text = @"点击添加更多栏目";
        header.label.textColor = [UIColor blackColor];
        
        return header;
    }
    
    return nil;
}

//重新定义section页眉的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size;
    if (section == 0) {
        size=CGSizeMake(0, 0);
        
    }else{
        size = CGSizeMake(320, 50);
    }
    
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [_titles objectAtIndex:sourceIndexPath.item];
    id objc1 = [self.scrollBtnArray objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_titles removeObject:objc];
    [self.scrollBtnArray removeObject:objc1];
    //将数据插入到资源数组中的目标位置上
    [_titles insertObject:objc atIndex:destinationIndexPath.item];
    [self.scrollBtnArray insertObject:objc1 atIndex:destinationIndexPath.item];
    [self notifation:self.titles btnArray:self.scrollBtnArray isSelectedSectionOne:NO];

    
}


- (void)DeleteAciton:(UIButton *)sender {
    
    
    if (sender.tag == 0) {
        return;
    }
   NSString *item = [self.titles objectAtIndex:sender.tag];
    [self.titles removeObjectAtIndex:sender.tag];
    [addlist insertObject:item atIndex:0];
    [self.scrollBtnArray removeObjectAtIndex:sender.tag];
    [[FileSave shareFileSave] saveGameData:_titles saveFileName:@"BtnList.txt"];
    [[FileSave shareFileSave] saveGameData:addlist saveFileName:@"ADDList.txt"];
    [self reloadData];
    [self notifation:self.titles btnArray:self.scrollBtnArray isSelectedSectionOne:NO];
    
}

- (void)handlepanGes:(UIPanGestureRecognizer *)panGesture {

    
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:[panGesture locationInView:self]];
    UICollectionViewCell *cell =  [self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    //判断手势状态
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置

            if (CGPathContainsPoint(CGPathCreateWithRect(cell.frame, NULL), NULL, [panGesture locationInView:self], NO)) {
//                break;
                
            }else{
                [self updateInteractiveMovementTargetPosition:[panGesture locationInView:self]];

            }
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self endInteractiveMovement];
            break;
        default:
            [self cancelInteractiveMovement];
            break;
    }

}

- (void)sortDeleted:(NSNotification *)info {

    NSNumber *number = [info.userInfo objectForKey:@"selectBool"];
    
    BOOL selectbool = [number boolValue];
    
    if (selectbool) {

        self.isChangeLocAndDelete = YES;
        [self handlelongGesture:_longGesture];
    }else
    {

        self.isChangeLocAndDelete = NO;
        [self removeGestureRecognizer:pan];
        pan = nil;
    }
    [self reloadData];
}


- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    
    
    self.isChangeLocAndDelete = YES;
    for (UIView *segment in [self.superview subviews]) {
        
        if ([segment isKindOfClass:NSClassFromString(@"SegmentView")]) {
            for (UIView *scrollview in segment.subviews) {
                if ([scrollview isKindOfClass:NSClassFromString(@"ScrollviewHeaderView")]) {
                    
                    ScrollviewHeaderView *view = (ScrollviewHeaderView *)scrollview;
                    view.explainLabel.text =  @"拖动排序";
                    view.selectBtn.selected = YES;
                }

            }
        }
        
}
    if (!pan) {
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlepanGes:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];

    }
//      [self reloadData];
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
  
    
        if (indexPath.row == 0) {
            return NO;
        }else{
            return YES;
        }
    
}
//对collectionveiw操作后 需要传递参数给scrollview
- (void)notifation:(NSMutableArray *)titleArray btnArray:(NSMutableArray *)scrollBtnArray isSelectedSectionOne:(BOOL)isSelectedOne{
    NSNumber *number = [NSNumber numberWithBool:isSelectedOne];
    NSDictionary *dic = @{@"index":number,@"array":titleArray,@"btnArray":scrollBtnArray};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"collectionSelect" object:nil userInfo:dic];
}
- (void)dealloc {
    
    NSLog(@"collectionview 释放");
    self.delegate = nil;
    self.dataSource = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sortDelete" object:nil];
    
}

@end

@implementation NormalHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds] ;
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.backgroundColor = UIColorFromRGB(0xFCFCFC);
        [self addSubview:self.label];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"cell 释放");
    
}
@end




