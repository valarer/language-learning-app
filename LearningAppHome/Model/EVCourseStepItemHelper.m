//
//  EVCourseStepItemHelper.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import "EVCourseStepItemHelper.h"

@implementation EVCourseStepItemHelper

- (void)fetchItemsForCourseWithId:(int)identifier {
    NSString *stringPath = [NSString stringWithFormat:URL_ITEMS_FOR_GOAL, identifier];
    
    __weak __typeof__(self) weakSelf = self;
    [[RKObjectManager sharedManager] getObjectsAtPath:stringPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  __strong __typeof__(weakSelf) strongSelf = weakSelf;
                                                  if ([strongSelf.delegate respondsToSelector:@selector(didFetchObject:forEntity:)])
                                                  {
                                                      [strongSelf.delegate didFetchObjects:mappingResult.array forEntity:[CourseStepItem name]];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  NSLog(@"ERROR: Failed to load Items");
                                                  
                                                  __strong __typeof__(weakSelf) strongSelf = weakSelf;
                                                  
                                                  if ([strongSelf.delegate respondsToSelector:@selector(didFetchFailForEntity:error:)])
                                                  {
                                                      [strongSelf.delegate didFetchFailForEntity:[CourseStepItem name] error:error];
                                                  }
                                              }];
}

@end
