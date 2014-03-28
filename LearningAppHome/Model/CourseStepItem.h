//
//  CourseStepItem.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseStep, CourseStepItemProgress;

@interface CourseStepItem : NSManagedObject

@property (nonatomic) int32_t identifier;
@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSString * partOfSpeech;
@property (nonatomic, retain) NSData * transliterations;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) CourseStep *courseStep;
@property (nonatomic, retain) NSSet *courseStepItemProgress;
@end

@interface CourseStepItem (CoreDataGeneratedAccessors)

- (void)addCourseStepItemProgressObject:(CourseStepItemProgress *)value;
- (void)removeCourseStepItemProgressObject:(CourseStepItemProgress *)value;
- (void)addCourseStepItemProgress:(NSSet *)values;
- (void)removeCourseStepItemProgress:(NSSet *)values;

@end
