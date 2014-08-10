//
//  MainViewController.m
//  SafeCycle
//
//  Created by Alec on 7/14/13.
//  Copyright (c) 2013 Alec. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    //set up UI
    isStarted = NO;
    stopButton.hidden = YES;
    speedLabel.hidden = YES;
    distanceLabel.hidden = YES;
    speedUnits.hidden = YES;
    distanceUnits.hidden = YES;
    pauseButton.hidden = YES;
    resumeButton.hidden = YES;
    
    //set up ads
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad's "unit identifier". This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"ca-app-pub-6242967442096769/1752438532";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    
    [self.view addSubview:bannerView_];
    GADRequest *request= [[GADRequest alloc] init];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (sysVer >= 7.0) {
        if(self.view.frame.size.height == 480) {
            [bannerView_ setFrame:CGRectMake(0,
                                             430,
                                             bannerView_.bounds.size.width,
                                             bannerView_.bounds.size.height)];
        }
        else {
            [bannerView_ setFrame:CGRectMake(0,
                                             520,
                                             bannerView_.bounds.size.width,
                                             bannerView_.bounds.size.height)];
        }
    }
    else {
        if(self.view.frame.size.height == 460) {
            [bannerView_ setFrame:CGRectMake(0,
                                             410,
                                             bannerView_.bounds.size.width,
                                             bannerView_.bounds.size.height)];
        }
        else {
            [bannerView_ setFrame:CGRectMake(0,
                                             500,
                                             bannerView_.bounds.size.width,
                                             bannerView_.bounds.size.height)];
        }
    }


    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:request];
    
    //set up file import
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
        
    }
    else {
        [setup setDefaults];
        [units setIsMPH:true];
        NSString *output = [[NSString alloc] initWithFormat:@"%@\n%@", [units fileOutput], [setup fileOutput] ];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@".txt"];
        
        
        [output writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    }
    
    //setup location services
    if([CLLocationManager locationServicesEnabled]) {
        self.locMan = [[CLLocationManager alloc] init];
        self.locMan.delegate = (id)self;
    }
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//for buttons
- (IBAction)startButtonPressed:(id)sender {
    startButton.hidden = YES;
    stopButton.hidden = NO;
    pressStartLabel.hidden = YES;
    speedLabel.hidden = NO;
    distanceLabel.hidden = NO;
    speedUnits.hidden = NO;
    distanceUnits.hidden = NO;
    settingsButton.hidden = YES;
    pauseButton.hidden = NO;
    distanceVal = 0;
    
    //units setup
    if ([units isMPH]) {
        speedUnits.text=@"MPH";
        distanceUnits.text=@"MI";
    }
    else {
        speedUnits.text=@"KPH";
        distanceUnits.text=@"KM";
    }
    
    //lower volume
    musicPlayer.volume = [setup getVolumeNumber:0];

    
    [self.locMan startUpdatingLocation];
    
}
- (IBAction)stopButtonPressed:(id)sender {
    stopButton.hidden = YES;
    startButton.hidden = NO;
    pressStartLabel.hidden = NO;
    speedLabel.hidden = YES;
    distanceLabel.hidden = YES;
    speedUnits.hidden = YES;
    distanceUnits.hidden = YES;
    settingsButton.hidden = NO;
    pauseButton.hidden = YES;
    resumeButton.hidden = YES;
    
    [self.locMan stopUpdatingLocation];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [self.locMan stopUpdatingLocation];
    pauseButton.hidden = YES;
    resumeButton.hidden = NO;
    speedLabel.text=@"Paused";
}

