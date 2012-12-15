//
//  InputViewController.h
//  MoodSpots
//
//  Created by Thypo on 11/29/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodSpot.h"
#import "MoodActivity.h"

@interface InputViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MoodSpot* moodSpot;
@property (nonatomic, strong) MoodActivity *moodActivity;
@property (nonatomic, strong) NSArray *moodPeeps;

@property (nonatomic, strong) NSArray *selectedMoods;

@end
