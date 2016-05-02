//
//  CoBtnCell.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/25.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "CoBtnCell.h"

@implementation CoBtnCell

- (void)awakeFromNib {
    
}
- (void)setItemName:(NSString *)itemName{
    _itemName = itemName;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self createView];
    
    self.deleteBtn.tag = _indexPath.row;
   }
- (void)createView{
    
    
    
    
    self.label.text = _itemName;
//    NSLog(@"%@",_itemName);
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.adjustsFontSizeToFitWidth = YES;

    if (self.indexPath.row == 0 && self.indexPath.section == 0 ) {
        
        self.label.textColor = [UIColor grayColor];
        
        
    }else{


    }
    if (self.isSelecting) {
        
        self.label.textColor = [UIColor redColor];
        
    }
    

}

@end
