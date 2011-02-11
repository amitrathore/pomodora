// 
//  Pomodoro.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Pomodoro.h"

#import "User.h"

@implementation Pomodoro 

@dynamic status;
@dynamic createdAt;
@dynamic desc;
@dynamic events;
@dynamic user;

+ (Pomodoro *)createPomodoro:(NSManagedObjectContext *)moc {
	Pomodoro * newPomodoro = (Pomodoro *)[NSEntityDescription
										  insertNewObjectForEntityForName:@"Pomodoro"
										  inManagedObjectContext:moc];
	
	
	return newPomodoro;
}

@end
