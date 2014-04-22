//
//  EVNetworkOperatorBaseViewController.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "EVNetworkOperatorBaseViewController.h"
#import "MBProgressHUD.h"

@interface EVNetworkOperatorBaseViewController ()

@end

@implementation EVNetworkOperatorBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureLoadingHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureLoadingHUD {
    if (!_loadingIndicator)
    {
        UIView *view = self.navigationController ? self.navigationController.view : self.view;
        _loadingIndicator = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:_loadingIndicator];
    }
}

#pragma mark - Public

- (void)finishedNetworkOperation {
    if (--_networkOperationsCounter == 0) {
        [_loadingIndicator hide:YES];
    }
}



@end
