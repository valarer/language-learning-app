//
//  EVMotionHelper.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/24/14.
//
//

#import "EVMotionHelper.h"
#import <CoreMotion/CoreMotion.h>

@implementation EVMotionHelper

+ (void)parallaxMotionForView:(UIView *)view movementOffset:(CGSize)offset
{
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]
                                                           initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-offset.width);
    horizontalMotionEffect.maximumRelativeValue = @(offset.width);
    
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc]
                                                         initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-offset.height);
    verticalMotionEffect.maximumRelativeValue = @(offset.height);
    
    UIMotionEffectGroup *backgroundGroup = [UIMotionEffectGroup new];
    backgroundGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [view addMotionEffect:backgroundGroup];
}

@end
