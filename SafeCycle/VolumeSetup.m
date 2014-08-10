//
//  VolumeSetup.m
//  SafeCycle
//
//  Created by Alec on 6/17/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "VolumeSetup.h"

@implementation VolumeSetup
{
    float settings[7];
}

-(void) setVolumeNumber:(int)num to:(float)value {
    settings[num] = value;
}
-(float) getVolumeNumber:(int)num {
    return settings[num];
}
-(void) setDefaults {
    settings[0] = .10;
    settings[1] = .20;
    settings[2] = .30;
    settings[3] = .35;
    settings[4] = .45;
    settings[5] = .50;
    settings[6] = .60;
}
-(NSString *) fileOutput {
    NSString *returnVal;
    
    returnVal = [[NSString alloc]   initWithFormat:@"%f\n%f\n%f\n%f\n%f\n%f\n%f\n", settings[0], settings[1], settings[2], settings[3],
                 settings[4], settings[5], settings[6]];
    
    return returnVal;
}
-(VolumeSetup *) newVolumeSetupFromFileContents: (NSString *) contents {
    VolumeSetup *setup = [[VolumeSetup alloc] init];
    NSArray *parts = [contents componentsSeparatedByString:@"\n"];
        
    for (int i = 0; i < [parts count]-1; i++) {
        [setup setVolumeNumber:i to:[[parts objectAtIndex:i] floatValue]];
    }
    
    return setup;
}
-(BOOL) allZeros {
    BOOL flag = YES;
    
    for (int i = 0; i < 7; i++) {
        if (settings[i] != (float) 0) {
            flag = NO;
        }
    }
    
    return flag;
}

@end
