//
//  MoodSpotsTableViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 14/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotsTableViewController.h"
#import "MoodSpot+CRUD.h"
#import "MoodSpot+Util.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodSpotEditorViewController.h"

@interface MoodSpotsTableViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation MoodSpotsTableViewController 

@synthesize context = _context;
@synthesize moodEntryDataSource = _moodEntryDataSource;
@synthesize moodEntryDelegate = _moodEntryDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFetchedResultsController];
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
        _context = appDelegate.document.managedObjectContext;
    }
    return _context;
}

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODSPOT_ENTITY];
    request.predicate = [NSPredicate predicateWithFormat:@"name.length > 0"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:MOODSPOT_NAME
                                                                                    ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"MoodSpots"];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDENTIFIER = @"MoodSpotsTableViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER
                                                            forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    MoodSpot *moodSpot = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"MoodSpot = %@", moodSpot);
    cell.textLabel.text = moodSpot.name;
    cell.detailTextLabel.text = moodSpot.subtitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoodSpot *moodSpot = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.moodEntryDelegate setMoodSpot:moodSpot];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        MoodSpot *moodSpot = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [segue.destinationViewController performSelector:@selector(setMoodSpot:) withObject:moodSpot];
    }
}

@end
