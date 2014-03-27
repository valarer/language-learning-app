//
//  EVCourseStepHomeView.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import <UIKit/UIKit.h>

@interface EVCourseStepHomeView : UIView

@property (strong, nonatomic) UILabel *courseStepName;
@property (strong, nonatomic) UILabel *completedPercentage;
@property (strong, nonatomic) UIImageView *backgroundImageView;

- (instancetype)initWithOrigin:(CGPoint)origin;

- (void)configureWithProgress:(CourseStepProgress *)progress;

@end
