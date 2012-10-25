//
//  ActionPickerViewController.m
//  MoodSpots
//
//  Created by Bram Gotink on 25/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "StringArrayPickerView.h"

@interface StringArrayPickerView ()

@end

@implementation StringArrayPickerView

@synthesize values;

- (id)init
{
    if (self = [super init]) {
        [self setValues:@[@"oops",@"this",@"is",@"hardcoded"]];
        [super setDataSource:self];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setValues:@[@"this",@"is",@"hardcoded"]];
        [super setDataSource:self];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setValues:@[@"this",@"is",@"hardcoded"]];
        [super setDataSource:self];
    }
    return self;
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
        numberOfRowsInComponent:(NSInteger)component
{
    return [values count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return values[row];
}

@end
