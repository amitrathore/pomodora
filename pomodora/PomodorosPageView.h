//
//  PomodorosPageView.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/20/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PomodorosPageView : UIViewController <UIScrollViewDelegate> {
    
    NSManagedObjectContext *managedObjectContext;
    
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    
    BOOL pageControlBeingUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage;

@end
