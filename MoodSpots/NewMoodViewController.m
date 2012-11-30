//
//  MoodSpotsViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "NewMoodViewController.h"
#import "MoodSpotsAppDelegate.h"
#import "Log.h"
#import "Person.h"
#import "Person+Create.h"
#import "MoodSelection.h"
#import "MoodSelection+Create.h"
#import "Location.h"
#import "Location+Create.h"
#import "Activity.h"
#import "Activity+Create.h"
#import "MoodEntry.h"
#import "MoodEntry+Create.h"
#import "InputViewController.h"
#import "Polar2dPoint.h"

@interface NewMoodViewController ()

@end

@implementation NewMoodViewController

@synthesize wheelImage;
@synthesize wheelOverlay;
@synthesize actionSelector;
//@synthesize selectedMoods;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWheelTap:)];
    [wheelImage addGestureRecognizer:tapGesture];
    
    [wheelOverlay setWheelView:wheelImage];
    [wheelOverlay setFrame:wheelImage.frame];
    
    [actionSelector setValues:@[@"NewMoodViewController",@"this",@"is",@"hardcoded"]];
    [wheelOverlay setNeedsDisplay];
    //We come back from the selection of location etc and maybe moods have already been selected.
    /*if(selectedMoods){
        for (int i = 0; i < [selectedMoods count]; i++) {
            NSValue *val = [selectedMoods objectAtIndex:i];
            CGPoint p = [val CGPointValue];
            MSLog(@"CGPoint: %f, %f", p.x, p.y);
            [wheelOverlay pointTapped:p];
            //[wheelOverlay pointTapped:*(__bridge CGPoint *)selectedMoods[i]];
        }
    }*/
    
    MSLog(@"NewMoodViewController loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender
{
    CGPoint tapPoint = [sender locationInView:wheelImage];
    [wheelOverlay pointTapped:tapPoint];
}

- (IBAction)ResetButtonAction:(id)sender{
    [wheelOverlay resetPoints];
}

/* This method should create a new MoodEntry based on the users input and save it in the database. */
- (IBAction)SubmitButtonAction:(id)sender{
    MSLog(@"Submit is pressed");
    
    //Step 1: Fetch the NSManagedObjectContext from the AppDelegate
    MoodSpotsAppDelegate *appDelegate = (MoodSpotsAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    
    //Step 2: Fetch all the users input
    
    //Step 2.1: Fetch the selected moods.
    int numberOfSelectedMoods = [wheelOverlay getNbOfPoints];
    if(numberOfSelectedMoods < 1){
        MSLog(@"TODO: MAKE WARNING/NOTIFICATION OF THIS");
        MSLog(@"No mood has been selected, please make a selection");
        return;
    }
    NSMutableArray *localSelectedMoods = [[NSMutableArray alloc] initWithCapacity:numberOfSelectedMoods];
    for (int i = 0; i < numberOfSelectedMoods; i++) {
        PolarCoordinate *coord = [wheelOverlay getPointPolar:i];
        [localSelectedMoods addObject:[MoodSelection createMoodSelection:[NSNumber numberWithFloat:coord->r] withTheta:[NSNumber numberWithFloat:coord->phi] inManagedObjectContext:context]];
    }
    NSSet *selectedMoodsSet = [NSSet setWithArray:localSelectedMoods];
    /*for(MoodSelection *result in selectedMoodsSet){
        NSLog(@"sel: (%@, %@)", result.r, result.theta);
    }*/
    
    //Step 2.2: Fetch people that are close by.
    //TODO: create the possibility to select closeby people on the input screen.
    NSSet *closePeople = [NSSet setWithObjects: nil];
    
    //Step 2.3: Fetch the location.
    //TODO: create the possibility to select the location on the input screen.
    Location *location = [Location createLocation:@"location" inManagedObjectContext:context];
    
    //Step 2.4: Fetch the activity.
    //TODO: create the possibility to select the activity on the input screen.
    Activity *activity = [Activity createActivity:@"activity" inManagedObjectContext:context];
    
    //Step 3: create the moodEntry
    [MoodEntry createMoodEntry:closePeople at:location withSelected:selectedMoodsSet doing:activity inManagedObjectContext:context];
    
    //Step 4: explicitely save the document here.
    [appDelegate saveDocument];
    
    MSLog(@"Submit successful");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"nextStep"]) {
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:[wheelOverlay getNbOfPoints]];
        for (int i = 0; i < [wheelOverlay getNbOfPoints]; i++) {
            PolarCoordinate *coord = [wheelOverlay getPointPolar:i];
            Polar2dPoint *point = [Polar2dPoint fromPolarCoordinate:*coord];
            points[i] = point;
            MSLog(@"coord: (%f, %f)", point.r, point.phi);
            //points[i] = [wheelOverlay getPointPolar:i];
            //CGPoint p = *[wheelOverlay getPoint:i];
            //MSLog(@"input CGPoint: %f, %f", p.x,p.y);
            //points[i] = [NSValue valueWithCGPoint:p];
            //points[i] = (__bridge id)(([wheelOverlay getPoint:i]));
        }
        InputViewController *destViewController = segue.destinationViewController;
        destViewController.selectedMoods = points;
        //TODO give this class also selectedLocation and such and give them to inputview.
    }
}

@end
