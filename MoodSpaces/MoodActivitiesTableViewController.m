//
//  MoodActivitiesTableViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivitiesTableViewController.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodActivity+CRUD.h"
#import "MoodActivity+Util.h"

@interface MoodActivitiesTableViewController ()

@end

@implementation MoodActivitiesTableViewController

@synthesize context = _context;

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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODACTIVITY_ENTITY];
    request.predicate = [NSPredicate predicateWithFormat:@"name.length > 0"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:MOODACTIVITY_NAME
                                                                                     ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDENTIFIER = @"MoodActivitiesTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFIER];
    }
    MoodActivity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = activity.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoodActivity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // TODO: Set MoodActivity
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SegueDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        MoodActivity *moodActivity = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [segue.destinationViewController performSelector:@selector(setMoodActivity:) withObject:moodActivity];
    }
}

@end