- (IBAction)resumeButtonPressed:(id)sender {
    resumeButton.hidden = YES;
    pauseButton.hidden = NO;
    
    //lower volume
    musicPlayer.volume = [setup getVolumeNumber:0];
    
    
    [self.locMan startUpdatingLocation];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    //set up UI
    isStarted = NO;
    stopButton.hidden = YES;
    speedLabel.hidden = YES;
    distanceLabel.hidden = YES;
    speedUnits.hidden = YES;
    distanceUnits.hidden = YES;
    
    //set up file import
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
        
    }
    else {
        [setup setDefaults];
        
        NSString *output = [[NSString alloc] initWithFormat:@"%@\n%@", [units fileOutput], [setup fileOutput] ];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@".txt"];
        
        
        [output writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    }
    
    //setup location services
    if([CLLocationManager locationServicesEnabled]) {
        self.locMan = [[CLLocationManager alloc] init];
        self.locMan.delegate = (id)self;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

//location services
//for location services:
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{ /* We received the new location */
    NSString *text;
    if(newLocation.speed < 0) {
        speedLabel.text = @"No GPS";
        distanceLabel.text = @"No GPS";
    }
    else {
        double dist = [newLocation distanceFromLocation:oldLocation];
        if (!(dist < 0)) {
            distanceVal += dist;
        }
        
        //set volume and update values
        if ([units isMPH]) {
            text = [NSString stringWithFormat:@"%.2f",newLocation.speed*2.236936];
            if ([text isEqualToString:@"No GPS"]) {
                distanceLabel.text=text;
            }
            else {
                distanceLabel.text=[NSString stringWithFormat:@"%.2f", distanceVal*0.000621371];
            }
            speedLabel.text = text;
            
            if (newLocation.speed*2.236936 > 30) {
                musicPlayer.volume = [setup getVolumeNumber:6];
            }
            else if(newLocation.speed*2.236936 > 25 && newLocation.speed*2.236936 <= 30) {
                musicPlayer.volume = [setup getVolumeNumber:5];
            }
            else if(newLocation.speed*2.236936 > 20 && newLocation.speed*2.236936 <= 25) {
                musicPlayer.volume = [setup getVolumeNumber:4];
            }
            else if(newLocation.speed*2.236936 > 15 && newLocation.speed*2.236936 <=20) {
                musicPlayer.volume = [setup getVolumeNumber:3];
            }
            else if(newLocation.speed*2.236936 > 10 && newLocation.speed*2.236936 <=15) {
                musicPlayer.volume = [setup getVolumeNumber:2];
            }
            else if(newLocation.speed*2.236936 > 5 && newLocation.speed*2.236936 <=10) {
                musicPlayer.volume = [setup getVolumeNumber:1];
            }
            else if (newLocation.speed*2.236936 >=0 && newLocation.speed*2.236936 <=5) {
                musicPlayer.volume = [setup getVolumeNumber:0];
            }
        }
        else {
            distanceLabel.text=[NSString stringWithFormat:@"%.2f", distanceVal*0.001];
            text = [NSString stringWithFormat:@"%.2f",newLocation.speed*3.6];
            speedLabel.text = text;
            
            if (newLocation.speed*3.6 > 48) {
                musicPlayer.volume = [setup getVolumeNumber:6];
            }
            else if(newLocation.speed*3.6 > 40 && newLocation.speed*3.6 <= 48) {
                musicPlayer.volume = [setup getVolumeNumber:5];
            }
            else if(newLocation.speed*3.6 > 32 && newLocation.speed*3.6 <= 40) {
                musicPlayer.volume = [setup getVolumeNumber:4];
            }
            else if(newLocation.speed*3.6 > 24 && newLocation.speed*3.6 <=32) {
                musicPlayer.volume = [setup getVolumeNumber:3];
            }
            else if(newLocation.speed*3.6 > 16 && newLocation.speed*3.6 <=24) {
                musicPlayer.volume = [setup getVolumeNumber:2];
            }
            else if(newLocation.speed*3.6 > 8 && newLocation.speed*3.6 <=16) {
                musicPlayer.volume = [setup getVolumeNumber:1];
            }
            else if (newLocation.speed*3.6 >=0 && newLocation.speed*3.6 <=8) {
                musicPlayer.volume = [setup getVolumeNumber:0];
            }
            
        }
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
        speedLabel.text = @"No GPS";
        distanceLabel.text = @"No GPS";
}


@end
