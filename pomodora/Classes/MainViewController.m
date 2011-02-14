//
//  MainViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "MainViewController.h"

NSTimer *timer;

@implementation MainViewController

@synthesize 
	managedObjectContext, 
	user,
	pauseButton, 
	timerButton,
	stopButton,
	todayCompletedTxtBox,
	overallCompletedTxtBox;


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[pauseButton setHidden:YES]; 
	[stopButton setHidden:YES]; 
	
    [super viewDidLoad];
}


 // Implement viewWillAppear: to do additional setup before the view is presented. You might, for example, fetch objects from the managed object context if necessary.
- (void)viewWillAppear:(BOOL)animated {
	if (!self.user) {	
		self.user = [User findOrCreateUser:self.managedObjectContext];
	}
	
	[self updateStatsInfo];
    [super viewWillAppear:animated];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender {  
	  
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (void)resetTimerInfo {
	[timer invalidate];
	[pauseButton setHidden:YES]; 
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	
	[stopButton setHidden:YES]; 
	
	[timerButton setTitle:@"Start" forState:UIControlStateNormal];
	[timerButton setEnabled:YES];
}

- (void)startTimerInfo {	
	[pauseButton setHidden:NO]; 
	[stopButton setHidden:NO]; 
    [timerButton setEnabled:NO];
}

- (void) updateStatsInfo {
	[self.todayCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user todayCompleted]]];
	[self.overallCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user overallCompleted]]];
}

- (void)updateTimerInfo {
	int timerValue = [user timerValue];
	NSLog(@"Updating with TimerValue : %d" , timerValue);
	
	if (timerValue > 0) {
		int minutes = (timerValue % 3600) / 60;
		int seconds = (timerValue % 3600) % 60;
	
		[timerButton setTitle:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds] forState:UIControlStateNormal];	
	}else {
		if ([user isRunningPomodoro]) {
			[self finishTimer];
		}else {
			[self stopTimer];
		}

	}

}

- (IBAction)startTimer {
	[self.user startPomodoro];
	
	[self startTimerInfo];		
	[self updateTimerInfo];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:1
											 target:self 
										   selector:@selector(updateTimerInfo) 
										   userInfo:nil
											repeats:YES];
}

- (IBAction)stopTimer {
	[self resetTimerInfo];	
	[user stopPomodoro];
}


- (IBAction)pauseTimer {
	
}

- (void)finishTimer {
	[user finishPomodoro];
	[self resetTimerInfo];	
	[self updateStatsInfo];
}

- (void)setWeeklyGoal:(int)goal{
	user.currentWeekGoal = (NSNumber *)[NSNumber numberWithInt:goal];
}

- (int)getWeeklyGoal {
	return [[user currentWeekGoal] intValue];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)dealloc {
    [managedObjectContext release];
	[pauseButton release];
	[timerButton release];
	[stopButton release];
	[user release];
	[timer release];
    [super dealloc];
}


@end
