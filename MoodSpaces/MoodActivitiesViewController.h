//
//  MoodActivitiesViewController.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodActivitiesViewController : UITableViewController

@property (nonatomic, strong) NSArray *moodActivities;

- (IBAction)refresh:(id)sender;

@end
