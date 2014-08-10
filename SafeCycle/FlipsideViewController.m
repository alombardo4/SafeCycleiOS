//
//  FlipsideViewController.m
//  SafeCycle
//
//  Created by Alec on 7/14/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@".txt"];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSArray *cont = [str componentsSeparatedByString:@"\n"];
    units = [[Units alloc] init];
    units = [units newUnitsFromFileContents:[cont objectAtIndex:0]];
    
    setup = [[VolumeSetup alloc] init];
    NSString *setupstring = [[NSString alloc] initWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n", [cont objectAtIndex:1], [cont objectAtIndex:2],
                             [cont objectAtIndex:3], [cont objectAtIndex:4], [cont objectAtIndex:5], [cont objectAtIndex:6], [cont objectAtIndex:7]];
    if(str != nil) {
        setup = [setup newVolumeSetupFromFileContents:setupstring];
        
        if ([setup allZeros]) {
            [setup setDefaults];
        }
        
        [slider0 setValue:(float) [setup getVolumeNumber:0]];
        [slider1 setValue:(float) [setup getVolumeNumber:1]];
        [slider2 setValue:(float) [setup getVolumeNumber:2]];
        [slider3 setValue:(float) [setup getVolumeNumber:3]];
        [slider4 setValue:(float) [setup getVolumeNumber:4]];
        [slider5 setValue:(float) [setup getVolumeNumber:5]];
        [slider6 setValue:(float) [setup getVolumeNumber:6]];
        
        
        if ([units isMPH]) {
            [unitsChooser setSelectedSegmentIndex:0];
        }
        else {
            [unitsChooser setSelectedSegmentIndex:1];
            [label0 setText:@"0-8"];
            [label1 setText:@"8-16"];
            [label2 setText:@"16-24"];
            [label3 setText:@"24-32"];
            [label4 setText:@"32-40"];
            [label5 setText:@"40-48"];
            [label6 setText:@"48+"];
        }
    }
    else {
        [setup setDefaults];
        [slider0 setValue:(float) [setup getVolumeNumber:0]];
        [slider1 setValue:(float) [setup getVolumeNumber:1]];
        [slider2 setValue:(float) [setup getVolumeNumber:2]];
        [slider3 setValue:(float) [setup getVolumeNumber:3]];
        [slider4 setValue:(float) [setup getVolumeNumber:4]];
        [slider5 setValue:(float) [setup getVolumeNumber:5]];
        [slider6 setValue:(float) [setup getVolumeNumber:6]];
        
        
        [unitsChooser setSelectedSegmentIndex:0];
        
        NSString *output = [[NSString alloc] initWithFormat:@"%@\n%@", [units fileOutput], [setup fileOutput] ];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@".txt"];
        
        
        [output writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    if ([unitsChooser selectedSegmentIndex] == 0 ) {
        [units setIsMPH:YES];
    }
    else {
        [units setISKPH:YES];
    }
    
    [setup setVolumeNumber:0 to:[slider0 value]];
    [setup setVolumeNumber:1 to:[slider1 value]];
    [setup setVolumeNumber:2 to:[slider2 value]];
    [setup setVolumeNumber:3 to:[slider3 value]];
    [setup setVolumeNumber:4 to:[slider4 value]];
    [setup setVolumeNumber:5 to:[slider5 value]];
    [setup setVolumeNumber:6 to:[slider6 value]];
    
    
    NSString *output = [[NSString alloc] initWithFormat:@"%@\n%@", [units fileOutput], [setup fileOutput] ];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@".txt"];
    
    
    [output writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    
    
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)unitsSwitch:(id)sender {
    if ([unitsChooser selectedSegmentIndex] == 0) {
        [label0 setText:@"0-5"];
        [label1 setText:@"5-10"];
        [label2 setText:@"10-15"];
        [label3 setText:@"15-20"];
        [label4 setText:@"20-25"];
        [label5 setText:@"25-30"];
        [label6 setText:@"30+"];
    }
    else {
        [label0 setText:@"0-8"];
        [label1 setText:@"8-16"];
        [label2 setText:@"16-24"];
        [label3 setText:@"24-32"];
        [label4 setText:@"32-40"];
        [label5 setText:@"40-48"];
        [label6 setText:@"48+"];
    }
}

- (IBAction)resetButton:(id)sender {
    [setup setDefaults];
    [units setIsMPH:YES];
    [label0 setText:@"0-5"];
    [label1 setText:@"5-10"];
    [label2 setText:@"10-15"];
    [label3 setText:@"15-20"];
    [label4 setText:@"20-25"];
    [label5 setText:@"25-30"];
    [label6 setText:@"30+"];
    [unitsChooser setSelectedSegmentIndex:0];
    [slider0 setValue:(float) [setup getVolumeNumber:0]];
    [slider1 setValue:(float) [setup getVolumeNumber:1]];
    [slider2 setValue:(float) [setup getVolumeNumber:2]];
    [slider3 setValue:(float) [setup getVolumeNumber:3]];
    [slider4 setValue:(float) [setup getVolumeNumber:4]];
    [slider5 setValue:(float) [setup getVolumeNumber:5]];
    [slider6 setValue:(float) [setup getVolumeNumber:6]];
}

@end
