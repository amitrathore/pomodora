//
//  GoalsListTableViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "GoalAddViewController.h"
#import <CoreData/CoreData.h>

@class Goal;
@class GoalTableViewCell;

@interface GoalsListTableViewController : UITableViewController <GoalAddDelegate,NSFetchedResultsControllerDelegate> {
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext * managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController * fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext * managedObjectContext;

- (void)add:(id)sender;
- (void)showGoal:(Goal *)Goal animated:(BOOL)animated;
- (void)configureCell:(GoalTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
