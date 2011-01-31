//
//  MainViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "FlipsideViewController.h"
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;	    
	
	IBOutlet UILabel *timerInfo;
	IBOutlet UIButton *interruptButton;

}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UILabel *timerInfo;
@property (nonatomic, retain) UIButton *interruptButton;

- (IBAction)showInfo:(id)sender;
- (IBAction)startTimer;
- (IBAction)stopTimer;
- (IBAction)interuptTimer;

@end
