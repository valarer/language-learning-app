//
//  EVDataInitializer.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <Foundation/Foundation.h>

@interface EVDataInitializer : NSObject

+ (EVDataInitializer *)sharedDataInitializer;

- (void)initiliazeData;

@end
