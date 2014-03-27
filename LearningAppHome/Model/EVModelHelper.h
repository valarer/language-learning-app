//
//  EVModelHelper.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/26/14.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "EVModelHelperDelegate.h"

@interface EVModelHelper : NSObject

@property (weak, nonatomic) id<EVModelHelperDelegate> delegate;

@end
