//
//  MoodActivity+Util.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivity.h"

@interface MoodActivity (Util)

- (void)setVector:(double)vector forMood:(NSInteger)mood;
- (NSString *)vectorForMood:(NSInteger)mood;

@end
