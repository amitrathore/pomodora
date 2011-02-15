//
//  CalendarHelper.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "CalendarHelper.h"


@implementation CalendarHelper

+ (NSDate *)startOfToday{
	NSCalendar * gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents * components = [gregorian components:
									 (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)
												 fromDate:[NSDate date]];
	
	NSDate * today = [gregorian dateFromComponents:components];
	
	[gregorian release];
	
	return today;
}

+ (NSDate *)beforeSeconds:(int)seconds{
	NSDate * now = [[NSDate alloc] init];
	NSTimeInterval secondsInterval = seconds;
	
	return [now initWithTimeIntervalSinceNow:-secondsInterval];
}

@end
