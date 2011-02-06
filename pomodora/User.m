// 
//  User.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/4/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "User.h"

#import "Stat.h"

@implementation User 

@dynamic name;
@dynamic currentWeekGoal;
@dynamic stats;

@synthesize state;

- (BOOL)startPomodoro{
	[self setState:1];
	return YES;
}

- (BOOL)finishPomodoro{
	[self setState:0];
	return YES;
}

- (BOOL)pausePomodoro{
	[self setState:2];
	return YES;
}

- (BOOL)resumePomodoro{
	[self setState:1];
	return YES;
}

- (BOOL)stopPomodoro{
	[self setState:0];
	return YES;
}


- (BOOL)isRunningPomodoro{
	return [self state] == 1;
}

- (BOOL)isPausedPomodoro{
	return [self state] == 2;
}

@end
