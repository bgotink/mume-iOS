//
//  MoodSelection.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodEntry;

@interface MoodSelection : NSManagedObject

@property (nonatomic, retain) NSNumber * r;
@property (nonatomic, retain) NSNumber * theta;
@property (nonatomic, retain) MoodEntry *in;

@end
