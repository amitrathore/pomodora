//
//  GoalDetailViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "GoalDetailViewController.h"

#import "Goal.h"

@implementation GoalDetailViewController

@synthesize goal;

@synthesize tableHeaderView;
@synthesize nameTextField;


#pragma mark -
#pragma mark View controller

- (void)viewDidLoad {
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Create and set the table header view.
    if (tableHeaderView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GoalDetailHeaderView" owner:self options:nil];
        self.tableView.tableHeaderView = tableHeaderView;
        self.tableView.allowsSelectionDuringEditing = YES;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
	
	self.navigationItem.title = goal.name;
    nameTextField.text = goal.name;    
    	
	// Update recipe type 
    [self.tableView reloadData]; 
}


- (void)viewDidUnload {
    self.tableHeaderView = nil;
	self.nameTextField = nil;
	[super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
	nameTextField.enabled = editing;
	[self.navigationItem setHidesBackButton:editing animated:YES];
	
	/*
	 If editing is finished, save the managed object context.
	 */
	if (!editing) {
		NSManagedObjectContext *context = goal.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
	if (textField == nameTextField) {
		goal.name = nameTextField.text;
		self.navigationItem.title = goal.name;
	}
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
    [tableHeaderView release];
    [nameTextField release];
    [goal release];
    [super dealloc];
}


@end