//
//  GoalTableViewCell.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/14/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"

@interface GoalTableViewCell : UITableViewCell {
    Goal *goal;
    
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *overviewLabel;
    UILabel *prepTimeLabel;
}

@property (nonatomic, retain) Goal *goal;

@property (nonatomic, retain) UILabel *nameLabel;

@end
