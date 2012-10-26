//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "NewMoodViewController.h"

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
    
    NSLog(@"NewMoodViewController loaded");
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

@end
