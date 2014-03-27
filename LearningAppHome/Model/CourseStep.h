//
//  CourseStep.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, CourseStepItem, CourseStepProgress;

@interface CourseStep : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t numberOfItems;
@property (nonatomic) int16_t numberOfSentences;
@property (nonatomic, retain) Course *course;
@property (nonatomic, retain) NSSet *courseStepProgresses;
@property (nonatomic, retain) NSSet *items;
@end

@interface CourseStep (CoreDataGeneratedAccessors)

- (void)addCourseStepProgressesObject:(CourseStepProgress *)value;
- (void)removeCourseStepProgressesObject:(CourseStepProgress *)value;
- (void)addCourseStepProgresses:(NSSet *)values;
- (void)removeCourseStepProgresses:(NSSet *)values;

- (void)addItemsObject:(CourseStepItem *)value;
- (void)removeItemsObject:(CourseStepItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
