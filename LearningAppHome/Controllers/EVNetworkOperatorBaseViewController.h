//
//  EVNetworkOperatorBaseViewController.h
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface EVNetworkOperatorBaseViewController : UIViewController

@property (strong, nonatomic) MBProgressHUD *loadingIndicator;
@property (nonatomic) short networkOperationsCounter;

- (void)finishedNetworkOperation;

@end
