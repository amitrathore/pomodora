//
//  PomodorosPageView.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/20/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "PomodorosPageViewController.h"
#import "PomodoroViewController.h"

@interface PomodorosPageViewController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
@end

@implementation PomodorosPageViewController

@synthesize scrollView ,pageControl , managedObjectContext, viewControllers;

- (void)awakeFromNib{
    NSLog(@"Awake from NIB");
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    NSLog(@"View did load!!");
//    
//    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor],[UIColor grayColor], nil];
//    for (int i = 0; i < colors.count; i++) {
//        CGRect frame;
//        frame.origin.x = self.scrollView.frame.size.width * i;
//        frame.origin.y = 0;
//        frame.size = self.scrollView.frame.size;
//        
//        UIView *subview = [[UIView alloc] initWithFrame:frame];
//        subview.backgroundColor = [colors objectAtIndex:i];
//        [self.scrollView addSubview:subview];
//        
//        [subview release];
//    }
//    
//    self.pageControl.numberOfPages = [colors count];
//    
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View did load!!");
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 3; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page
{
    
    // replace the placeholder if necessary
    PomodoroViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[PomodoroViewController alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
//        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
//        controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
//        controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}




- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];	
    pageControlBeingUsed = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
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