//
//  CourseStepItem+DataHelpers.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "CourseStepItem.h"

@interface CourseStepItem (DataHelpers)

@property (retain, nonatomic, readonly) NSString *hiraganaWord;

- (NSString *)transliterationForKey:(NSString *)key;

@end
