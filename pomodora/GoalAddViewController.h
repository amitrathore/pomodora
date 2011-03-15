//
//  GoalAddViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoalAddDelegate;
@class Goal;

@interface GoalAddViewController : UIViewController <UITextFieldDelegate> {
@private
    Goal *goal;
    UITextField *nameTextField;
    id <GoalAddDelegate> delegate;
}

@property(nonatomic, retain) Goal *goal;
@property(nonatomic, retain) IBOutlet UITextField *nameTextField;
@property(nonatomic, assign) id <GoalAddDelegate> delegate;

- (void)save;
- (void)cancel;

@end


@protocol GoalAddDelegate <NSObject>
- (void)goalAddViewController:(GoalAddViewController *)goalAddViewController didAddGoal:(Goal *)goal;
@end

