//
//  MoodSpotEditorViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotEditorViewController.h"
#import "MoodSpotAnnotation.h"
#import "MoodSpot+CRUD.h"
#import "MoodSpot+Util.h"
#import "MoodSpacesAppDelegate.h"

@interface MoodSpotEditorViewController () <MKMapViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITextField *nameText;

@property (nonatomic, weak) NSManagedObjectContext *context;

@end

@implementation MoodSpotEditorViewController

@synthesize toolbar =  _toolbar;
@synthesize mapView = _mapView;
@synthesize nameText = _nameText;

@synthesize moodSpot = _moodSpot;

@synthesize context = _context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createToolbar];
    self.mapView.delegate = self;
    self.nameText.delegate = self;
    
    if(!self.moodSpot) {
        self.moodSpot = [MoodSpot createOrFetchMoodSpotWithName:@"" inManagedObjectContext:self.context];
    } else {
        self.nameText.text = self.moodSpot.name;
    }
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
        _context = appDelegate.document.managedObjectContext;
    }
    return _context;
}

- (void)createToolbar
{
    UIBarButtonItem *locateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:100
                                                                                  target:self
                                                                                  action:@selector(locateUser:)];
    self.toolbar.items = [NSArray arrayWithObjects:locateButton, nil];
}

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:[MoodSpotAnnotation annotationForMoodSpot:self.moodSpot]];
}

- (void)setMoodSpot:(MoodSpot *)moodSpot
{
    if(_moodSpot != moodSpot) {
        _moodSpot = moodSpot;
        self.nameText.text = _moodSpot.name;
        [self updateMapView];
    }
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

- (MoodSpotAnnotation *)moodSpotAnnotation
{
    return [MoodSpotAnnotation annotationForMoodSpot:self.moodSpot];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // Don't override the current user location pin...
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    static NSString *IDENTIFIER = @"MoodSpotAnnotationView";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:IDENTIFIER];
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:IDENTIFIER];
    }
    view.annotation = annotation;
    view.canShowCallout = NO;
    view.draggable = YES;
    return view;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Update userLocation to lat:%f, long:%f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    NSLog(@"MoodSpot Coordinates are lat:%@, long:%@", self.moodSpot.latitude, self.moodSpot.longitude);
    if ([self.moodSpot.name isEqualToString:@""]) {
        [self.moodSpot setCoordinate:(userLocation.coordinate)];
        [self updateMapView];
        [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)locateUser:(id)sender
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

- (IBAction)done:(id)sender
{
    if ([self.nameText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Enter a name for this MoodSpot"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // TODO: check for duplicate name
        self.moodSpot.name = self.nameText.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end