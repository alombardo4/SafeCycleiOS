//
//  MainViewController.h
//  SafeCycle
//
//  Created by Alec on 7/14/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "FlipsideViewController.h"
#import "VolumeSetup.h"
#import "Units.h"
#import "FileHandler.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreLocation/CoreLocation.h>
#import "GADBannerView.h"


@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>
{
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UILabel *pressStartLabel;
    IBOutlet UILabel *speedLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *speedUnits;
    IBOutlet UILabel *distanceUnits;
    IBOutlet UIButton *settingsButton;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *resumeButton;
    
    GADBannerView *bannerView_;
    
    bool isStarted;
    Units *units;
    VolumeSetup *setup;
    MPMusicPlayerController *musicPlayer;
    double distanceVal;
    
}

@property (nonatomic, strong) CLLocationManager *locMan;

@property (weak, nonatomic) id <UIPageViewControllerDelegate> delegate;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)resumeButtonPressed:(id)sender;

@end
