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

@end



