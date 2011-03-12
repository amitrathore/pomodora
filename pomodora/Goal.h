//
//  Goal.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/5/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Pomodoro;
@class User;

@interface Goal :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) User * user;
@property (nonatomic, retain) NSSet* pomodoros;

+ (NSArray *)findIncompletedGoals:(NSManagedObjectContext *)moc;

@end


@interface Goal (CoreDataGeneratedAccessors)
- (void)addPomodorosObject:(Pomodoro *)value;
- (void)removePomodorosObject:(Pomodoro *)value;
- (void)addPomodoros:(NSSet *)value;
- (void)removePomodoros:(NSSet *)value;

@end

