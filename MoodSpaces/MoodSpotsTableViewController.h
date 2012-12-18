//
//  MoodSpotsTableViewController.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 14/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "MoodEntryDataSource.h"
#import "MoodEntryDelegate.h"

@interface MoodSpotsTableViewController : CoreDataTableViewController

@property (nonatomic, weak) UIViewController <MoodEntryDataSource> *moodEntryDataSource;
@property (nonatomic, weak) UIViewController <MoodEntryDelegate> *moodEntryDelegate;

@end
