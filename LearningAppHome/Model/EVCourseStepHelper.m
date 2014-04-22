//
//  EVCourseStepHelper.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import "EVCourseStepHelper.h"

@implementation EVCourseStepHelper

- (void)fetchCourseStepWithId:(int)identifier {
    NSString *stringPath = [NSString stringWithFormat:URL_SINGLE_GOAL, identifier];
    
    __weak typeof(self) weakSelf = self;
    [[RKObjectManager sharedManager] getObjectsAtPath:stringPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  __strong __typeof__(weakSelf) strongSelf = weakSelf;
                                                  if ([strongSelf.delegate respondsToSelector:@selector(didFetchObject:forEntity:)]) {
                                                      [strongSelf.delegate didFetchObject:[mappingResult.array firstObject] forEntity:[CourseStep name]];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  NSLog(@"ERROR: Failed to load Goal");
                                                  
                                                  __strong typeof(weakSelf) strongSelf = weakSelf;
                                                  
                                                  if ([strongSelf.delegate respondsToSelector:@selector(didFetchFailForEntity:error:)]) {
                                                      [strongSelf.delegate didFetchFailForEntity:[CourseStep name] error:error];
                                                  }
                                              }];
}

@end
