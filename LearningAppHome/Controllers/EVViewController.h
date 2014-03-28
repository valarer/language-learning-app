//
//  EVViewController.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import <UIKit/UIKit.h>
#import "EVCourseView.h"
#import "EVModelHelperDelegate.h"
#import "EVNetworkOperatorBaseViewController.h"

@interface EVViewController : EVNetworkOperatorBaseViewController <UITableViewDataSource, UITableViewDelegate, EVModelHelperDelegate>

@property (strong, nonatomic) EVCourseView *latestCourseView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
