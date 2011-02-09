//
//  Pomodoro.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Pomodoro :  NSManagedObject  
{
}


@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet* events;
@property (nonatomic, retain) User * user;

@end


@interface Pomodoro (CoreDataGeneratedAccessors)
- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)value;
- (void)removeEvents:(NSSet *)value;

+ (Pomodoro *) createPomodoro:(NSManagedObjectContext *)managedObjectContext;
+ (Pomodoro *) findOrCreateCurrentPomodoro:(NSManagedObjectContext *)managedObjectContext;

@end

