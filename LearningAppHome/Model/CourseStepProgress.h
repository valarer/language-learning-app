//
//  CourseStepProgress.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/25/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseStep, User;

@interface CourseStepProgress : NSManagedObject

@property (nonatomic) int16_t completedItems;
@property (nonatomic) int16_t startedItems;
@property (nonatomic, retain) CourseStep *courseStep;
@property (nonatomic, retain) User *user;

@end
