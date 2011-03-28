//
//  MainViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "FlipsideViewController.h"
#import "User.h"
#import "PomodoroTimerView.h"
#import <CoreData/CoreData.h>


@interface PomodoroViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;	
    User * user;	
	PomodoroTimerView * pomodoroTimerView;
    Goal * goal;
	
	IBOutlet UITextField *todayCompletedTxtBox;
	IBOutlet UITextField *overallCompletedTxtBox;
  	IBOutlet UIButton *pauseButton;
	IBOutlet UIButton *timerButton;
	IBOutlet UIButton *stopButton;
    IBOutlet UILabel *goalName;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Goal *goal;
@property (nonatomic, retain) PomodoroTimerView *pomodoroTimerView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UITextField *todayCompletedTxtBox;
@property (nonatomic, retain) UITextField *overallCompletedTxtBox;
@property (nonatomic, retain) UIButton *pauseButton;
@property (nonatomic, retain) UIButton *timerButton;
@property (nonatomic, retain) UIButton *stopButton;
@property (nonatomic, retain) UILabel *goalName;

- (IBAction)startTimer;
- (IBAction)stopTimer;
- (IBAction)pauseResumeTimer:(id)sender;

- (void)finishTimer;
- (void)startResting;
- (void)finishResting;

- (void)startTimerInfo;
- (void)updateStatsInfo;
- (void)updateTimerInfo;

- (id)initWithGoal:(Goal *)goal andManagedObjectContext:(NSManagedObjectContext*) moc;

@end
