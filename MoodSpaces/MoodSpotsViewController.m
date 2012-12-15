//
//  MoodSpotsViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotsViewController.h"
#import <MapKit/MapKit.h>
#import "MoodSpot.h"
#import "MoodSpot+CRUD.h"
#import "MoodSpotAnnotation.h"
#import "MoodSpacesAppDelegate.h"

@interface MoodSpotsViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation MoodSpotsViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.mapView.delegate = self;
    
    //MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
    //self.moodSpots = [MoodSpot findAllInManagedObjectContext:appDelegate.document.managedObjectContext];
}

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.moodSpots) [self.mapView addAnnotations:self.moodSpots];
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
            viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MoodSpotAnnotationView"];
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"MoodSpotAnnotationView"];
        view.canShowCallout = YES;
    }
    view.annotation = annotation;
    // TODO: view.image = [(MoodSpotAnnotation *)annotation createImage];
    return view;
}

@end
