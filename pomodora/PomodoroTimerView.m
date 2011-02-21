#import "PomodoroTimerView.h"

@interface PomodoroTimerView (private)

- (UILabel *)newTimerLabel;
- (void)setupVegetableButtons;
- (void)setupBlades;
- (UIImage *)imageForVeg:(id)sender;
- (float)spinnerAngleForVegetable:(id)sender;
- (void)setNeonVegVisible:(BOOL)visible;
- (void)showWateringIndicator;
- (void)assembleVegetableButton:(UIButton *)button;
- (UIImage *)selectedImageForVeg:(UIButton *)button;
- (CGRect)rectForWaterWithLevel:(float)level;

@end

@implementation PomodoroTimerView

/*  
 Called when a vegetable button is pressed.
 */
- (void)setSelectedVeg:(id)sender
{    
    [selectedVegetableIcon setAlpha:0.0];
    
    [UIView animateWithDuration:0.4
                     animations: ^{
                         float angle = [self spinnerAngleForVegetable:sender];
                         [vegetableSpinner setTransform:CGAffineTransformMakeRotation(angle)];
                     } 
                     completion:^(BOOL finished) {
                         [selectedVegetableIcon setAlpha:1.0];
                     }];
}

/*
 Create and setup all the buttons
 */
- (void)setupVegetableButtons
{
    carrotButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(vegetableSpinner.frame)/2.0 - 37, 0, 74, 74)];
    [self assembleVegetableButton:carrotButton];
    
    radishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(vegetableSpinner.frame)/2.0 - 37, 74, 74)];
    [self assembleVegetableButton:radishButton];
    
    onionButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(vegetableSpinner.frame)/2.0 - 37, CGRectGetHeight(vegetableSpinner.frame) - 74, 74, 74)];
    [self assembleVegetableButton:onionButton];
    
    sproutButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(vegetableSpinner.frame) - 74, CGRectGetHeight(vegetableSpinner.frame)/2.0 - 37, 74, 74)];
    [self assembleVegetableButton:sproutButton];
}

/*
 Factory to create a given button
 */
- (void)assembleVegetableButton:(UIButton *)button
{
    button.transform = CGAffineTransformMakeRotation(-[self spinnerAngleForVegetable:button]);
    [button setImage:[self imageForVeg:button] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setSelectedVeg:) forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    [vegetableSpinner addSubview:button];
}

/*
 Returns the unselected icon of a given vegetable
 */
- (UIImage *)selectedImageForVeg:(id)sender
{
    if (sender == carrotButton) {
        return [UIImage imageNamed:@"carrot.png"];
    } else if (sender == radishButton) {
        return [UIImage imageNamed:@"radish.png"];
    } else if (sender == onionButton) {
        return [UIImage imageNamed:@"onion.png"];
    } else if (sender == sproutButton) {
        return [UIImage imageNamed:@"sprout.png"];
    }
    return nil;
}

/*
 Returns the selected icon of a given vegetable 
 */
- (UIImage *)imageForVeg:(UIButton *)button
{
    if (button == carrotButton) {
        return [UIImage imageNamed:@"ucarrot.png"];
    } else if (button == radishButton) {
        return [UIImage imageNamed:@"uradish.png"];
    } else if (button == onionButton) {
        return [UIImage imageNamed:@"uonion.png"];
    } else if (button == sproutButton) {
        return [UIImage imageNamed:@"usprout.png"];
    }
    return nil;
}

/*
 Returns the angle for a given selected vegetable
 */
- (float)spinnerAngleForVegetable:(id)sender
{
    selectedVegetableIcon.image = [self selectedImageForVeg:sender];
    
    float angle = 0.0;
    if (sender == carrotButton) {
        angle = 0.0;
    } else if (sender == radishButton) {
        angle = 90.0;
    } else if (sender == onionButton) {
        angle = 180.0;
    } else if (sender == sproutButton) {
        angle = -90.0;
    }
    return radians(angle);
}

/*
 Create and setup the water label
 */
- (UILabel *)newTimerLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 135)];
    [label setText:@"Start"];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:50]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

#pragma mark Application LifeCycle

- (id)initWithFrame:(CGRect)frame  delegate:(id)aDelegate
{
    if ((self = [super initWithFrame:frame])){
        delegate = aDelegate;
		
        self.clipsToBounds = YES;
        
        vegetableSpinner = [[UIView alloc] initWithFrame:CGRectMake(28, 167, 259, 259)];
        [vegetableSpinner setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *timerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lcd.png"]];
        [self addSubview:timerBackground];
        [timerBackground release];
        
        timerLabel = [self newTimerLabel];
        [self addSubview:timerLabel];
        
        UIImageView *foreground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flat.png"]];
        [self addSubview:foreground];
        [foreground release];
        
        [self setupVegetableButtons];
        
        [self addSubview:vegetableSpinner];
        
        UIImageView *cover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WheelCover.png"]];
		[self addSubview:cover];
        [cover release];
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [infoButton setFrame:CGRectMake(280, 420, 40, 40)];
		NSLog(@"%@" , [[UIApplication sharedApplication] delegate]);
        [infoButton addTarget:delegate action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:infoButton];
        
        selectedVegetableIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(vegetableSpinner.frame) + (CGRectGetWidth(vegetableSpinner.frame)/2.0 - 37), CGRectGetMinY(vegetableSpinner.frame), 74, 74)];
        [selectedVegetableIcon setImage:[UIImage imageNamed:@"carrot.png"]];
        [self addSubview:selectedVegetableIcon];
        
        UIButton *startTimerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startTimerButton setImage:[UIImage imageNamed:@"drips.png"] forState:UIControlStateNormal];
        [startTimerButton setFrame:CGRectMake(CGRectGetWidth(frame)/2.0 - 85.0/2.0 - 2,CGRectGetHeight(frame)/2.0 - 85.0/2.0 + 70,85,85)];
        [startTimerButton addTarget:delegate action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startTimerButton];
    }
    return self;
}

- (void)dealloc 
{    
    [waterView release];
    [selectedVegetableIcon release];
    [timerLabel release];
    [carrotButton release];
    [radishButton release];
    [onionButton release];
    [sproutButton release];
    [vegetableSpinner release];
    
    [super dealloc];
}

#pragma mark Public Methods


- (void)updateTimerInfo {
	int timerValue = [delegate timerValue];
	
	if (timerValue > 0) {
		int minutes = (timerValue % 3600) / 60;
		int seconds = (timerValue % 3600) % 60;
		
		[timerLabel setText:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds]];	
	}	
}

- (void)resetTimerInfo {
	[timerLabel setText:@"Start"];
}

@end

