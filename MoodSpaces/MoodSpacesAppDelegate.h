//
//  MoodSpotsAppDelegate.h
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodSpacesAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIManagedDocument *document;
@property (strong, nonatomic) UIWindow *window;

- (void)documentIsReady;
- (void)saveDocument;

@end
