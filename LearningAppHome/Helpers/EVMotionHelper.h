//
//  EVMotionHelper.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/24/14.
//
//

#import <Foundation/Foundation.h>

@interface EVMotionHelper : NSObject

+ (void)parallaxMotionForView:(UIView *)view movementOffset:(CGSize)offset;

@end
