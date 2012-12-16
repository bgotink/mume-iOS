//
//  InputViewController.m
//  MoodSpots
//
//  Created by Thypo on 11/29/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpacesAppDelegate.h"
#import "InputViewController.h"
#import "OptionsViewController.h"
#import "Polar2DPoint.h"
#import "MoodViewController.h"

#import "MoodSelection+CRUD.h"
#import "MoodEntry+CRUD.h"
#import "MoodPerson+CRUD.h"
#import "MoodSpot+CRUD.h"
#import "MoodActivity+CRUD.h"

@interface InputViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation InputViewController

@synthesize tableView = _tableView;

@synthesize moodSpot = _moodSpot;
@synthesize moodActivity = _moodActivity;
@synthesize moodPeeps = _moodPeeps;

@synthesize selectedMoods = _selectedMoods;

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = [self cellForMoodSpotSelectorInTableView:tableView];
            break;
        case 1:
            cell = [self cellForMoodPeepsSelectorInTableView:tableView];
            break;
        case 2:
            cell = [self cellForMoodActivitySelectorInTableView:tableView];
            break;
    }
    return cell;
}

- (UITableViewCell *)cellWithReuseIdentifier:(NSString *)identifier
                                 inTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:identifier];
    }
    return cell;
}

- (UITableViewCell *)cellForMoodSpotSelectorInTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [self cellWithReuseIdentifier:@"MoodSpot" inTableView:tableView];
    cell.textLabel.text = @"MoodSpot";
    cell.detailTextLabel.text = @"Not Set";
    return cell;
}

- (UITableViewCell *)cellForMoodPeepsSelectorInTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [self cellWithReuseIdentifier:@"MoodPeeps" inTableView:tableView];
    cell.textLabel.text = @"MoodPeeps";
    cell.detailTextLabel.text = @"Not Set";
    return cell;
}

- (UITableViewCell *)cellForMoodActivitySelectorInTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [self cellWithReuseIdentifier:@"MoodActivity" inTableView:tableView];
    cell.textLabel.text = @"MoodActivity";
    cell.detailTextLabel.text = @"Not Set";
    return cell;
}\

- (IBAction)moodPeeps:(id)sender
{
    
}

- (IBAction)done:(id)sender
{
    /*
    //TODO check of er nog dingen zijn die op nil staan en geef dan een notificatie aan de user dat hij dat nog moet selecteren.
    
    //Step 1: Fetch the NSManagedObjectContext from the AppDelegate
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    
    //Step 2: Fetch all the users input
    //Step 2.1: Fetch the selected moods.
    int numberOfSelectedMoods = [selectedMoods count];
    NSMutableArray *localSelectedMoods = [[NSMutableArray alloc] initWithCapacity:numberOfSelectedMoods];
    for (int i = 0; i < numberOfSelectedMoods; i++) {
        Polar2DPoint *coord = [selectedMoods objectAtIndex:i];
        [localSelectedMoods addObject:[MoodSelection createMoodSelection:[NSNumber numberWithFloat:coord.r] withTheta:[NSNumber numberWithFloat:coord.theta] inManagedObjectContext:context]];
    }
    NSSet *selectedMoodsSet = [NSSet setWithArray:localSelectedMoods];
    
    //Step 2.2: Fetch people that are close by.
    //TODO: create the possibility to select MULTIPLE nearby people on the input screen.
    MoodPerson *moodPerson = [[MoodPerson queryMoodPersonWithName:selectedPerson inManagedObjectContext:context] objectAtIndex:0];
    NSSet *moodPeople = [NSSet setWithObjects: moodPerson, nil];
    
    //Step 2.3: Fetch the location.
    MoodSpot *moodSpot = [MoodSpot createMoodSpotWithName:selectedLocation atLatitude:0.0 atLongitude:0.0 inManagedObjectContext:context];
    //MoodSpot *location = [MoodSpot createLocation:selectedLocation inManagedObjectContext:context];
    
    //Step 2.4: Fetch the activity.
    MoodActivity *activity = [MoodActivity createMoodActivityWithName:selectedActivity inManagedObjectContext:context];
    
    //Step 3: create the moodEntry
    [MoodEntry createMoodEntryWithSelections:selectedMoodsSet with:moodPeople at:moodSpot doing:activity inManagedObjectContext:context];
    
    //Step 4: explicitely save the document here.
    [appDelegate saveDocument];
    
    NSLog(@"Submit successful");
     */
}

@end
