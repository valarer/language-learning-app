//
//  User.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseStepProgress;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t totalCompletedItems;
@property (nonatomic) int32_t totalStartedItems;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSSet *courseStepProgresses;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCourseStepProgressesObject:(CourseStepProgress *)value;
- (void)removeCourseStepProgressesObject:(CourseStepProgress *)value;
- (void)addCourseStepProgresses:(NSSet *)values;
- (void)removeCourseStepProgresses:(NSSet *)values;

@end
