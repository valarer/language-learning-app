//
//  CourseStepItemProgress.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseStepItem, User;

@interface CourseStepItemProgress : NSManagedObject

@property (nonatomic) BOOL completed;
@property (nonatomic) int32_t errors;
@property (nonatomic, retain) CourseStepItem *courseStepItem;
@property (nonatomic, retain) User *user;

@end
