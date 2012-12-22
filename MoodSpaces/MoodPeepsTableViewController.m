//
//  MoodPeepsTableViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPeepsTableViewController.h"
#import <AddressBook/AddressBook.h>
#import "UnmanagedMoodPerson.h"

@interface MoodPeepsTableViewController ()

@end

@implementation MoodPeepsTableViewController

@synthesize contacts = _contacts;
@synthesize moodEntryDataSource = _moodEntryDataSource;
@synthesize moodEntryDelegate = _moodEntryDelegate;

static NSString *RECORD_ID = @"RECORD_ID";
static NSString *RECORD_FIRST_NAME = @"RECORD_FIRST_NAME";
static NSString *RECORD_LAST_NAME = @"RECORD_LAST_NAME";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupContacts];
}

- (void)setContacts:(NSDictionary *)contacts
{
    if (_contacts != contacts) {
        _contacts = contacts;
        [self.tableView reloadData];
    }
}

- (void)setupContacts
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    MoodPeepsTableViewController * __weak weakSelf = self;
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            // There are 26 letters in the alphabet, let's start with that :)
            NSMutableDictionary *contactsDictionary = [[NSMutableDictionary alloc] initWithCapacity:26];
            CFArrayRef contacts = ABAddressBookCopyArrayOfAllPeopleInSource(addressBook, ABAddressBookCopyDefaultSource(addressBook));
            for(CFIndex index = 0; index < CFArrayGetCount(contacts); index++) {
                ABRecordRef record = CFArrayGetValueAtIndex(contacts, index);
                ABRecordID recordId = ABRecordGetRecordID(record);
                NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(record, kABPersonFirstNameProperty));
                NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(record, kABPersonLastNameProperty));
                UnmanagedMoodPerson *contact = [[UnmanagedMoodPerson alloc] init];
                contact.firstName = firstName;
                contact.lastName = lastName;
                contact.recordId = recordId;
                NSString *section = [[lastName substringToIndex:1] uppercaseString];
                if (![contactsDictionary objectForKey:section]) {
                    [contactsDictionary setObject:[[NSMutableArray alloc] initWithObjects:contact, nil] forKey:section];
                } else {
                    [[contactsDictionary objectForKey:section] addObject:contact];
                }
            }
            weakSelf.contacts = contactsDictionary;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Could not access contacts. Please re-enable contact access in Settings."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            });
        }
    });
}

- (NSDictionary *)contacts
{
    if (!_contacts) {
        _contacts = [[NSDictionary alloc] initWithObjectsAndKeys:nil];
    }
    return _contacts;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contacts.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[self.contacts objectForKey:[[self.contacts.allKeys sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section]]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.contacts.allKeys sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDENTIFIER = @"MoodPeepsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    UnmanagedMoodPerson *contact = [self getContactAtIndexPath:indexPath];
    cell.textLabel.text = contact.description;
    if ([self isContactChecked:contact]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (BOOL)isContactChecked:(UnmanagedMoodPerson *)contact
{
    NSArray *array = self.moodEntryDataSource.moodPeeps.allObjects;
    for(int i = 0; i < self.moodEntryDataSource.moodPeeps.count; i++) {
        UnmanagedMoodPerson *person = [array objectAtIndex:i];
        if(person.recordId == contact.recordId) {
            return YES;
        }
    }
    return NO;
}

- (UnmanagedMoodPerson *)getContactAtIndexPath:(NSIndexPath *)indexPath
{
    return [[((NSArray *)[self.contacts objectForKey:[[self.contacts.allKeys sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section]]) sortedArrayUsingComparator:^(UnmanagedMoodPerson *p1, UnmanagedMoodPerson *p2) {
        NSComparisonResult result = [p1.lastName compare:p2.lastName options:NSCaseInsensitiveSearch];
        if (result == NSOrderedSame) {
            return [p1.firstName compare:p2.firstName options:NSCaseInsensitiveSearch];
        }
        return result;
    }] objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnmanagedMoodPerson *contact = [self getContactAtIndexPath:indexPath];
    NSLog(@"moodEntryDelegate = %@", self.moodEntryDelegate);
    [self.moodEntryDelegate toggleContact:contact];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
