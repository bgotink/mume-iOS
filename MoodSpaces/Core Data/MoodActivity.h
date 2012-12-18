//
//  MoodActivity.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodEntry;

@interface MoodActivity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *in;
@end

@interface MoodActivity (CoreDataGeneratedAccessors)

- (void)addInObject:(MoodEntry *)value;
- (void)removeInObject:(MoodEntry *)value;
- (void)addIn:(NSSet *)values;
- (void)removeIn:(NSSet *)values;

@end
