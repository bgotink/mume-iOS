//
//  MoodSpotsViewController.h
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelView.h"
#import "WheelOverlay.h"
#import "MoodEntry.h"
#import "SelectedMoodSpotDataSource.h"

@interface MoodViewController : UIViewController <SelectedMoodSpotDataSource>

@property (nonatomic, strong) IBOutlet WheelView *wheelView;
@property (nonatomic, strong) IBOutlet WheelOverlay *wheelOverlay;

@property (nonatomic, strong) NSArray *selectedMoods;
@property (nonatomic, strong) MoodSpot *selectedMoodSpot;
@property (nonatomic, strong) NSArray *selectedMoodPeeps;
@property (nonatomic, strong) MoodActivity *selectedMoodActivity;


- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender;
- (IBAction)ResetButtonAction:(id)sender;

@end
