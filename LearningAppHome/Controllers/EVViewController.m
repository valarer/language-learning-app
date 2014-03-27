//
//  EVViewController.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "EVViewController.h"
#import "EVAnimatable.h"

@interface EVViewController ()

@end

@implementation EVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Nav bar theme
    self.navigationController.navigationBar.barTintColor = COLOR_FROM_HEX(0xff8a00);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: FONT_TYPE(@"Light", 20)
                                                                    };

    EVModelController *modelController = [EVModelController sharedModelController];
    CourseStep *courseStep = [[modelController studyingCourseSteps] firstObject];
    CourseStepProgress *progress = [modelController progressForCourseStep:courseStep andUser:[modelController currentUser]];
    
    _latestCourseView = [[EVCourseView alloc] initWithOrigin:CGPointMake(0, 64)];
    [self.view addSubview:_latestCourseView];
    [_latestCourseView configureWithProgress:progress];
    
    self.navigationController.navigationBar.translucent = YES;
    
    for (UIView *view in self.view.subviews) {
        if ([view conformsToProtocol:@protocol(EVAnimatable)]) {
            [(id<EVAnimatable>)view animate];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
