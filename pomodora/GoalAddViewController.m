
//
//  GoalAddViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "GoalAddViewController.h"
#import "Goal.h"

@implementation GoalAddViewController

@synthesize goal;
@synthesize nameTextField;
@synthesize weekGoalPicker;
@synthesize delegate;


- (void)viewDidLoad {
    
    // Configure the navigation bar
    self.navigationItem.title = @"Add Goal";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    [cancelButtonItem release];
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    [saveButtonItem release];
	
    [weekGoalPicker selectRow:9 inComponent:0 animated:YES];
	[nameTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == nameTextField) {
		[nameTextField resignFirstResponder];
//		[self save];
	}
	return YES;
}

-(IBAction)backgroundTouched:(id)sender
{
    [nameTextField resignFirstResponder];
}

- (void)viewDidUnload {
	self.nameTextField = nil;
	[super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside-down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)save {
    
    goal.name = nameTextField.text;
    
	NSError *error = nil;
	if (![goal.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
	[self.delegate goalAddViewController:self didAddGoal:goal];
}


- (void)cancel {
	
	[goal.managedObjectContext deleteObject:goal];
    
	NSError *error = nil;
	if (![goal.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    [self.delegate goalAddViewController:self didAddGoal:nil];
}

#pragma mark -
#pragma mark Implementing UIPickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", row + 1];
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    goal.weekGoal = [NSNumber numberWithInt:row - 1];
}

- (void)dealloc {
    [goal release];    
    [nameTextField release];    
    [super dealloc];
}

@end
