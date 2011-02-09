//
//  Stat.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/4/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Stat :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * noCompleted;
@property (nonatomic, retain) NSNumber * noStarted;
@property (nonatomic, retain) NSManagedObject * user;

@end



