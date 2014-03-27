//
//  EVModelHelperDelegate.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import <Foundation/Foundation.h>

@protocol EVModelHelperDelegate <NSObject>

@optional
- (void)didFetchObjects:(NSArray *)objects forEntity:(NSString *)entity;
- (void)didFetchObject:(id)object forEntity:(NSString *)entity;
- (void)didFetchFailForEntity:(NSString *)entity error:(NSError *)error;

@end
