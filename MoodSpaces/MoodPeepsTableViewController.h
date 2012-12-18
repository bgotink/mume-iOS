//
//  MoodPeepsTableViewController.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodEntryDataSource.h"
#import "MoodEntryDelegate.h"

@interface MoodPeepsTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *contacts;

@property (nonatomic, weak) UIViewController <MoodEntryDataSource> *moodEntryDataSource;
@property (nonatomic, weak) UIViewController <MoodEntryDelegate> *moodEntryDelegate;

@end
