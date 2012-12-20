//
//  MoodActivitiesViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivitiesViewController.h"
#import "MoodActivity+CRUD.h"
#import "MoodActivity+Util.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodEntry.h"
#import "MoodSelection+Util.h"

@interface MoodActivitiesViewController ()

@property (nonatomic, strong) NSArray *fearActivities;
@property (nonatomic, strong) NSArray *surpriseActivities;
@property (nonatomic, strong) NSArray *sadnessActivities;
@property (nonatomic, strong) NSArray *disgustActivities;
@property (nonatomic, strong) NSArray *angerActivities;
@property (nonatomic, strong) NSArray *anticipationActivities;
@property (nonatomic, strong) NSArray *joyActivities;
@property (nonatomic, strong) NSArray *trustActivities;

@end

@implementation MoodActivitiesViewController

@synthesize moodActivities = _moodActivities;

@synthesize fearActivities = _fearActivities;
@synthesize surpriseActivities = _surpriseActivities;
@synthesize sadnessActivities = _sadnessActivities;
@synthesize disgustActivities = _disgustActivities;
@synthesize angerActivities = _angerActivities;
@synthesize anticipationActivities = _anticipationActivities;
@synthesize joyActivities = _joyActivities;
@synthesize trustActivities = _trustActivities;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh:self];
}

- (IBAction)refresh:(id)sender
{
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    self.moodActivities = [MoodActivity findAllInManagedObjectContext:context];
    [self calculateVectors];
    [self.tableView reloadData];
}

- (void)calculateVectors
{
    for (int mood = 0; mood < 8; mood++) {
        for (MoodActivity *activity in self.moodActivities) {
            double vector = 0.0;
            for (MoodEntry *entry in activity.in) {
                double sum = 0.0;
                double number = 0.0;
                for (MoodSelection *selection in entry.feeling) {
                    NSLog(@"MoodSelection = %@", selection.description);
                    if(selection.mood == mood) {
                        sum += [selection.r floatValue];
                        number++;
                    }
                }
                if (number != 0.0) vector += (sum / number);
            }
            [activity setVector:vector forMood:mood];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = MIN(3, [self activitiesForSection:section].count);
    NSLog(@"%d rows for section %d", rows, section);
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *MOODS = [NSArray arrayWithObjects:@"Fear", @"Surprise", @"Sadness", @"Disgust", @"Anger", @"Anticipation", @"Joy", @"Trust", nil];
    return MOODS[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDENTIFIER = @"MoodActivity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:IDENTIFIER];
    }
    MoodActivity *activity = [[self activitiesForSection:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", indexPath.row + 1, activity.description];
    cell.detailTextLabel.text = [activity vectorForMood:indexPath.section];
    return cell;
}

- (NSArray *)activitiesForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.fearActivities;
            break;
        case 1:
            return self.surpriseActivities;
            break;
        case 2:
            return self.sadnessActivities;
            break;
        case 3:
            return self.disgustActivities;
            break;
        case 4:
            return self.angerActivities;
            break;
        case 5:
            return self.anticipationActivities;
            break;
        case 6:
            return self.joyActivities;
            break;
        case 7:
            return self.trustActivities;
            break;
    }
    return nil;
}

- (NSArray *)fearActivities
{
    if (!_fearActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.fearVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _fearActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_fearActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.fearVector compare:a2.fearVector];
            }];
        }
    }
    return _fearActivities;
}

- (NSArray *)surpriseActivities
{
    if (!_surpriseActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.surpriseVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _surpriseActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_surpriseActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.surpriseVector compare:a2.surpriseVector];
            }];
        }
    }
    return _surpriseActivities;
}

- (NSArray *)sadnessActivities
{
    if (!_sadnessActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.sadnessVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _sadnessActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_sadnessActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.surpriseVector compare:a2.surpriseVector];
            }];
        }
    }
    return _sadnessActivities;
}

- (NSArray *)disgustActivities
{
    if (!_disgustActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.disgustVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _disgustActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_disgustActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.disgustVector compare:a2.disgustVector];
            }];
        }
    }
    return _disgustActivities;
}

- (NSArray *)angerActivities
{
    if (!_angerActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.angerVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _angerActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_angerActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.angerVector compare:a2.angerVector];
            }];
        }
    }
    return _angerActivities;
}

- (NSArray *)anticipationActivities
{
    if (!_anticipationActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.anticipationVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _anticipationActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_anticipationActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.anticipationVector compare:a2.anticipationVector];
            }];
        }
    }
    return _anticipationActivities;
}

- (NSArray *)joyActivities
{
    if (!_joyActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.joyVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _joyActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_joyActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.joyVector compare:a2.joyVector];
            }];
        }
    }
    return _joyActivities;
}

- (NSArray *)trustActivities
{
    if (!_trustActivities) {
        if (self.moodActivities) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodActivity *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.trustVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _trustActivities = [self.moodActivities filteredArrayUsingPredicate:predicate];
            [_trustActivities sortedArrayUsingComparator:^NSComparisonResult(MoodActivity *a1, MoodActivity *a2) {
                return [a1.trustVector compare:a2.trustVector];
            }];
        }
    }
    return _trustActivities;
}

@end
