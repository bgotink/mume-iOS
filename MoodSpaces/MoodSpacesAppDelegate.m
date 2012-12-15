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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

- (void)documentIsReady{
    //if (self.document.documentState == UIDocumentStateNormal){
        //NSManagedObjectContext *context = self.document.managedObjectContext;
        //Do something with it...
        
        //The following test code creates some database entities.
        /*NSLog(@"It succeeded to make the context.");
        NSManagedObject *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];

        
        NSLog(@"Person is made");
        [newPerson setValue:@"Geert" forKey:@"name"];
        NSLog(@"value %@",[newPerson valueForKey:@"name"]);
		
        Person *michiel = [Person createPerson:@"Michiel" inManagedObjectContext:context];
        NSLog(@"name: %@", michiel.name);
        
        Activity *mume = [Activity createActivity:@"mume12" inManagedObjectContext:context];
        NSLog(@"activity: %@", mume.activity);
        
        Location *kot = [Location createLocation:@"kot" inManagedObjectContext:context];
        NSLog(@"location: %@", kot.location);
        
        
        //Waarom gebruik ik hier [NSNumber numberWithDouble:0.12] ??
        // Omdat een NSManagedObject een double als een NSNumber opslaat en je dus een double moet wrappen met NSNumber.
        MoodSelection *selection = [MoodSelection createMoodSelection:[NSNumber numberWithDouble:0.12] withTheta:[NSNumber numberWithDouble:1.23] inManagedObjectContext:context];
        NSLog(@"moodselection: (%@, %@)", selection.r, selection.theta);
        
        NSSet *closePeople = [NSSet setWithObjects:michiel, newPerson, nil];
        NSSet *selectedMoods = [NSSet setWithObject:selection];
        
        MoodEntry *entry = [MoodEntry createMoodEntry:closePeople at:kot withSelected:selectedMoods doing:mume inManagedObjectContext:context];
        NSLog(@"MoodEntry: ");
        for(Person *closePerson in entry.closePersons){
            NSLog(@"closePeople contains: %@", closePerson.name);
        }
        NSLog(@"location: %@", entry.fromWhere.location);
        for(MoodSelection *selectedMoods in entry.selectedMoods){
            NSLog(@"selectedMoods contains: (%@, %@)", selectedMoods.r, selectedMoods.theta);
        }
        NSLog(@"activity: %@", entry.whichActivity.activity);
        
        //Object can be deleted by calling
        //[self.document.managedObjectContext deleteObject:entry];
        
        //Querying
        
        NSArray *persons = [Person queryPerson:@"Michiel" inManagedObjectContext:context];
        if(persons == nil){
            NSLog(@"an error occured while querying");
        } else{
            NSLog(@"Persons found in database: ");
            for(Person *result in persons){
                NSLog(@"name: %@", result.name);
            }
            NSLog(@"___");
        }
        
        Person *bram = [Person createPerson:@"Bram" inManagedObjectContext:context];
        NSLog(@"name: %@", bram.name);*/
    //}
}

@end
