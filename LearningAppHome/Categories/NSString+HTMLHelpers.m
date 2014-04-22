//
//  NSString+HTMLHelpers.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "NSString+HTMLHelpers.h"

@implementation NSString (HTMLHelpers)

- (NSString *)stripTags {
    return [self stringByReplacingOccurrencesOfString:@"<.*?>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
}

@end
