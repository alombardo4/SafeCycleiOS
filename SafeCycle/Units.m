//
//  Units.m
//  SafeCycle
//
//  Created by Alec on 6/17/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "Units.h"

@implementation Units
{
    bool isMPH;
}

-(void) setISKPH:(bool)tf {
    isMPH = !tf;
}
-(void) setIsMPH:(bool)tf {
    isMPH = tf;
}
-(bool) isKPH {
    return !isMPH;
}
-(bool) isMPH {
    return isMPH;
}
-(NSString *) fileOutput {
    NSString *returnVal;
    if (isMPH) {
        returnVal = [[NSString alloc] initWithFormat: @"YES"];
    }
    else {
        returnVal = [[NSString alloc] initWithFormat:@"NO"];
    }
    return returnVal;
}
-(Units *) newUnitsFromFileContents:(NSString *)contents {
    Units *returnVal = [[Units alloc] init];
    if([contents isEqualToString:@"YES"]) {
        [returnVal setIsMPH:YES];
    }
    else if ([contents isEqualToString:@"NO"]){
        [returnVal setIsMPH:NO];
    }
    return returnVal;
}

@end
