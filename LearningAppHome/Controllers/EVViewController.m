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
    [super dealloc];
}

#pragma mark - Setup

- (void)initializeViews {
    _latestCourseView = [[EVCourseView alloc] initWithOrigin:CGPointMake(0, 0)];
    
    float navigationHeight = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationHeight,
                                                               self.view.bounds.size.width, self.view.bounds.size.height - navigationHeight)
                                              style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 70;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[EVCourseStepItemCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView setSectionHeaderHeight:_latestCourseView.bounds.size.height];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _latestCourseView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Code for making the section header appear/disappear
    CGFloat height;
    if (scrollView.contentOffset.y > 150) {
        height = 0;
        if (height != _latestCourseView.bounds.size.height) {
            [UIView animateWithDuration:0.7 animations:^{
                [_tableView beginUpdates];
                [_tableView setSectionHeaderHeight:height];
                [_tableView endUpdates];
            }];
        }
    }
    else {
        height = [EVCourseView defaultHeight];
        // Do not use UIView animation block here because there is a strange bug
        if (height != _latestCourseView.bounds.size.height) {
            [_tableView beginUpdates];
            [_tableView setSectionHeaderHeight:height];
            [_tableView endUpdates];
        }
    }
}

@end
