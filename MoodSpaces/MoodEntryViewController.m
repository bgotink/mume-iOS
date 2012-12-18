//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntryViewController.h"
#import "MoodSpacesAppDelegate.h"
#import "InputViewController.h"

@interface MoodEntryViewController ()

@end

@implementation MoodEntryViewController

@synthesize wheelView = _wheelView;
@synthesize wheelOverlay = _wheelOverlay;

@synthesize moodSelections = _moodSelections;
@synthesize moodSpot = _moodSpot;
@synthesize moodPeeps = _moodPeeps;
@synthesize moodActivity = _moodActivity;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleWheelTap:)];
    [self.wheelView addGestureRecognizer:tapGesture];
    
    self.wheelOverlay.wheelView = self.wheelView;
    self.wheelOverlay.frame = self.wheelView.frame;
    
    [self.wheelOverlay setNeedsDisplay];
    
    NSLog(@"NewMoodViewController loaded");
}

- (NSMutableSet *)moodPeeps
{
    if (!_moodPeeps) {
        _moodPeeps = [[NSMutableSet alloc] initWithObjects:nil];
    }
    return _moodPeeps;
}

- (void)toggleContact:(UnmanagedMoodPerson *)contact
{
    if ([self isContactChecked:contact]) {
        NSLog(@"Removing %@", contact);
        [self removeContact:contact];
    } else {
        NSLog(@"Adding %@", contact);
        [self.moodPeeps addObject:contact];
    }
}

- (BOOL)isContactChecked:(UnmanagedMoodPerson *)contact
{
    for(UnmanagedMoodPerson *person in self.moodPeeps) {
        if(person.recordId == contact.recordId) {
            return YES;
        }
    }
    return NO;
}

- (void)removeContact:(UnmanagedMoodPerson *)contact
{
    for(UnmanagedMoodPerson *person in self.moodPeeps) {
        if(person.recordId == contact.recordId) {
            [self.moodPeeps removeObject:person];
        }
    }
}

- (void)handleWheelTap:(UIGestureRecognizer *)sender
{
    [self.wheelOverlay pointTapped:[sender locationInView:self.wheelView]];
}

- (IBAction)reset:(id)sender
{
    [self.wheelOverlay reset];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setMoodEntryDelegate:)]) {
        [segue.destinationViewController performSelector:@selector(setMoodEntryDelegate:)
                                              withObject:self];
    }
    if ([segue.destinationViewController respondsToSelector:@selector(setMoodEntryDataSource:)]) {
        [segue.destinationViewController performSelector:@selector(setMoodEntryDataSource:)
                                              withObject:self];
    }
}
@end
