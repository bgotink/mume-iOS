//
//  InputViewController.h
//  MoodSpots
//
//  Created by Thypo on 11/29/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodEntryDataSource.h"
#import "MoodEntryDelegate.h"

@interface InputViewController : UITableViewController

@property (nonatomic, weak) UIViewController <MoodEntryDataSource> *moodEntryDataSource;
@property (nonatomic, weak) UIViewController <MoodEntryDelegate> *moodEntryDelegate;

@end
