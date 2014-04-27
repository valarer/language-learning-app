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
    
    [[RKObjectManager sharedManager] getObjectsAtPath:stringPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if ([self.delegate respondsToSelector:@selector(didFetchObject:forEntity:)])
                                                  {
                                                      [self.delegate didFetchObjects:mappingResult.array forEntity:[CourseStepItem name]];
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  
                                                  NSLog(@"ERROR: Failed to load Items");
                                                  
                                                  if ([self.delegate respondsToSelector:@selector(didFetchFailForEntity:error:)])
                                                  {
                                                      [self.delegate didFetchFailForEntity:[CourseStepItem name] error:error];
                                                  }
                                              }];
}

@end
