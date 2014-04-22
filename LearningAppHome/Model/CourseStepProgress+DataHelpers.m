//
//  CourseStepProgress+DataHelpers.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "CourseStepProgress+DataHelpers.h"

@implementation CourseStepProgress (DataHelpers)

- (NSString *)completedPercentageString {
    return [NSString stringWithFormat:@"%.0f%%", self.completedItems * 100.0f / self.courseStep.numberOfItems];
}

@end
