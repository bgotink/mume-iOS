//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodViewController.h"
#import "MoodSpacesAppDelegate.h"

#import "Polar2DPoint.h"
#import "InputViewController.h"

@interface MoodViewController ()

@end

@implementation MoodViewController

@synthesize wheelView = _wheelView;
@synthesize wheelOverlay = _wheelOverlay;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWheelTap:)];
    [self.wheelView addGestureRecognizer:tapGesture];
    
    [self.wheelOverlay setWheelView:self.wheelView];
    [self.wheelOverlay setFrame:self.wheelView.frame];
    
    [self.wheelOverlay setNeedsDisplay];
    
    NSLog(@"NewMoodViewController loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender
{
    CGPoint tapPoint = [sender locationInView:self.wheelView];
    [self.wheelOverlay pointTapped:tapPoint];
}

- (IBAction)ResetButtonAction:(id)sender{
    [self.wheelOverlay resetPoints];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"nextStep"]) {
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:[self.wheelOverlay getNbOfPoints]];
        for (int i = 0; i < [self.wheelOverlay getNbOfPoints]; i++) {
            PolarCoordinate *coord = [self.wheelOverlay getPointPolar:i];
            Polar2DPoint *point = [Polar2DPoint fromPolarCoordinate:*coord];
            points[i] = point;
            NSLog(@"coord: (%f, %f)", point.r, point.theta);
        }
        InputViewController *destViewController = segue.destinationViewController;
        destViewController.selectedMoods = points;
        //TODO give this class also selectedLocation and such and give them to inputview.
    }
}
@end
