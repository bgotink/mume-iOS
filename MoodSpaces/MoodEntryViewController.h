//
//  MoodSpotsViewController.h
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodEntryDataSource.h"
#import "MoodEntryDelegate.h"
#import "WheelView.h"
#import "WheelOverlay.h"

@interface MoodEntryViewController : UIViewController <MoodEntryDataSource, MoodEntryDelegate>

@property (nonatomic, strong) IBOutlet WheelView *wheelView;
@property (nonatomic, strong) IBOutlet WheelOverlay *wheelOverlay;

@property (nonatomic, strong) NSArray *moodSelections;
@property (nonatomic, strong) MoodSpot *moodSpot;
@property (nonatomic, strong) NSMutableSet *moodPeeps;
@property (nonatomic, strong) MoodActivity *moodActivity;


- (void)toggleContact:(UnmanagedMoodPerson *)contact;
- (void)handleWheelTap:(UIGestureRecognizer *) sender;
- (IBAction)reset:(id)sender;

@end
