//
//  EVViewController.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "EVViewController.h"
#import "EVAnimatable.h"
#import "EVCourseStepHelper.h"
#import "EVCourseStepItemHelper.h"
#import "EVCourseStepItemCell.h"
#import "MBProgressHUD.h"

@interface EVViewController () {
    EVCourseStepHelper *_courseHelper;
    EVCourseStepItemHelper *_courseItemHelper;
    NSArray *_items;
}

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) EVCourseView *latestCourseView;

@end

@implementation EVViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self applyAppearance];

    [self initializeViews];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    RELEASE_AND_NULLIFY(_latestCourseView);
    RELEASE_AND_NULLIFY(_tableView);
    RELEASE_AND_NULLIFY(_items);
    [super dealloc];
}

#pragma mark - Setup

- (void)initializeViews {
    float navigationHeight = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    _latestCourseView = [[EVCourseView alloc] initWithOrigin:CGPointMake(0, navigationHeight)];
    
    float titleOffset = 35.f;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationHeight + titleOffset,
                                                               self.view.bounds.size.width, self.view.bounds.size.height - navigationHeight - titleOffset)
                                              style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 70;
    _tableView.contentInset = UIEdgeInsetsMake(_latestCourseView.bounds.size.height - titleOffset, 0, 0, 0);
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[EVCourseStepItemCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:_latestCourseView];
    [self.view addSubview:_tableView];
}

- (void)applyAppearance {
    // Nav bar theme
    self.navigationController.navigationBar.barTintColor = COLOR_FROM_HEX(0xff8a00);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: FONT_TYPE(@"Light", 20)
                                                                    };
    
    self.navigationController.navigationBar.translucent = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - Data

- (void)loadData {
    if (!_courseHelper) {
        _courseHelper = [EVCourseStepHelper new];
    }
    _courseHelper.delegate = self;
    
    if (!_courseItemHelper) {
        _courseItemHelper = [EVCourseStepItemHelper new];
    }
    _courseItemHelper.delegate = self;
    
    [self.loadingIndicator show:YES];
    
    self.networkOperationsCounter = 2;
    
    // Japanese course step 1, English, Simplified Chinese
    int courseId[3] = {566921, 470265, 695684};
    [_courseHelper fetchCourseStepWithId:courseId[0]];
    [_courseItemHelper fetchItemsForCourseWithId:courseId[0]];
}

#pragma mark ModelHelper delegate

- (void)didFetchObject:(id)object forEntity:(NSString *)entity {
    if ([entity isEqualToString:[CourseStep name]]) {
        CourseStep *courseStep = (CourseStep *)object;
        [_latestCourseView configureWithCourseStep:courseStep];
    }
    [self finishedNetworkOperation];
}

- (void)didFetchObjects:(NSArray *)objects forEntity:(NSString *)entity {
    if ([entity isEqualToString:[CourseStepItem name]]) {
        _items = [objects retain];
        [_tableView reloadData];
    }
    [self finishedNetworkOperation];
}

- (void)didFetchFailForEntity:(NSString *)entity error:(NSError *)error {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:[NSString stringWithFormat:@"Couldn't fetch objects for Entity: %@", entity]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] autorelease];
    [alert show];
}

#pragma mark - UITableView

#pragma mark Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EVCourseStepItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CourseStepItem *item = [_items objectAtIndex:indexPath.row];
    [cell configureWithModel:item];
    
    return cell;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
