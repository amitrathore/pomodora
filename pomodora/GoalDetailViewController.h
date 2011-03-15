//
//  GoalDetailViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

@class Goal;

@interface GoalDetailViewController : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate> {
@private
    Goal *goal;
    
    UIView *tableHeaderView; 
    UITextField *nameTextField;
}

@property (nonatomic, retain) Goal *goal;

@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;

@end
