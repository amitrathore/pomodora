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

@property (nonatomic, retain) NSDate * statDate;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSManagedObject * user;

@end



