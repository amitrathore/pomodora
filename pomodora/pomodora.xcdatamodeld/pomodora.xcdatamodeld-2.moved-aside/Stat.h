//
//  Stat.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Stat :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * noAborted;
@property (nonatomic, retain) NSNumber * noCompleted;
@property (nonatomic, retain) NSNumber * noOfInterruptions;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * noStarted;
@property (nonatomic, retain) NSNumber * noOfResumes;
@property (nonatomic, retain) User * user;

- (void)incrementCompleted;
- (void)incrementAborted;
- (void)incrementInterruptions;
- (void)incrementStarts;
- (void)incrementResumes;

- (NSNumber * )increment:(NSNumber *)number;

+ (Stat *)findOrCreateStat:(NSManagedObjectContext *)moc;

@end



