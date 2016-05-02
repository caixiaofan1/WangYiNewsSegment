//
//  BtnCell.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "BtnCell.h"

@implementation BtnCell
{
    UILabel *label;
    UIImageView *imageview;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
//        self.backgroundColor = [UIColor redColor];
        [self createView];
    }
    return self;
}


- (void)setItemName:(NSString *)itemName{
    _itemName = itemName;
}

- (void)setIsSelecting:(BOOL)isSelecting{
    _isSelecting = isSelecting;
   
    if (_isSelecting == YES) {
        
        label.textColor = [UIColor redColor];
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    

    label.text = _itemName;
    
}
- (void)createView{
    
    
    
    
    label = [[UILabel alloc]initWithFrame:self.bounds];
    
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    
     imageview = [[UIImageView alloc]initWithFrame:self.bounds];
    [imageview setImage:[UIImage imageNamed:@"specialcell_nav_btn"]];
    [self addSubview:imageview];
    
    
    [self addSubview:label];
    
    _deleteBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(0, 0, 20, 20);
    _deleteBtn.center = CGPointMake(3, 3);
    _deleteBtn.hidden = YES;
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"channel_edit_delete"] forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
}
@end
