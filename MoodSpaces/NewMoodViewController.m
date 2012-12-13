//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "NewMoodViewController.h"
#import "MoodSpacesAppDelegate.h"
#import "Log.h"
#import "Polar2DPoint.h"
#import "InputViewController.h"

@interface NewMoodViewController ()

@end

@implementation NewMoodViewController

@synthesize wheelImage;
@synthesize wheelOverlay;
@synthesize actionSelector;
//@synthesize selectedMoods;

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
            Polar2DPoint *point = [Polar2DPoint fromPolarCoordinate:*coord];
            points[i] = point;
            MSLog(@"coord: (%f, %f)", point.r, point.theta);
        }
        InputViewController *destViewController = segue.destinationViewController;
        destViewController.selectedMoods = points;
        //TODO give this class also selectedLocation and such and give them to inputview.
    }
}
@end
