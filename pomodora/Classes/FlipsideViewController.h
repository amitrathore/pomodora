//
//  FlipsideViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController  < UITextFieldDelegate > {
	id <FlipsideViewControllerDelegate> delegate;
	
	IBOutlet UITextField *weekGoalTxtBox;
}


@property (nonatomic, retain) UITextField *weekGoalTxtBox;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
- (void)setWeeklyGoal:(int)goal;
- (int)getWeeklyGoal;
@end

