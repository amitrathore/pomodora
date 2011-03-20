//
//  PomodorosPageView.h
//  pomodora
//
//  Created by Siva Jagadeesan on 3/20/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PomodorosPageView : UIViewController  {
    UIScrollView* scrollView;
    UIPageControl* pageControl;
    
    BOOL pageControlBeingUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

- (IBAction)changePage;

@end