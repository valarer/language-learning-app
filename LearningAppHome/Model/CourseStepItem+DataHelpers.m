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
    NSString *word = @"";
    NSArray *transliterations = [NSKeyedUnarchiver unarchiveObjectWithData:self.transliterations];
    for (NSObject *transliterationItem in transliterations) {
        if ([[transliterationItem valueForKey:@"type"] isEqualToString:@"Hira"]) {
            return [transliterationItem valueForKey:@"text"];
        }
    }
    return word;
}

@end
