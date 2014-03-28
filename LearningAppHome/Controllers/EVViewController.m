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

@interface EVViewController ()
{
    EVCourseStepHelper *_courseHelper;
    EVCourseStepItemHelper *_courseItemHelper;
    NSArray *_items;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation EVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self applyAppearance];

    [self initializeViews];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)initializeViews
{
    _latestCourseView = [[EVCourseView alloc] initWithOrigin:CGPointMake(0, 0)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                               self.view.bounds.size.width, self.view.bounds.size.height)
                                              style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 70;
    _tableView.scrollEnabled = NO;
    [_scrollView addSubview:_tableView];
    
    [_tableView registerClass:[EVCourseStepItemCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)applyAppearance
{
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

- (void)loadData
{
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
    
    // Fetch Japanese course step 1
    [_courseHelper fetchCourseStepWithId:566921];
    [_courseItemHelper fetchItemsForCourseWithId:566921];

    // Fetch English course
//    [_courseHelper fetchCourseStepWithId:470265];
//    [_courseItemHelper fetchItemsForCourseWithId:470265];

    // Fetch Simplified Chinese course
//    [_courseHelper fetchCourseStepWithId:695684];
//    [_courseItemHelper fetchItemsForCourseWithId:695684];

}

#pragma mark ModelHelper delegate

- (void)didFetchObject:(id)object forEntity:(NSString *)entity
{
    if ([entity isEqualToString:[CourseStep name]]) {
        CourseStep *courseStep = (CourseStep *)object;
        [_latestCourseView configureWithCourseStep:courseStep];
    }
    [self finishedNetworkOperation];
}

- (void)didFetchObjects:(NSArray *)objects forEntity:(NSString *)entity
{
    if ([entity isEqualToString:[CourseStepItem name]]) {
        _items = objects;
        CGFloat contentHeight = _tableView.rowHeight * [_items count] + _latestCourseView.bounds.size.height;
        _tableView.frame = (CGRect){ _tableView.frame.origin, CGSizeMake(_tableView.bounds.size.width, contentHeight) };
        _scrollView.contentSize = CGSizeMake(_tableView.bounds.size.width, contentHeight);
        [_tableView reloadData];
    }
    [self finishedNetworkOperation];
}

- (void)didFetchFailForEntity:(NSString *)entity error:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:[NSString stringWithFormat:@"Couldn't fetch objects for Entity: %@", entity]
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

#pragma mark - UITableView

#pragma mark Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EVCourseStepItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CourseStepItem *item = _items[indexPath.row];
    [cell configureWithModel:item];
    
    return cell;
}

#pragma mark Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _latestCourseView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _latestCourseView.bounds.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
