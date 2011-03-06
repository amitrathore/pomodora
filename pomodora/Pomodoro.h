//
//  Pomodoro.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;
@class Goal;

@interface Pomodoro :  NSManagedObject  
{
}


@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet* events;
@property (nonatomic, retain) User * user;
@property (nonatomic, retain) Goal * goal;
@property (nonatomic, retain) NSNumber * pausedTime;

+ (Pomodoro *)createPomodoro:(NSManagedObjectContext *)moc;
+ (Pomodoro *)findCurrentPomodoro:(NSManagedObjectContext *)moc;
+ (int)countCompletedPomodorosAfter:(NSDate *)date using:(NSManagedObjectContext *)moc;

@end

@interface Pomodoro (CoreDataGeneratedAccessors)
- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)value;
- (void)removeEvents:(NSSet *)value;

- (void)addEventWithType:(NSString *)eventType;
- (void)addEventWithType:(NSString *)eventType andDate:(NSDate *)date;

@end

