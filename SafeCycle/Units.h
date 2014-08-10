//
//  Units.h
//  SafeCycle
//
//  Created by Alec on 6/17/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Units : NSObject

-(void) setIsMPH: (bool) tf;
-(void) setISKPH: (bool) tf;
-(bool) isKPH;
-(bool) isMPH;
-(NSString *) fileOutput;
-(Units * ) newUnitsFromFileContents: (NSString *) contents;

@end
