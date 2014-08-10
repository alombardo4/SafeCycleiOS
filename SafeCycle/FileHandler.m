//
//  FileHandler.m
//  SafeCycle
//
//  Created by Alec on 6/19/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler
-(NSString*) saveFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}


@end
