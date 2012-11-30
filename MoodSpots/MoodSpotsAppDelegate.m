//
//  MoodSpotsAppDelegate.m
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotsAppDelegate.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Person+Create.h"
#import "Activity.h"
#import "Activity+Create.h"
#import "Location.h"
#import "Location+Create.h"
#import "MoodSelection.h"
#import "MoodSelection+Create.h"
#import "MoodEntry.h"
#import "MoodEntry+Create.h"
#import "Log.h"

@implementation MoodSpotsAppDelegate
@synthesize document = _document;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:@"MyDocument1.md"];
    
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) [self documentIsReady];
            if (!success) NSLog(@"couldn’t open document at %@", url);
        }]; } else {
            [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating
              completionHandler:^(BOOL success) {
                  if (success) [self documentIsReady];
                  if (!success) NSLog(@"couldn’t create document at %@", url);
              }]; }
    // can’t do anything with the document yet (do it in documentIsReady).
    
    
    // Override point for customization after application launch.
    return YES;
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
    [self.document closeWithCompletionHandler:^(BOOL success) {
        if (!success){
            MSLog(@"failed to close document %@", self.document.localizedName);
        } else{
            MSLog(@"document %@ is closed", self.document.localizedName);
        }
    }];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)documentIsReady{
    if (self.document.documentState == UIDocumentStateNormal){
        NSManagedObjectContext *context = self.document.managedObjectContext;
        //Do something with it...
        MSLog(@"It succeeded to make the context.");
        NSManagedObject *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];

        
        MSLog(@"Person is made");
        [newPerson setValue:@"Geert" forKey:@"name"];
        MSLog(@"value %@",[newPerson valueForKey:@"name"]);
        
        Person *michiel = [Person createPerson:@"Michiel" inManagedObjectContext:context];
        MSLog(@"name: %@", michiel.name);
        
        Activity *mume = [Activity createActivity:@"mume12" inManagedObjectContext:context];
        MSLog(@"activity: %@", mume.activity);
        
        Location *kot = [Location createLocation:@"kot" inManagedObjectContext:context];
        MSLog(@"location: %@", kot.location);
        
        
        //Waarom gebruik ik hier [NSNumber numberWithDouble:0.12] ??
        // Omdat een NSManagedObject een double als een NSNumber opslaat en je dus een double moet wrappen met NSNumber.
        MoodSelection *selection = [MoodSelection createMoodSelection:[NSNumber numberWithDouble:0.12] withTheta:[NSNumber numberWithDouble:1.23] inManagedObjectContext:context];
        MSLog(@"moodselection: (%@, %@)", selection.r, selection.theta);
        
        NSSet *closePeople = [NSSet setWithObjects:michiel, newPerson, nil];

        NSSet *selectedMoods = [NSSet setWithObject:selection];
        
        MoodEntry *entry = [MoodEntry createMoodEntry:closePeople at:kot withSelected:selectedMoods doing:mume inManagedObjectContext:context];
        MSLog(@"MoodEntry: ");
        for(Person *closePerson in entry.closePersons){
            NSLog(@"closePeople contains: %@", closePerson.name);
        }
        MSLog(@"location: %@", entry.fromWhere.location);
        for(MoodSelection *selectedMoods in entry.selectedMoods){
            NSLog(@"selectedMoods contains: (%@, %@)", selectedMoods.r, selectedMoods.theta);
        }
        MSLog(@"activity: %@", entry.whichActivity.activity);
        
        //Object can be deleted by calling
        //[self.document.managedObjectContext deleteObject:entry];
        
        //Querying
        
        NSArray *persons = [Person queryPerson:@"Michiel" inManagedObjectContext:context];
        if(persons == nil){
            MSLog(@"an error occured while querying");
        } else{
            MSLog(@"Persons found in database: ");
            for(Person *result in persons){
                MSLog(@"name: %@", result.name);
            }
            MSLog(@"___");
        }
        
        Person *bram = [Person createPerson:@"Bram" inManagedObjectContext:context];
        MSLog(@"name: %@", bram.name);
    }
}

- (void) saveDocument{
    [self.document saveToURL:self.document.fileURL
                   forSaveOperation:UIDocumentSaveForOverwriting
                  completionHandler:^(BOOL success) {
                      if (!success)
                          MSLog(@"failed to save document %@", self.document.localizedName);
                  }];
}

@end
