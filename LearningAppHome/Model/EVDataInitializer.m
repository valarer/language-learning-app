//
//  EVDataInitializer.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "EVDataInitializer.h"

@implementation EVDataInitializer

+ (instancetype)sharedDataInitializer {
    static EVDataInitializer *_sharedDataInitializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataInitializer = [EVDataInitializer new];
    });
    
    return _sharedDataInitializer;
}

// Do not leave commented code around. This is what git is for.
- (void)initiliazeData
{
//    EVModelManager *modelController = [EVModelManager sharedModelController];
//    
//    [modelController clearEntityData:@[@"User", @"Course", @"CourseStep", @"CourseStepProgress", @"CourseStepItem"]];
//    
//    User *user = [User entity];
//    user.identifier = [[NSUUID UUID] UUIDString];
//    user.name = @"Eric";
//    user.totalCompletedItems = 400;
//    user.totalStartedItems = 500;
//    
//    Course *japaneseCourse = [Course entity];
//    japaneseCourse.identifier = [[NSUUID UUID] UUIDString];
//    japaneseCourse.name = @"Japanese Core 2000";
//    japaneseCourse.imageName = @"tokyo_train.jpg";
//    
//    CourseStep *japaneseCourseStep1 = [CourseStep entity];
//    japaneseCourseStep1.identifier = [[NSUUID UUID] UUIDString];
//    japaneseCourseStep1.title = @"Japanese Core 2000: Step 1";
//    japaneseCourseStep1.numberOfItems = 125;
//    japaneseCourseStep1.numberOfSentences = 120;
//    japaneseCourseStep1.imageName = @"takayama.jpg";
//    japaneseCourseStep1.course = japaneseCourse;
//    
//    CourseStepProgress *japaneseCourseStep1Progress = [CourseStepProgress entity];
//    japaneseCourseStep1Progress.completedItems = 63;
//    japaneseCourseStep1Progress.startedItems = 30;
//    japaneseCourseStep1Progress.user = user;
//    japaneseCourseStep1Progress.courseStep = japaneseCourseStep1;
//    
//    [modelController saveContext];
}

@end
