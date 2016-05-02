//
//  FileSave.h
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/25.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSave : NSObject
+(FileSave *)shareFileSave;
-( BOOL )saveGameData:(NSMutableArray *)data  saveFileName:(NSString *)fileName;
-(id)loadGameData:(NSString *)fileName;
@end
