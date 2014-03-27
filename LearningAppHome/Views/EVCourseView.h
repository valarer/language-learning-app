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

- (instancetype)initWithOrigin:(CGPoint)origin;

- (void)configureWithCourseStep:(CourseStep *)courseStep;

@end
