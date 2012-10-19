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
    NSLog(@"wheeltap");
    
    CGPoint tapPoint = [sender locationInView:_wheelImage];
    int tapX = (int) tapPoint.x;
    int tapY = (int) tapPoint.y;
    
    int centerX = _wheelImage.frame.size.width / 2;
    int centerY = _wheelImage.frame.size.height / 2;
    
    NSLog([NSString stringWithFormat:@"Location: %d x %d", tapX, tapY]);
    
    tapX -= centerX;
    tapY -= centerY;
    
    NSLog([NSString stringWithFormat:@"Centered location: %d x %d", tapX, tapY]);
    
    double r = sqrt(tapX * tapX + tapY * tapY);
    double phi = atan2(-tapY, tapX);
    
    if (phi < 0)
        phi += 2 * M_PI;
    
    NSLog([NSString stringWithFormat:@"Polar: r = %f, phi = %f", r, phi]);
}

@end
