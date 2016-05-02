//
//  SegmentView.h
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedBlock)(NSInteger selectedItem);
@interface SegmentView : UIView

{
    SelectedBlock _block;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedBtn:(SelectedBlock)block;
@end
