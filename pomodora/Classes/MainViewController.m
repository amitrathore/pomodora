//
//  MainViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "MainViewController.h"

int timerValue = 25 * 60;
int pauseTimerValue = 45;

NSTimer *timer;
NSTimer *pauseTimer;

@implementation MainViewController

@synthesize 
	managedObjectContext, 
	user,
	pauseButton, 
	timerButton,
	stopButton;


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[pauseButton setHidden:YES]; 
	[stopButton setHidden:YES]; 
    [super viewDidLoad];
}


 // Implement viewWillAppear: to do additional setup before the view is presented. You might, for example, fetch objects from the managed object context if necessary.
- (void)viewWillAppear:(BOOL)animated {
	[self setUser:[[User alloc] init]];
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
	if ([user isPausedPomodoro]) {
		NSLog(@"%s" , "Invaliding PauseTimer ..");
		[pauseTimer invalidate];
		NSLog(@"%s" , "Invalided PauseTimer ..");
	}
	
	if ([user isRunningPomodoro]) {
		NSLog(@"%s" , "Invaliding Timer ..");
		[timer invalidate];
		NSLog(@"%s" , "Invalided Timer ..");
	}
	timerValue = 25 * 60;
	pauseTimerValue = 45;
	
	[pauseButton setHidden:YES]; 
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	
	[stopButton setHidden:YES]; 
	
	[timerButton setTitle:@"Start" forState:UIControlStateNormal];
	[timerButton setEnabled:YES];
}

- (void)startTimerInfo {
	pauseTimerValue = 45;	
	
	[pauseButton setHidden:NO]; 
	[stopButton setHidden:NO]; 
    [timerButton setEnabled:NO];
}

- (void)updateTimer {
	NSLog(@"%s" , "Updating ..");
    if (timerValue > 0) {
        timerValue--;
		int minutes = (timerValue % 3600) / 60;
        int seconds = (timerValue %3600) % 60;
		
		[timerButton setTitle:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds] forState:UIControlStateNormal];
	}else {
		[self resetTimerInfo];	
		[user finishPomodoro];
	}

} 

- (void)updatePauseTimer {
	NSLog(@"%s" , "Interrupting ..");
    if (pauseTimerValue > 0) {
        pauseTimerValue--;
		[timerButton setTitle:[NSString stringWithFormat:@"00:%02d", pauseTimerValue] forState:UIControlStateNormal];
  	}else{
		[self resetTimerInfo];
		[user stopPomodoro];
	}
}

- (IBAction)startTimer {
	NSLog(@"%s" ,"Starting ...");		
	[user startPomodoro];	
	[self startTimerInfo];		
	timer = [NSTimer scheduledTimerWithTimeInterval:1 
													 target:self 
												   selector:@selector(updateTimer) 
												   userInfo:nil
												   repeats:YES];
}

- (IBAction)stopTimer {
	[self resetTimerInfo];	
	[user stopPomodoro];
}



- (IBAction)pauseTimer {
	
	if ([user isRunningPomodoro]) {
		[user pausePomodoro];
		
		pauseTimer	= [NSTimer scheduledTimerWithTimeInterval:1 
														 target:self 
													   selector:@selector(updatePauseTimer) 
													   userInfo:nil
														repeats:YES];
		
		[timer invalidate];
		[pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
		
	}
	else {
		[pauseTimer invalidate];
		[self startTimer];
		[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	}
	
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
    [super dealloc];
}


@end
