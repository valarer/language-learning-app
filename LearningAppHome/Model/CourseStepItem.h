//
//  CourseStepItem.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CourseStep;

@interface CourseStepItem : NSManagedObject

@property (nonatomic, retain) NSString * wordKanji;
@property (nonatomic, retain) NSString * meaning;
@property (nonatomic) int16_t typeOfWord;
@property (nonatomic, retain) NSString * wordHiragana;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) CourseStep *courseStep;

@end
