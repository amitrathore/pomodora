#import <UIKit/UIKit.h>

#import "FlipsideViewController.h"

#define NUMBER_OF_BLADES 9.0

static inline double radians(double degrees) { return degrees * M_PI / 180; }

CGRect RectForWaterWithLevel(float level);

@protocol PomodoroTimerViewDelegate <NSObject>
- (void)showInfo:(id)sender;
@end

@interface PomodoroTimerView : UIView {	
	id <PomodoroTimerViewDelegate> delegate;	

    // Display Items
    UIImageView     *waterView;
    UIImageView     *selectedVegetableIcon;
    UILabel         *volumeLabel;
    
    // Buttons
    UIButton        *carrotButton;
    UIButton        *radishButton;
    UIButton        *onionButton;
    UIButton        *sproutButton;
    
    UIView          *vegetableSpinner;
}

- (id)initWithFrame:(CGRect)frame delegate:(id)aDelegate;
@end

