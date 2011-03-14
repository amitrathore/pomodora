//
//  GoalsListTableViewController.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GoalsListTableViewController : UITableViewController {
    
    NSMutableArray * goals;
    
}

@property (retain, nonatomic) NSMutableArray * goals;

- (void) addGoal;

@end
