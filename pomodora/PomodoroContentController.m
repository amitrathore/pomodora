//
//  PomodoroContentController.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/19/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "PomodoroContentController.h"
#import "PomodoroViewController.h"

@implementation PomodoroContentController

@synthesize scrollView, pageControl, viewControllers;
@synthesize managedObjectContext;

- (void)viewDidLoad {
    NSLog(@"Loading Pomodoro Content Scroll View");
    [super viewDidLoad];
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];    
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.scrollView addSubview:subview];
        [subview release];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
    
      NSLog(@"Loaded Pomodoro Content Scroll View");
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
}

- (void)dealloc {
    [scrollView release];
    [super dealloc];
}

@end