//
//  MoodPeepsViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPeepsViewController.h"
#import "MoodPerson+CRUD.h"
#import "MoodPerson+Util.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodEntry.h"
#import "MoodSelection+Util.h"

@interface MoodPeepsViewController ()

@property (nonatomic, strong) NSArray *fearPeeps;
@property (nonatomic, strong) NSArray *surprisePeeps;
@property (nonatomic, strong) NSArray *sadnessPeeps;
@property (nonatomic, strong) NSArray *disgustPeeps;
@property (nonatomic, strong) NSArray *angerPeeps;
@property (nonatomic, strong) NSArray *anticipationPeeps;
@property (nonatomic, strong) NSArray *joyPeeps;
@property (nonatomic, strong) NSArray *trustPeeps;

@end

@implementation MoodPeepsViewController

@synthesize moodPeeps = _moodPeeps;

@synthesize fearPeeps = _fearPeeps;
@synthesize surprisePeeps = _surprisePeeps;
@synthesize sadnessPeeps = _sadnessPeeps;
@synthesize disgustPeeps = _disgustPeeps;
@synthesize angerPeeps = _angerPeeps;
@synthesize anticipationPeeps = _anticipationPeeps;
@synthesize joyPeeps = _joyPeeps;
@synthesize trustPeeps = _trustPeeps;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh:self];
}

- (IBAction)refresh:(id)sender
{
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    self.moodPeeps = [MoodPerson findAllInManagedObjectContext:context];
    [self calculateVectors];
    [self.tableView reloadData];
}

- (void)calculateVectors
{
    for (int mood = 0; mood < 8; mood++) {
        for (MoodPerson *person in self.moodPeeps) {
            double vector = 0.0;
            for (MoodEntry *entry in person.in) {
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
            [person setVector:vector forMood:mood];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = MIN(3, [self peepsForSection:section].count);
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
    static NSString *IDENTIFIER = @"MoodPerson";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:IDENTIFIER];
    }
    MoodPerson *person = [[self peepsForSection:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", indexPath.row + 1, person.description];
    cell.detailTextLabel.text = [person vectorForMood:indexPath.section];
    return cell;
}

- (NSArray *)peepsForSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.fearPeeps;
            break;
        case 1:
            return self.surprisePeeps;
            break;
        case 2:
            return self.sadnessPeeps;
            break;
        case 3:
            return self.disgustPeeps;
            break;
        case 4:
            return self.angerPeeps;
            break;
        case 5:
            return self.anticipationPeeps;
            break;
        case 6:
            return self.joyPeeps;
            break;
        case 7:
            return self.trustPeeps;
            break;
    }
    return nil;
}

- (NSArray *)fearPeeps
{
    if (!_fearPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.fearVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _fearPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.fearVector compare:a1.fearVector];
            }];
        }
    }
    return _fearPeeps;
}

- (NSArray *)surprisePeeps
{
    if (!_surprisePeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.surpriseVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _surprisePeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.surpriseVector compare:a1.surpriseVector];
            }];
        }
    }
    return _surprisePeeps;
}

- (NSArray *)sadnessPeeps
{
    if (!_sadnessPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.sadnessVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _sadnessPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.surpriseVector compare:a1.surpriseVector];
            }];
        }
    }
    return _sadnessPeeps;
}

- (NSArray *)disgustPeeps
{
    if (!_disgustPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.disgustVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _disgustPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.disgustVector compare:a1.disgustVector];
            }];
        }
    }
    return _disgustPeeps;
}

- (NSArray *)angerPeeps
{
    if (!_angerPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.angerVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _angerPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.angerVector compare:a1.angerVector];
            }];
        }
    }
    return _angerPeeps;
}

- (NSArray *)anticipationPeeps
{
    if (!_anticipationPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.anticipationVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _anticipationPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.anticipationVector compare:a1.anticipationVector];
            }];
        }
    }
    return _anticipationPeeps;
}

- (NSArray *)joyPeeps
{
    if (!_joyPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.joyVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _joyPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.joyVector compare:a1.joyVector];
            }];
        }
    }
    return _joyPeeps;
}

- (NSArray *)trustPeeps
{
    if (!_trustPeeps) {
        if (self.moodPeeps) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MoodPerson *evaluatedObject, NSDictionary *bindings) {
                return ![evaluatedObject.trustVector isEqualToNumber:[NSNumber numberWithDouble:0.0]];
            }];
            _trustPeeps = [[self.moodPeeps filteredArrayUsingPredicate:predicate] sortedArrayUsingComparator:^NSComparisonResult(MoodPerson *a1, MoodPerson *a2) {
                return [a2.trustVector compare:a1.trustVector];
            }];
        }
    }
    return _trustPeeps;
}

@end
