//
//  pomodoraAppDelegate.h
//  pomodora
//
//  Created by Siva Jagadeesan on 1/30/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PomodoroTimerView;
@class GoalsListTableViewController;
@class PomodorosPageViewController;

@interface pomodoraAppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *window;
    
    PomodorosPageViewController * pomodorosPageController;
	UITabBarController *tabBarController;	
    GoalsListTableViewController * goalsListController;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PomodorosPageViewController *pomodorosPageController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet GoalsListTableViewController * goalsListController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end

