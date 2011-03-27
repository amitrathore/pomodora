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
@synthesize fetchedResultsController;
@synthesize goals;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    
    self.goals = fetchedResultsController.fetchedObjects;
   
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [goals count] ; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [goals count], scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = [goals count];
    pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= [goals count])
        return;
    
    // replace the placeholder if necessary
    PomodoroViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[PomodoroViewController alloc] initWithGoal:[fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]]];
        
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
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlBeingUsed){
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (IBAction)changePage {
    int page = pageControl.currentPage;
 
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlBeingUsed = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Goal" 
                                       inManagedObjectContext:managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(completed == %@)", [NSNumber numberWithBool:NO]];
        [fetchRequest setPredicate:predicate];
        [predicate release];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Goals"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}    


/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"controllerWillChangeContent");
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			NSLog(@"NSFetchedResultsChangeInsert");
			break;
			
		case NSFetchedResultsChangeDelete:
			NSLog(@"NSFetchedResultsChangeDelete");
			break;
			
		case NSFetchedResultsChangeUpdate:
			NSLog(@"NSFetchedResultsChangeUpdate");
			break;
			
		case NSFetchedResultsChangeMove:
			NSLog(@"NSFetchedResultsChangeMove");
            break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"controllerDidChangeContent");
}

- (void)dealloc {
    [goals release];
    [fetchedResultsController release];
    [viewControllers release];
    [scrollView release];
    [pageControl release];
    [super dealloc];
}

@end