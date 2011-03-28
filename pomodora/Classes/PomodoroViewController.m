//
//  MainViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "PomodoroViewController.h"

NSTimer *timer;

@implementation PomodoroViewController

@synthesize 
    managedObjectContext, 
    user,
    pauseButton, 
    timerButton,
    stopButton,
    todayCompletedTxtBox,
    overallCompletedTxtBox,
    goal,
    pomodoroTimerView,
    goalName;

- (id)initWithGoal:(Goal *)_goal andManagedObjectContext:(NSManagedObjectContext*) moc{
//    PomodoroTimerView * aPomodoroTimerView = [[PomodoroTimerView alloc] 
//                                                initWithFrame:[[UIScreen mainScreen] applicationFrame] 
//                                                     delegate:self];
//    self.goal = _goal;
//    [aPomodoroTimerView setGoalName:[self.goal name]];
//	self.view = aPomodoroTimerView; 
//	self.pomodoroTimerView = aPomodoroTimerView;
//	[aPomodoroTimerView release];
//    return self;
    
    if(!self.managedObjectContext){
        self.managedObjectContext = moc;
    }
    
    self.goal = _goal;
    
    if (!self.user) {	
		self.user = [User findOrCreateUser:self.managedObjectContext];
	}
    
    NSLog(@"Goal Name : %@", [self.goal name]);
    
    self.goalName.text = [self.goal name];
	
	[self updateStatsInfo];
    
    return self;
}

#pragma mark Application lifecycle

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)dealloc {
    [managedObjectContext release];
	[user release];
	[pomodoroTimerView release];
	[timer release];
    [super dealloc];
}

#pragma mark Delegate PomodoroTimerViewDelegate

//- (void)showInfo:(id)sender {  	  
//    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
//    controller.delegate = self;
//    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	[self presentModalViewController:controller animated:YES];
//    [controller release];
//}
//
//- (void)startTimer {
//	[user startPomodoro];
//	[pomodoroTimerView putInRunningMode];
//	[pomodoroTimerView updateTimerInfo];
//	timer = [NSTimer scheduledTimerWithTimeInterval:1
//											 target:self.pomodoroTimerView 
//										   selector:@selector(updateTimerInfo) 
//										   userInfo:nil
//											repeats:YES];
//}
//
//- (void)stopTimer {
//	[user stopPomodoro];
//	[pomodoroTimerView putInNotRunningMode];
//}
//
//- (void) resetTimer{
//	[self.pomodoroTimerView updateTimerInfo];
//	[timer invalidate];
//	timer = [NSTimer scheduledTimerWithTimeInterval:1
//											 target:self.pomodoroTimerView 
//										   selector:@selector(updateTimerInfo) 
//										   userInfo:nil
//											repeats:YES];
//}
//
//
//- (void)pauseResumeTimer:(id)sender {
//	NSString * title = [sender titleForState:UIControlStateNormal];
//	
//	if ([title isEqualToString:@"Pause"]) {
//		[user pausePomodoro];			
//		[pomodoroTimerView putInInterruptedMode];
//		[self resetTimer];
//	}else if ([title isEqualToString:@"Resume"]) {
//		[user resumePomodoro];			
//		[pomodoroTimerView putInRunningMode];
//		[self resetTimer];
//	}
//	
//}
//
//- (void)finishTimer {
//	[user finishPomodoro];
//	[self startResting];
//	[self updateStatsInfo];
//}
//
//- (void)startResting {
//	[user startResting];
//	[pomodoroTimerView putInRestMode];
//	[self resetTimer];	
//}
//
//- (void)finishResting {
//	[user finishResting];
//	[pomodoroTimerView putInNotRunningMode];
//	[timer invalidate];
//}
//
//- (int)timerValue {
//	int tValue = [user timerValue];
//	if (tValue > 0) {
//		return tValue;
//	}else {
//		if ([user isRunningPomodoro]) {
//			[self finishTimer];
//		}else if ([user isPausedPomodoro]) {
//			[self stopTimer];
//		}else{
//			[self finishResting];
//		}
//	}
//	return 0;
//}

#pragma mark Delegate FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)setWeeklyGoal:(int)_goal{
	user.currentWeekGoal = (NSNumber *)[NSNumber numberWithInt:_goal];
}

- (int)getWeeklyGoal {
	return [[user currentWeekGoal] intValue];
}

#pragma mark Private Methods

- (void) updateStatsInfo {
	[self.todayCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user todayCompleted]]];
	[self.overallCompletedTxtBox setText:[NSString stringWithFormat:@"%d",[user overallCompleted]]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[pauseButton setHidden:YES]; 
	[stopButton setHidden:YES]; 
    
    goalName.text = [self.goal name];
	
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
		}else if ([user isPausedPomodoro]) {
			[self stopTimer];
		}else{
			[self finishResting];
		}
        
	}
    
}

- (IBAction)startTimer {
    NSLog(@"User : %@", self.user);
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
	[user stopPomodoro];
}

- (void) resetTimer{
	[self updateTimerInfo];
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:1
											 target:self 
										   selector:@selector(updateTimerInfo) 
										   userInfo:nil
											repeats:YES];
}


- (IBAction)pauseResumeTimer:(id)sender {
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
	[self resetTimerInfo];	
}

//- (void)setWeeklyGoal:(int)goal{
//	user.currentWeekGoal = (NSNumber *)[NSNumber numberWithInt:goal];
//}
//
//- (int)getWeeklyGoal {
//	return [[user currentWeekGoal] intValue];
//}



@end
