//
//  MoodSelection.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MoodSelection : NSManagedObject

@property (nonatomic, retain) NSNumber * r;
@property (nonatomic, retain) NSNumber * theta;

@end
