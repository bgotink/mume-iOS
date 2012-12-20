//
//  MoodSpot.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodEntry;

@interface MoodSpot : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *in;
@end

@interface MoodSpot (CoreDataGeneratedAccessors)

- (void)addInObject:(MoodEntry *)value;
- (void)removeInObject:(MoodEntry *)value;
- (void)addIn:(NSSet *)values;
- (void)removeIn:(NSSet *)values;

@end
