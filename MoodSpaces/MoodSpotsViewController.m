//
//  MoodSpotsViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotsViewController.h"
#import <MapKit/MapKit.h>
#import "MoodSpotAnnotation.h"
#import "MoodSpot+CRUD.h"
#import "MoodSpacesAppDelegate.h"
#import "MoodEntry.h"
#import "MoodSelection+Util.h"

@interface MoodSpotsViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation MoodSpotsViewController

@synthesize mapView = _mapView;
@synthesize moodSpots = _moodSpots;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self refresh:self];
}

- (IBAction)refresh:(id)sender
{
    self.moodSpots = [self fetchMoodSpotsAndVectors];
}

- (NSArray *)fetchMoodSpotsAndVectors
{
    MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.document.managedObjectContext;
    NSArray *moodSpots = [MoodSpot queryAllInManagedObjectContext:context];
    for (int mood = 0; mood < 8; mood++) {
        for (MoodSpot *spot in moodSpots) {
            double vector = 0.0;
            for (MoodEntry *entry in spot.in) {
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
            [spot setVector:vector forMood:mood];
        }
    }
    return moodSpots;
}

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:[self moodSpotAnnotations]];
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

- (void)setMoodSpots:(NSArray *)moodSpots
{
    _moodSpots = moodSpots;
    [self updateMapView];
}

- (NSArray *)moodSpotAnnotations
{
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:self.moodSpots.count];
    for(MoodSpot *moodSpot in self.moodSpots) {
        [annotations addObject:[MoodSpotAnnotation annotationForMoodSpot:moodSpot]];
    }
    return annotations;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Don't override the current user location pin...
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    static NSString *IDENTIFIER = @"MoodSpotAnnotation";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:IDENTIFIER];
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:IDENTIFIER];
    }
    view.draggable = NO;
    view.canShowCallout = YES;
    view.annotation = annotation;
    view.image = [(MoodSpotAnnotation *)annotation visualization];
    return view;
}

@end
