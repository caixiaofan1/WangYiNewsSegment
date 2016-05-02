//
//  ScrollviewHeaderView.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "ScrollviewHeaderView.h"

@implementation ScrollviewHeaderView
@synthesize explainLabel;
@synthesize selectBtn;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    
    return self;
}

- (void)createView{
    
    explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.bounds.size.width/2, 50)];
    explainLabel.text = @"切换栏目";
    explainLabel.textAlignment = NSTextAlignmentLeft;
    explainLabel.adjustsFontSizeToFitWidth = YES;
    explainLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:explainLabel];

    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(self.bounds.size.width-120, 5, 60, 40);
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"channel_edit_button_bg"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"channel_edit_button_selected_bg"] forState:UIControlStateHighlighted];
    [selectBtn setTitle:@"排序删除" forState:UIControlStateNormal];
    [selectBtn setTitle:@"完成" forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(sortDelete:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    selectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:selectBtn];
}

- (void)sortDelete:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        explainLabel.text = @"拖动排序";
        
    }else{
        explainLabel.text = @"切换栏目";
    }

    [[NSNotificationCenter defaultCenter]postNotificationName:@"sortDelete" object:nil userInfo:@{@"selectBool":[NSNumber numberWithBool:sender.selected]}];
}
@end
