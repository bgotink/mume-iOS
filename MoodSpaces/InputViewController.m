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
#import "Log.h"
#import "NewMoodViewController.h"
#import "MoodSelection+Create.h"
#import "MoodEntry.h"
#import "MoodEntry+Create.h"
#import "Polar2dPoint.h"
#import "MoodPerson.h"
#import "MoodPerson+Create.h"
#import "MoodSpot.h"
#import "MoodSpot+Create.h"
#import "MoodActivity.h"
#import "MoodActivity+Create.h"

@interface InputViewController ()

@end

@implementation InputViewController {
    NSArray *options;
}

@synthesize tableView;
@synthesize selectedLocation;
@synthesize selectedActivity;
@synthesize selectedPerson;
@synthesize selectedMoods;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MSLog(@"viewDidLoad is called");
    options = [NSArray arrayWithObjects:@"Location", @"Activity", @"People that are nearby", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [options count];
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"GeneralOptionCell";
    
    UITableViewCell *cell = [localTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [options objectAtIndex:indexPath.row];
    
    
    MSLog(@"indexPath: %d, %d", indexPath.row, indexPath.section);
    
    if(indexPath.row == 0){
        [self updateCellTextColor:cell selectionMade:selectedLocation];
    } else if(indexPath.row == 1){
        [self updateCellTextColor:cell selectionMade:selectedActivity];
    } else {
        [self updateCellTextColor:cell selectionMade:selectedPerson];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailedOptions"]) {
        MSLog(@"prepareForSegue is called");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        OptionsViewController *destViewController = segue.destinationViewController;
        destViewController.optionName = [options objectAtIndex:indexPath.row];
        
        destViewController.selectedLocation = selectedLocation;
        destViewController.selectedActivity = selectedActivity;
        destViewController.selectedPerson = selectedPerson;
        destViewController.selectedMoods = selectedMoods;
    } /*else if([segue.identifier isEqualToString:@"backSelectMood"]){
        NewMoodViewController *destViewController = segue.destinationViewController;
        destViewController.selectedMoods = selectedMoods;
        //TODO put other like location and such in newmoodview too.
    }*/
}

- (void)updateCellTextColor:(UITableViewCell *)cell selectionMade:(NSString *)selection{
    MSLog(@"updateCellTextColor is called with %@", selection);
    if(selection){
        cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    } else{
        cell.textLabel.textColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
}

- (IBAction)SubmitButtonAction:(id)sender{
    MSLog(@"Submit is pressed");
    //TODO check of er nog dingen zijn die op nil staan en geef dan een notificatie aan de user dat hij dat nog moet selecteren.
    
    //Step 1: Fetch the NSManagedObjectContext from the AppDelegate
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    
    //Step 2: Fetch all the users input
    //Step 2.1: Fetch the selected moods.
    int numberOfSelectedMoods = [selectedMoods count];
    NSMutableArray *localSelectedMoods = [[NSMutableArray alloc] initWithCapacity:numberOfSelectedMoods];
    for (int i = 0; i < numberOfSelectedMoods; i++) {
        Polar2dPoint *coord = [selectedMoods objectAtIndex:i];
        [localSelectedMoods addObject:[MoodSelection createMoodSelection:[NSNumber numberWithFloat:coord.r] withTheta:[NSNumber numberWithFloat:coord.phi] inManagedObjectContext:context]];
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
    
    MSLog(@"Submit successful");
}

@end
