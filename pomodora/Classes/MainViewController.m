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
	pomodoroTimerView,
	pauseButton, 
	timerButton,
	stopButton,
	todayCompletedTxtBox,
	overallCompletedTxtBox;

#pragma mark Application lifecycle
- (void)loadView
{
	PomodoroTimerView * aPomodoroTimerView = [[PomodoroTimerView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] 
																		   delegate:self];
	self.view = aPomodoroTimerView; 
	self.pomodoroTimerView = aPomodoroTimerView;
	[aPomodoroTimerView release];
}

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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)dealloc {
    [managedObjectContext release];
	[pauseButton release];
	[timerButton release];
	[stopButton release];
	[user release];
	[timer release];
    [super dealloc];
}

#pragma mark Delegate PomodoroTimerViewDelegate

- (void)showInfo:(id)sender {  	  
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)startTimer {
	[self.user startPomodoro];
	[self.pomodoroTimerView updateTimerInfo];
	timer = [NSTimer scheduledTimerWithTimeInterval:1
											 target:self.pomodoroTimerView 
										   selector:@selector(updateTimerInfo) 
										   userInfo:nil
											repeats:YES];
}

- (void)stopTimer {
	[user stopPomodoro];
}

- (void) resetTimer{
	[self.pomodoroTimerView updateTimerInfo];
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:1
											 target:self.pomodoroTimerView 
										   selector:@selector(updateTimerInfo) 
										   userInfo:nil
											repeats:YES];
}


- (void)pauseResumeTimer:(id)sender {
	NSString * title = [sender titleForState:UIControlStateNormal];
	
	if ([title isEqualToString:@"Pause"]) {
		[user pausePomodoro];			
		[pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
		[self resetTimer];
	}else if ([title isEqualToString:@"Resume"]) {
		[user resumePomodoro];			
		[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
		[self resetTimer];
	}
	
}

- (void)finishTimer {
	[user finishPomodoro];
	[self startResting];
	[self updateStatsInfo];
}

- (void)startResting {
	[user startResting];
	[self resetTimer];	
	[pauseButton setHidden:YES]; 
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	
	[stopButton setHidden:YES];
}

- (void)finishResting {
	[user finishResting];
	[pomodoroTimerView resetTimerInfo];
	[timer invalidate];
}

- (int)timerValue {
	int tValue = [user timerValue];
	if (tValue > 0) {
		return tValue;
	}else {
		if ([user isRunningPomodoro]) {
			[self finishTimer];
		}else if ([user isPausedPomodoro]) {
			[self stopTimer];
		}else{
			[self finishResting];
		}
	}
	return 0;
}

#pragma mark Delegate FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)setWeeklyGoal:(int)goal{
	user.currentWeekGoal = (NSNumber *)[NSNumber numberWithInt:goal];
}

- (int)getWeeklyGoal {
	return [[user currentWeekGoal] intValue];
}

#pragma mark Private Methods

- (void) updateStatsInfo {
	[self.todayCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user todayCompleted]]];
	[self.overallCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user overallCompleted]]];
}


@end
