//
//  Event.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Pomodoro;

@interface Event :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * eventType;
@property (nonatomic, retain) Pomodoro * pomodoro;

@end

