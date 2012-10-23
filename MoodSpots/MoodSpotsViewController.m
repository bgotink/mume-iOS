//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotsViewController.h"

@interface MoodSpotsViewController ()

@end

@implementation MoodSpotsViewController

@synthesize wheelImage = _wheelImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWheelTap:)];
    [_wheelImage addGestureRecognizer:tapGesture];
    
    NSLog(@"LOADED");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender
{
    CGPoint tapPoint = [sender locationInView:_wheelImage];
    [_wheelImage pointClicked:tapPoint];
}

@end
