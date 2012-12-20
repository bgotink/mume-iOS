//
//  MoodSpotsAppDelegate.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpacesAppDelegate.h"
#import <CoreData/CoreData.h>

@implementation MoodSpacesAppDelegate

@synthesize document = _document;

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.document.fileURL.path]) {
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (!success) NSLog(@"Could not create document at %@", self.document.fileURL.path);
            else NSLog(@"Created document at %@", self.document.fileURL.path);
        }];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (!success) NSLog(@"Could not open document at %@", self.document.fileURL.path);
            else NSLog(@"Opened document at %@", self.document.fileURL.path);
        }];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Create the UIManagedDocument
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"MoodSpaces"];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)setDocument:(UIManagedDocument *)document
{
    if (_document != document) {
        _document = document;
        [self useDocument];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSError *error;
    [self.document.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error saving document: %@", error);
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.document closeWithCompletionHandler:^(BOOL success) {
        if (!success) NSLog(@"Could not close document %@", self.document.fileURL.path);
    }];
}

@end
