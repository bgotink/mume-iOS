//
//  MoodEntryDelegate.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 17/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnmanagedMoodPerson.h"

@protocol MoodEntryDelegate <NSObject>

- (void)setMoodSpot:(MoodSpot *)moodSpot;
- (void)setMoodActivity:(MoodActivity *)moodActivity;
- (void)setMoodPeeps:(NSArray *)moodPerson;
- (void)setMoodSelections:(NSArray *)moodSelections;

- (void)toggleContact:(UnmanagedMoodPerson *)contact;

@end