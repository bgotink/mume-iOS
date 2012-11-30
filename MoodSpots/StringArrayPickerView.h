//
//  ActionPickerViewController.h
//  MoodSpots
//
//  Created by Bram Gotink on 25/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringArrayPickerView : UIPickerView
            <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *values;
}

@property (strong,nonatomic) NSArray *values;

@end
