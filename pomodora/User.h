//
//  User.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/1/11.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {

	//instance variables
	NSString *name;
	int currentWeekGoal;
	NSDictionary *userStats;
	int state;
}	

@property (retain) NSString *name;
@property int currentWeekGoal;
@property int state;
@property (retain) NSDictionary *userStats;

//method declaration
- (BOOL)finishPomodoro;
- (BOOL)pausePomodoro;
- (BOOL)resumePomodoro;
- (BOOL)stopPomodoro;
- (BOOL)startPomodoro;

- (BOOL)isRunningPomodoro;
- (BOOL)isPausedPomodoro;

@end
