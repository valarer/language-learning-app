//
//  NSString+HTMLHelpers.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "NSString+HTMLHelpers.h"

@implementation NSString (HTMLHelpers)


/**
 * Taken from http://stackoverflow.com/a/6171866
 * Changed it to a category
 */
- (NSString *)stripTags
{
    NSMutableString *resultingString = [NSMutableString stringWithCapacity:[self length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [resultingString appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return resultingString;
}

@end
