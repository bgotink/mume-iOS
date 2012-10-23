//
//  MoodSpotsViewController.h
//  MoodSpots
//
//  Created by Bram Gotink on 19/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelDrawer.h"

@interface MoodSpotsViewController : UIViewController

@property (strong, nonatomic) IBOutlet WheelDrawer *wheelImage;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPickerView *actionSelector;

- (IBAction)handleWheelTap:(UIGestureRecognizer *) sender;

@end
