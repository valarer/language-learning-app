//
//  EVCourseStepHelper.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import "EVCourseStepHelper.h"

@implementation EVCourseStepHelper

- (void)fetchCourseStepWithId:(int)identifier
{
    NSString *stringPath = [NSString stringWithFormat:URL_SINGLE_GOAL, identifier];
    
    __weak __typeof__(self) weakSelf = self;
    [[RKObjectManager sharedManager] getObjectsAtPath:stringPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                              // I am not familiar with this pattern of casting self to a strong reference before calling a method on it. Why are you doing this exactly?
                                                  __strong __typeof__(weakSelf) strongSelf = weakSelf;
                                                  if ([strongSelf delegate] && [[strongSelf delegate] respondsToSelector:@selector(didFetchObject:forEntity:)])
                                                  {
                                                      [strongSelf.delegate didFetchObject:[mappingResult.array firstObject] forEntity:[CourseStep name]];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  NSLog(@"ERROR: Failed to load Goal");
                                                  
                                                  __strong __typeof__(weakSelf) strongSelf = weakSelf;
                                                  
                                                  if ([strongSelf.delegate respondsToSelector:@selector(didFetchFailForEntity:error:)])
                                                  {
                                                      [strongSelf.delegate didFetchFailForEntity:[CourseStep name] error:error];
                                                  }
                                              }];
}

@end
