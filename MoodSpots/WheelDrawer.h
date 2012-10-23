//
//  WheelDrawer.h
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelDrawer : UIView

@property (nonatomic) CGSize size;
@property int radius;

-(CGColorRef)colorFromHex:(NSString*)hex;

-(void)pointClicked:(CGPoint)point;

@end
