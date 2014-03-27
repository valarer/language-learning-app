//
//  EVCourseView.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/23/14.
//
//

#import "EVCourseView.h"
#import "UIImage+ImageEffects.h"
#import "EVMotionHelper.h"

#define VIEW_HEIGHT 150.0f
#define PARALLAX_OFFSET CGSizeMake(20, 10)
#define LINE_WIDTH 14.0f
#define LINE_HORIZONTAL_END_POINT 160.0f

@interface EVCourseView ()

@property (strong, nonatomic) UILabel *courseStepName;
@property (strong, nonatomic) UILabel *courseStepDescription;
@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation EVCourseView

- (instancetype)initWithOrigin:(CGPoint)origin
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, VIEW_HEIGHT)];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    self.layer.masksToBounds = YES;
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-PARALLAX_OFFSET.width,
                                                                         -PARALLAX_OFFSET.height,
                                                                         self.bounds.size.width + PARALLAX_OFFSET.width * 2,
                                                                         self.bounds.size.height + PARALLAX_OFFSET.height * 2)];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_backgroundImageView];
    
    [EVMotionHelper parallaxMotionForView:_backgroundImageView movementOffset:PARALLAX_OFFSET];
    
    CGFloat margin = 10.0f;
    _courseStepName = [[UILabel alloc] initWithFrame:CGRectMake(margin, 10,
                                                                self.bounds.size.width - margin * 2, 20)];
    _courseStepName.numberOfLines = 0;
    _courseStepName.textColor = [UIColor whiteColor];
    _courseStepName.font = FONT_TYPE(@"Light", 18);
    [self addSubview:_courseStepName];
    
    _courseStepDescription = [[UILabel alloc] initWithFrame:CGRectMake(margin,
                                                                       _courseStepName.frame.origin.y + _courseStepName.frame.size.height,
                                                                       self.bounds.size.width - margin * 2,
                                                                       self.bounds.size.height - _courseStepName.frame.origin.y)];
    _courseStepDescription.numberOfLines = 0;
    _courseStepDescription.textColor = [UIColor whiteColor];
    _courseStepDescription.font = FONT_TYPE(@"Thin", 13);
    [self addSubview:_courseStepDescription];
}

- (void)configureWithCourseStep:(CourseStep *)courseStep
{
    _courseStepName.text = courseStep.title;
    _courseStepDescription.text = courseStep.descriptionText;
    _backgroundImageView.image = [[UIImage imageNamed:@"takayama.jpg"] applyDarkEffect];
}

- (void)animate
{

}



@end
