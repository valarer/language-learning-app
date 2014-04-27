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
    
    [[RKObjectManager sharedManager] getObjectsAtPath:stringPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if ([self.delegate respondsToSelector:@selector(didFetchObject:forEntity:)]) {
                                                      [self.delegate didFetchObject:[mappingResult.array firstObject] forEntity:[CourseStep name]];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  NSLog(@"ERROR: Failed to load Goal");
                                                  
                                                  if ([self.delegate respondsToSelector:@selector(didFetchFailForEntity:error:)]) {
                                                      [self.delegate didFetchFailForEntity:[CourseStep name] error:error];
                                                  }
                                              }];
}

@end
