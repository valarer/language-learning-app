//
//  EVModelController.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>
#import "Course.h"
#import "CourseStep.h"
#import "CourseStepItem.h"
#import "CourseStepProgress.h"
#import "CourseStepProgress+DataHelpers.h"
#import "CourseStepItem+DataHelpers.h"
#import "User.h"
#import "NSManagedObject+EVHelpers.h"

@class EVRestKitManager;

@interface EVModelManager : NSObject

@property (retain, nonatomic) EVRestKitManager *restKitManager;

+ (EVModelManager *)sharedModelController;

- (id)entityForName:(NSString *)name;
- (void)clearEntityData:(NSArray *)entities;

@end
