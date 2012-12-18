//
//  MoodEntryDataSource.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 17/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoodSpot.h"
#import "MoodActivity.h"

@protocol MoodEntryDataSource <NSObject>

- (NSArray *)moodSelections;
- (MoodSpot *)moodSpot;
- (NSSet *)moodPeeps;
- (MoodActivity *)moodActivity;

@end
