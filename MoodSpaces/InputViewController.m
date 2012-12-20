//
//  InputViewController.m
//  MoodSpots
//
//  Created by Thypo on 11/29/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "InputViewController.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodSelection+CRUD.h"
#import "MoodEntry+CRUD.h"
#import "MoodEntry+Util.h"
#import "MoodPerson+CRUD.h"

@interface InputViewController ()

@end

@implementation InputViewController

@synthesize moodEntryDataSource = _moodEntryDataSource;
@synthesize moodEntryDelegate = _moodEntryDelegate;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (MoodSpot *)moodSpot
{
    return self.moodEntryDataSource.moodSpot;
}

- (NSSet *)moodPeeps
{
    return self.moodEntryDataSource.moodPeeps;
}

- (MoodActivity *)moodActivity
{
    return self.moodEntryDataSource.moodActivity;
}

- (NSArray *)moodSelections
{
    return self.moodEntryDataSource.moodSelections;
}

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
    cell.detailTextLabel.text = self.moodSpot ? self.moodSpot.name : @"Not Set";
    return cell;
}

- (UITableViewCell *)cellForMoodPeepsSelectorInTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [self cellWithReuseIdentifier:@"MoodPeeps" inTableView:tableView];
    cell.textLabel.text = @"MoodPeeps";
    cell.detailTextLabel.text = self.moodPeeps.count > 0 ? [self descriptionForMoodPeeps:self.moodEntryDataSource.moodPeeps] : @"Not Set";
    return cell;
}

- (UITableViewCell *)cellForMoodActivitySelectorInTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [self cellWithReuseIdentifier:@"MoodActivity" inTableView:tableView];
    cell.textLabel.text = @"MoodActivity";
    cell.detailTextLabel.text = self.moodActivity ? self.moodActivity.name : @"Not Set";
    return cell;
}

- (NSString *)descriptionForMoodPeeps:(NSSet *)moodPeeps
{
    return [[moodPeeps allObjects] componentsJoinedByString:@", "];
}

- (IBAction)done:(id)sender
{
    // 1. Grab context
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    
    // 2. Create MoodSelections
    NSMutableSet *selections = [[NSMutableSet alloc] initWithCapacity:self.moodEntryDataSource.moodSelections.count];
    for (PolarCoordinate *coordinate in self.moodEntryDataSource.moodSelections) {
        [selections addObject:[MoodSelection moodSelectionWithPolarCoordinate:coordinate
                                                       inManagedObjectContext:context]];
    }
    
    // 3. Create MoodPeeps
    NSMutableSet *peeps = [[NSMutableSet alloc] initWithCapacity:self.moodEntryDataSource.moodPeeps.count];
    for (UnmanagedMoodPerson *person in self.moodEntryDataSource.moodPeeps) {
        [peeps addObject:[MoodPerson moodPersonWithUnmanagedMoodPerson:person
                                                inManagedObjectContext:context]];
    }
    
    // 4. Create MoodEntry
    [MoodEntry createMoodEntryWithSelections:selections
                                        with:peeps
                                          at:self.moodEntryDataSource.moodSpot
                                       doing:self.moodEntryDataSource.moodActivity
                      inManagedObjectContext:context];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setMoodEntryDataSource:)]) {
        [segue.destinationViewController performSelector:@selector(setMoodEntryDataSource:)
                                              withObject:self.moodEntryDataSource];
    }
    if ([segue.destinationViewController respondsToSelector:@selector(setMoodEntryDelegate:)]) {
        [segue.destinationViewController performSelector:@selector(setMoodEntryDelegate:)
                                              withObject:self.moodEntryDelegate];
    }
}

@end
