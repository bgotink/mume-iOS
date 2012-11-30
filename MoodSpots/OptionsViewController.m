//
//  OptionsViewController.m
//  MoodSpots
//
//  Created by Thypo on 11/29/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "OptionsViewController.h"
#import "Log.h"
#import "MoodSpotsAppDelegate.h"
#import <CoreData/CoreData.h>
#import "Location.h"
#import "Activity.h"
#import "Person.h"
#import "InputViewController.h"
#import "Polar2dPoint.h"
#import "MoodSelection.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController {
    NSArray *detailedOptions;
}

@synthesize optionName;
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
    MoodSpotsAppDelegate *appDelegate = (MoodSpotsAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    
    //Setting the values of the detailedOption to the available options of the selected option.
    if([optionName isEqualToString:@"Location"]){
        MSLog(@"Location is clicked");
        detailedOptions = [self fetchAllLocations:context];
    } else if([optionName isEqualToString:@"Activity"]){
        MSLog(@"Activity is clicked");
        detailedOptions = [self fetchAllActivities:context];
    } else if([optionName isEqualToString:@"People that are nearby"]){
        MSLog(@"People that are nearby is clicked");
        detailedOptions = [self fetchAllNearbyPeople:context];
    }
    
    
    //detailedOptions = [NSArray arrayWithObjects:@"Location", @"Activity", @"People that are nearby", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [detailedOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DetailedOptionCell";
    
    UITableViewCell *cell = [localTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [detailedOptions objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMainOptions"]) {
        MSLog(@"prepareForSegue for showMainOptions is called");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        InputViewController *destViewController = segue.destinationViewController;
        MSLog(@"object: %@", [detailedOptions objectAtIndex:indexPath.row]);
        MSLog(@"key: %@",optionName);
        
        if([optionName isEqualToString:@"Location"]){
            destViewController.selectedLocation = [detailedOptions objectAtIndex:indexPath.row];
            destViewController.selectedActivity = selectedActivity;
            destViewController.selectedPerson = selectedPerson;
            
            MSLog(@"selected loc = %@", destViewController.selectedLocation);
            MSLog(@"selected act = %@", destViewController.selectedActivity);
            MSLog(@"selected pers = %@", destViewController.selectedPerson);
        } else if([optionName isEqualToString:@"Activity"]){
            destViewController.selectedActivity = [detailedOptions objectAtIndex:indexPath.row];
            destViewController.selectedLocation = selectedLocation;
            destViewController.selectedPerson = selectedPerson;
            
            MSLog(@"selected loc = %@", destViewController.selectedLocation);
            MSLog(@"selected act = %@", destViewController.selectedActivity);
            MSLog(@"selected pers = %@", destViewController.selectedPerson);
        } else if([optionName isEqualToString:@"People that are nearby"]){
            destViewController.selectedPerson = [detailedOptions objectAtIndex:indexPath.row];
            destViewController.selectedLocation = selectedLocation;
            destViewController.selectedActivity = selectedActivity;
            
            MSLog(@"selected loc = %@", destViewController.selectedLocation);
            MSLog(@"selected act = %@", destViewController.selectedActivity);
            MSLog(@"selected pers = %@", destViewController.selectedPerson);
        } else{
            MSLog(@"Error, the text in cell %d is not equal to one of the options", indexPath.row);
        }
        destViewController.selectedMoods = selectedMoods;
        
        //[destViewController.selectedItems setObject:[detailedOptions objectAtIndex:indexPath.row] forKey:optionName];
        //MSLog(@"dictionary: %@", destViewController.selectedItems);
        //Implement the following method to make the text of the cells green when an object is selected.
    }
}

//The following three methods look very much alike but there is a difference in the for loop, they can be refactored though but you will still need 3 different methodes + a fourth method with the refactored code.
- (NSArray *)fetchAllLocations:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    NSError *error;
    NSArray *locations = [context executeFetchRequest:request error:&error];
    NSMutableArray *locationNames = [[NSMutableArray alloc] initWithCapacity:[locations count]];
    for(int i = 0; i < [locations count]; i++){
        locationNames[i] = ((Location *)locations[i]).location;
    }
    return locationNames;
}

- (NSArray *)fetchAllActivities:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Activity"];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    NSError *error;
    NSArray *activities = [context executeFetchRequest:request error:&error];
    NSMutableArray *activityNames = [[NSMutableArray alloc] initWithCapacity:[activities count]];
    for(int i = 0; i < [activities count]; i++){
        activityNames[i] = ((Activity *)activities[i]).activity;
    }
    return activityNames;
}

- (NSArray *)fetchAllNearbyPeople:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    NSError *error;
    NSArray *people = [context executeFetchRequest:request error:&error];
    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:[people count]];
    for(int i = 0; i < [people count]; i++){
        names[i] = ((Person *)people[i]).name;
    }
    return names;
}


@end
