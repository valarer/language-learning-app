//
//  CourseStepItem+DataHelpers.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "CourseStepItem+DataHelpers.h"

@implementation CourseStepItem (DataHelpers)

- (NSString *)hiraganaWord
{
    return [self transliterationForKey:@"Hira"];
}

- (NSString *)transliterationForKey:(NSString *)key
{
    NSString *word = @"";
    if (self.transliterations) {
        NSArray *transliterations = [NSKeyedUnarchiver unarchiveObjectWithData:self.transliterations];
        for (NSObject *transliterationItem in transliterations) {
            if ([[transliterationItem valueForKey:@"type"] isEqualToString:key]) {
                return [transliterationItem valueForKey:@"text"];
            }
        }
    }
    return word;
}

@end
