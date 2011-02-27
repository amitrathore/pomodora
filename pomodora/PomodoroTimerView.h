#import <UIKit/UIKit.h>

#define NUMBER_OF_BLADES 9.0

static inline double radians(double degrees) { return degrees * M_PI / 180; }

@protocol PomodoroTimerViewDelegate <NSObject>
- (void)showInfo:(id)sender;
- (void)startTimer;	
- (void)stopTimer;
- (void)pauseResumeTimer:(id)sender;
- (void)finishTimer;
- (void)startResting;
- (void)finishResting;
- (int)timerValue;
@end

@interface PomodoroTimerView : UIView {	
	id <PomodoroTimerViewDelegate> delegate;	

    // Display Items
    UIImageView     *waterView;
    UIImageView     *selectedVegetableIcon;
    UILabel         *timerLabel;
    
    // Buttons
    UIButton        *carrotButton;
    UIButton        *radishButton;
    UIButton        *onionButton;
    UIButton        *sproutButton;
    
    UIView          *vegetableSpinner;
}

- (id)initWithFrame:(CGRect)frame delegate:(id)aDelegate;
- (void)updateTimerInfo;
- (void)putInNotRunningMode;
- (void)putInRunningMode;
- (void)putInInterruptedMode;
- (void)putInRestMode;

@end

