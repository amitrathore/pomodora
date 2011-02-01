//
//  MainViewController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "MainViewController.h"

int timerValue = 25 * 60;
int interuptTimerValue = 45;

int STOPPED = 0;
int STARTED = 1;
int INTERRUPTED =2;

int status = 0 ;  


NSTimer *timer;
NSTimer *interuptTimer;

@implementation MainViewController

@synthesize 
	managedObjectContext, 
	interruptButton, 
	timerButton,
	stopButton;



 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[interruptButton setHidden:YES]; 
	[stopButton setHidden:YES]; 
    [super viewDidLoad];
}


 // Implement viewWillAppear: to do additional setup before the view is presented. You might, for example, fetch objects from the managed object context if necessary.
- (void)viewWillAppear:(BOOL)animated {
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

- (void)updateTimer {
	NSLog(@"%s" , "Updating ..");
    if (timerValue > 0) {
        timerValue--;
		int minutes = (timerValue % 3600) / 60;
        int seconds = (timerValue %3600) % 60;
		
		[timerButton setTitle:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds] forState:UIControlStateNormal];
	}
} 

- (void)updateInteruptTimer {
	NSLog(@"%s" , "Interruoting ..");
    if (interuptTimerValue > 0) {
        interuptTimerValue--;
		[timerButton setTitle:[NSString stringWithFormat:@"00:%02d", interuptTimerValue] forState:UIControlStateNormal];

  	}else{
		status = STOPPED;
		timerValue = 25 * 60;
		interuptTimerValue = 45;
		[interuptTimer invalidate];
	}
}

- (IBAction)startTimer {
	
	NSLog(@"%s" ,"Starting ...");
	
	[interruptButton setHidden:NO]; 
	[stopButton setHidden:NO]; 
	
	status = STARTED;
	
	interuptTimerValue = 45;
		
	timer = [NSTimer scheduledTimerWithTimeInterval:1 
													 target:self 
												   selector:@selector(updateTimer) 
												   userInfo:nil
												   repeats:YES];
	 
}

- (IBAction)stopTimer {
	
	[interruptButton setHidden:YES]; 
	[stopButton setHidden:YES]; 
	
	if (status == STARTED) {
		[timer invalidate];
	}else if (status == INTERRUPTED) {
		[interuptTimer invalidate];
	}
	
	status = STOPPED;
	timerValue = 25 * 60;
}



- (IBAction)interuptTimer {
	
	if (status == STARTED) {
		status = INTERRUPTED;
		
		interuptTimer	= [NSTimer scheduledTimerWithTimeInterval:1 
														 target:self 
													   selector:@selector(updateInteruptTimer) 
													   userInfo:nil
														repeats:YES];
		
		[timer invalidate];
		[interruptButton setTitle:@"Resume" forState:UIControlStateNormal];
		
	}
	else {
		[interuptTimer invalidate];
		[self startTimer];
		[interruptButton setTitle:@"Interrupt" forState:UIControlStateNormal];
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
    [super dealloc];
}


@end
