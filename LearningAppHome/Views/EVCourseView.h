//
//  EVCourseView.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <UIKit/UIKit.h>
#import "EVAnimatable.h"

@interface EVCourseView : UIView <EVAnimatable>

@property (strong, nonatomic) UILabel *courseStepName;
@property (strong, nonatomic) UILabel *completedPercentage;
@property (strong, nonatomic) UIImageView *backgroundImageView;

- (instancetype)initWithOrigin:(CGPoint)origin;

- (void)configureWithProgress:(CourseStepProgress *)progress;

@end
