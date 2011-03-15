//
//  GoalTableViewCell.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/14/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "GoalTableViewCell.h"

#pragma mark -
#pragma mark SubviewFrames category

@interface GoalTableViewCell (SubviewFrames)
- (CGRect)_nameLabelFrame;
@end


#pragma mark -
#pragma mark GoalTableViewCell implementation

@implementation GoalTableViewCell

@synthesize goal;
@synthesize nameLabel;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
	if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:nameLabel];
    }
    
    return self;
}


#pragma mark -
#pragma mark Laying out subviews

/*
 To save space, the prep time label disappears during editing.
 */
- (void)layoutSubviews {
    [super layoutSubviews];
	
    [nameLabel setFrame:[self _nameLabelFrame]];
}


#define IMAGE_SIZE          42.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define PREP_TIME_WIDTH     80.0

/*
 Return the frame of the various subviews -- these are dependent on the editing state of the cell.
 */

- (CGRect)_nameLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH, 16.0);
    }
}

#pragma mark -
#pragma mark Goal set accessor

- (void)setGoal:(Goal *)newGoal {
    if (newGoal != goal) {
        [Goal release];
        goal = [newGoal retain];
	}
	nameLabel.text = [NSString stringWithFormat:@"%@ - %@",goal.name, goal.weekGoal];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [goal release];
    [nameLabel release];
    [super dealloc];
}

@end
