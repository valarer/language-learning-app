//
//  NSManagedObject+EVHelpers.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (EVHelpers)

+ (instancetype)entity;

+ (NSString *)name;

@end
