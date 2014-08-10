//
//  VolumeSetup.h
//  SafeCycle
//
//  Created by Alec on 6/17/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VolumeSetup : NSObject

-(void) setVolumeNumber: (int) num to: (float) value;
-(float) getVolumeNumber: (int) num;
-(void) setDefaults;
-(NSString *) fileOutput;
-(VolumeSetup * ) newVolumeSetupFromFileContents: (NSString *) contents;
-(BOOL) allZeros;


@end
