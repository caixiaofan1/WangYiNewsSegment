//
//  FileSave.m
//  wangyiNews
//
//  Created by 蔡晓凡 on 16/4/25.
//  Copyright © 2016年 蔡晓凡. All rights reserved.
//

#import "FileSave.h"

@implementation FileSave



+(FileSave *)shareFileSave
{
    static FileSave *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[FileSave alloc] init];
    });
    
    return sharedManager;
}


-( BOOL ) saveGameData:(NSMutableArray *)data  saveFileName:(NSString *)fileName
 {
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 if (!documentsDirectory) {
 NSLog(@ "Documents directory not found!" );
 return NO;
 }
 NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
 return ([data writeToFile:appFile atomically:YES]);
 }
 
 
-(id)loadGameData:(NSString *)fileName
 {
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
 NSMutableArray *myData = [[NSMutableArray alloc] initWithContentsOfFile:appFile];
 return myData;
 }


@end
