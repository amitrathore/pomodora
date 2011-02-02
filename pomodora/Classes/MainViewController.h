//
//  MainViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "FlipsideViewController.h"
#import "User.h"
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;	
    User *user;
	
	IBOutlet UILabel *timerInfo;
	IBOutlet UIButton *interruptButton;
	IBOutlet UIButton *timerButton;
	IBOutlet UIButton *stopButton;

}

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIButton *interruptButton;
@property (nonatomic, retain) UIButton *timerButton;
@property (nonatomic, retain) UIButton *stopButton;

- (IBAction)showInfo:(id)sender;
- (IBAction)startTimer;
- (IBAction)stopTimer;
- (IBAction)interuptTimer;

@end
