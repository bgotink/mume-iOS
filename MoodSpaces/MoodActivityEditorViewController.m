//
//  MoodActivityEditorViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivityEditorViewController.h"
#import "MoodSpacesAppDelegate.h"

@interface MoodActivityEditorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) NSManagedObjectContext *context;

@end

@implementation MoodActivityEditorViewController

@synthesize context = _context;
@synthesize moodActivity = _moodActivity;
@synthesize nameText = _nameText;

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.moodActivity) {
        self.moodActivity = [MoodActivity createMoodActivityWithName:@"" inManagedObjectContext:self.context];
    } else {
        self.nameText.text = self.moodActivity.name;
    }
}

- (NSManagedObjectContext *)context
{
    if (!_context) {
        MoodSpacesAppDelegate *appDelegate = (MoodSpacesAppDelegate *)[[UIApplication sharedApplication] delegate];
        _context = appDelegate.document.managedObjectContext;
    }
    return _context;
}

- (IBAction)done:(id)sender
{
    if ([self.nameText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a name for this MoodActivity" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        self.moodActivity.name = self.nameText.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end