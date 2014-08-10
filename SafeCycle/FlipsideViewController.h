//
//  FlipsideViewController.h
//  SafeCycle
//
//  Created by Alec on 7/14/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Units.h"
#import "VolumeSetup.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController
{
    IBOutlet UISlider *slider0;
    IBOutlet UISlider *slider1;
    IBOutlet UISlider *slider2;
    IBOutlet UISlider *slider3;
    IBOutlet UISlider *slider4;
    IBOutlet UISlider *slider5;
    IBOutlet UISlider *slider6;
    IBOutlet UILabel *label0;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UILabel *label4;
    IBOutlet UILabel *label5;
    IBOutlet UILabel *label6;
    IBOutlet UISegmentedControl *unitsChooser;
    IBOutlet UIButton *resetButton;
    Units *units;
    VolumeSetup *setup;
    
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
- (IBAction)unitsSwitch:(id)sender;
- (IBAction)resetButton:(id)sender;


@end
