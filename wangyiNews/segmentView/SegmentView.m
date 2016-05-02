//
//  SegmentView.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/24.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "SegmentView.h"
#import "ScrollviewHeaderView.h"
#import "BtnCollectionView.h"
@implementation SegmentView
{
    UIScrollView *_scrollView;
    UIButton * addBtn;
    NSMutableArray *btnSelected;
    ScrollviewHeaderView *headerView;  //新闻类型选择
    BtnCollectionView *_btncollectionView; //新闻类型排序 添加 删除
    NSMutableArray *titleArray;

}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedBtn:(SelectedBlock)block{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, [UIScreen mainScreen].bounds.size.width, 50);
        
        _block = block;
        titleArray = [NSMutableArray arrayWithArray:titles];
        [self CreateView:frame title:titleArray];
        
    }
    
    return self;
}


- (void)CreateView:(CGRect)frame title:(NSArray *)hostlist{
    
    float btnW = 0;
    btnSelected = [[NSMutableArray alloc]init];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 50, 50)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    for (int i = 0; i<titleArray.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        //根据文字大小  计算按钮的宽度
        CGFloat length = [titleArray[i] boundingRectWithSize:CGSizeMake(320, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnW, 0, length+20, 50);
        [_scrollView addSubview:btn];
        [btnSelected addObject:btn];
        btnW = btn.frame.size.width + btn.frame.origin.x;
        
        //这里设置一开始默认第一个被点击。
        if (i == 0) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            _block(i);
        }
    }
    _scrollView.contentSize = CGSizeMake(btnW, 50);

    [self addSubview:_scrollView];

    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(self.bounds.size.width-45, 5, 40, 40);
    [addBtn setImage:[UIImage imageNamed:@"channel_nav_plus"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(changeItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    
  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"collectionSelect" object:nil];
    //添加监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(collectionSelect:) name:@"collectionSelect" object:nil];
}

 //加号按钮点击响应方法
- (void)changeItem:(UIButton *)sender {
    
    if (!headerView) {
        headerView = [[ScrollviewHeaderView alloc]initWithFrame:self.bounds];
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.alpha = 0;
        [self insertSubview:headerView belowSubview:addBtn];
    }
    
    if (!_btncollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-130)/4 , 35);
                layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        layout.minimumLineSpacing = 20;
        layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
        _btncollectionView = [[BtnCollectionView alloc] initWithFrame:CGRectMake(0, -([self theResponeController].view.bounds.size.height-50), self.bounds.size.width, [self theResponeController].view.bounds.size.height) collectionViewLayout:layout];
        _btncollectionView.titles = titleArray;
        _btncollectionView.scrollBtnArray = btnSelected;
        [[self theResponeController].view insertSubview:_btncollectionView belowSubview:self];

        
    }
    //按钮旋转动画
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.35 animations:^{
            
            addBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
            //渐变显示headerview
            headerView.alpha = 1;
            //向下推出tabbar
            [self theResponeController].tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 50);
            _btncollectionView.transform = CGAffineTransformMakeTranslation(0, [self theResponeController].view.bounds.size.height);

        }];

    }else{
        [UIView animateWithDuration:0.35 animations:^{
            addBtn.transform = CGAffineTransformIdentity;
            headerView.alpha = 0;
            //还原tabbar
            [self theResponeController].tabBarController.tabBar.transform = CGAffineTransformIdentity;
            _btncollectionView.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
            
            [headerView removeFromSuperview];
            headerView = nil;
             
           [_btncollectionView removeFromSuperview];
           _btncollectionView = nil;
        }];
    }
    
    
    
    
}


 //segment上按钮的点击响应方法
- (void)itemSelected:(UIButton *)sender
{
    [self scrollviewItemSelected:sender];
}

- (UIViewController *)theResponeController {
    
    id object = [self nextResponder];
    
    while (![object isKindOfClass:[UIViewController class]] &&
           
           object != nil) {
        
        object = [object nextResponder];
        
    }
    
    UIViewController *uc=(UIViewController*)object;
    return uc;
}

- (void)scrollviewItemSelected:(UIButton *)sender {
    //先全部设置为未点击  然后再单个设置被点击按钮的效果
    for (UIButton *btn in btnSelected) {
        if (btn.tag != sender.tag) {
            btn.selected = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            
        }
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    if (sender.center.x<_scrollView.bounds.size.width/2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if((_scrollView.contentSize.width - sender.center.x <_scrollView.bounds.size.width/2))
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width -_scrollView.bounds.size.width , 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(sender.center.x-(_scrollView.bounds.size.width/2), 0) animated:YES];
        
    }
    
    _block(sender.tag-100);

}



//collectionview操作通知
- (void)collectionSelect:(NSNotification *)info{
    
    /*
     
     首先 将通知传递过来的参数  array是按钮名称数组   btnarray是按钮对象  index是点击的按钮
     
     只要有对collectionview做出操作，
     1 先将_scrollView清空  然后重新创建btn
     */
    
    
    titleArray = [info.userInfo objectForKey:@"array"];
    NSArray *subViews = _scrollView.subviews;
    
    for (UIView *view in subViews) {
        
        [view removeFromSuperview];
    }
    float btnW = 0;
    
    
    btnSelected =[info.userInfo objectForKey:@"btnArray"];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    UIButton *selectBtn;
    for (int i = 0; i<titleArray.count; i++) {
        
        UIButton * btn = [btnSelected objectAtIndex:i];
        [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        //根据文字大小  计算按钮的宽度
        CGFloat length = [titleArray[i] boundingRectWithSize:CGSizeMake(320, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnW, 0, length+20, 50);
        [_scrollView addSubview:btn];
        
        btnW = btn.frame.size.width + btn.frame.origin.x;
        
       
        
        //判断传过来的btn数组中有没有btn是被选中的
        if (btn.selected == YES) {
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            selectBtn = btn;
        }
        
    }
    _scrollView.contentSize = CGSizeMake(btnW, 50);
    
    //num ＝ 0表示之前被选中按钮的在collectionview中被删除了  将设置第一个btn为被选中按钮
    if (!selectBtn) {
         [self scrollviewItemSelected:[btnSelected objectAtIndex:0]];
    }

    
    
   
    //当点击collectionview中的cell时才会传递过来被点击的btn  然后改变btn状态
     NSNumber *selectNumber = [info.userInfo objectForKey:@"index"];
    BOOL isselected = [selectNumber boolValue];
    if (isselected) {
        
        [self scrollviewItemSelected:selectBtn];
        [self changeItem:addBtn];
        
    }
    
    
    
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
- (void)dealloc{
   

}

@end
