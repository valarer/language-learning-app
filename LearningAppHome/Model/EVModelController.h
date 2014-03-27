//
//  EVModelController.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Course.h"
#import "CourseStep.h"
#import "CourseStepItem.h"
#import "CourseStepProgress.h"
#import "CourseStepProgress+DataHelpers.h"
#import "User.h"
#import "NSManagedObject+EVHelpers.h"

@interface EVModelController : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (EVModelController *)sharedModelController;
- (id)entityForName:(NSString *)name;
- (void)saveContext;
- (void)clearEntityData:(NSArray *)entities;



- (User *)currentUser;
- (NSArray *)studyingCourseSteps;
- (CourseStepProgress *)progressForCourseStep:(CourseStep *)courseStep andUser:(User *)user;



@end
