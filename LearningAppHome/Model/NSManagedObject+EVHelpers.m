//
//  NSManagedObject+EVHelpers.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "NSManagedObject+EVHelpers.h"

@implementation NSManagedObject (EVHelpers)

+ (instancetype)entity
{
    return [[EVModelController sharedModelController] entityForName:NSStringFromClass([self class])];
}

@end
