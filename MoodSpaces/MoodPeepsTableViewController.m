//
//  MoodPeepsTableViewController.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPeepsTableViewController.h"


@interface MoodPeepsTableViewController ()

@end

@implementation MoodPeepsTableViewController

@synthesize contacts = _contacts;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupContacts];
}

- (void)setContacts:(NSArray *)contacts
{
    if (_contacts != contacts) {
        _contacts = contacts;
        
        NSLog(@"Address Book Item count = %d", contacts.count);
        
        [self.tableView reloadData];
    }
}

- (void)setupContacts
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSArray *contacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
            NSLog(@"Number of contacts = %u", [contacts count]);
        } else {
            // TODO: Handle error
        }
    });
    CFRelease(addressBook);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDENTIFIER = @"MoodPeepsTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    //ABA
    //cell.textLabel.text =
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
