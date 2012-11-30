//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "NewMoodViewController.h"
#import "MoodSpotsAppDelegate.h"
#import "Log.h"
#import "Person.h"
#import "Person+Create.h"
#import "MoodSelection.h"
#import "MoodSelection+Create.h"
#import "Location.h"
#import "Location+Create.h"
#import "Activity.h"
#import "Activity+Create.h"
#import "MoodEntry.h"
#import "MoodEntry+Create.h"
#import "InputViewController.h"
#import "Polar2dPoint.h"

@interface NewMoodViewController ()

@end

@implementation NewMoodViewController

@synthesize wheelImage;
@synthesize wheelOverlay;
@synthesize actionSelector;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWheelTap:)];
    [wheelImage addGestureRecognizer:tapGesture];
    
    [wheelOverlay setWheelView:wheelImage];
    [wheelOverlay setFrame:wheelImage.frame];
    
    [actionSelector setValues:@[@"NewMoodViewController",@"this",@"is",@"hardcoded"]];
    [wheelOverlay setNeedsDisplay];
    
    MSLog(@"NewMoodViewController loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender
{
    CGPoint tapPoint = [sender locationInView:wheelImage];
    [wheelOverlay pointTapped:tapPoint];
}

- (IBAction)ResetButtonAction:(id)sender{
    [wheelOverlay resetPoints];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"nextStep"]) {
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:[wheelOverlay getNbOfPoints]];
        for (int i = 0; i < [wheelOverlay getNbOfPoints]; i++) {
            PolarCoordinate *coord = [wheelOverlay getPointPolar:i];
            Polar2dPoint *point = [Polar2dPoint fromPolarCoordinate:*coord];
            points[i] = point;
            MSLog(@"coord: (%f, %f)", point.r, point.phi);
        }
        InputViewController *destViewController = segue.destinationViewController;
        destViewController.selectedMoods = points;
        //TODO give this class also selectedLocation and such and give them to inputview.
    }
}

@end
