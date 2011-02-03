//
//  FlipsideViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize 
	delegate,
	weekGoalTxtBox;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	weekGoalTxtBox.delegate = self;	
	NSLog(@"Goal from user : %d", [self.delegate getWeeklyGoal]);
	weekGoalTxtBox.text = [NSString stringWithFormat:@"%d", [self.delegate getWeeklyGoal]];
}


- (IBAction)done:(id)sender {
	NSLog(@"Weekly Goal : %@", [weekGoalTxtBox text]);
	int goalValue = [[weekGoalTxtBox text] intValue];
	[self.delegate setWeeklyGoal:goalValue];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 2);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
