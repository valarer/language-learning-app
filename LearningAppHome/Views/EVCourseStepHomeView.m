//
//  EVCourseStepHomeView.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "EVCourseStepHomeView.h"
#import "UIImage+ImageEffects.h"
#import "EVMotionHelper.h"

#define VIEW_HEIGHT 150.0f
#define PARALLAX_OFFSET CGSizeMake(20, 10)
#define LINE_WIDTH 14.0f
#define LINE_HORIZONTAL_END_POINT 160.0f

@interface EVCourseStepHomeView ()
{
    CAShapeLayer *_startedWordsShapeLayer, *_completedWordsShapeLayer;
    float _startedWordsStrokeEnd, _completedWordsStrokeEnd;
}

@property (strong, nonatomic) UIView *wordsProgressContainer;
@property (strong, nonatomic) UILabel *startedWordsLabel;
@property (strong, nonatomic) UILabel *completedWordsLabel;

@end

@implementation EVCourseStepHomeView

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
    _courseStepName = [[UILabel alloc] initWithFrame:CGRectMake(margin, 10, self.bounds.size.width - margin * 2, 20)];
    _courseStepName.numberOfLines = 0;
    _courseStepName.textColor = [UIColor whiteColor];
    _courseStepName.font = FONT_TYPE(@"Thin", 20);
    [self addSubview:_courseStepName];
    
    _completedPercentage = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - margin - 140, 50, 0, 0)];
    _completedPercentage.numberOfLines = 1;
    _completedPercentage.textColor = [UIColor whiteColor];
    _completedPercentage.font = FONT_TYPE(@"UltraLight", 70);
    _completedPercentage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_completedPercentage];
    
    // The CAShapeLayers creation with their paths
    
    _startedWordsShapeLayer = [CAShapeLayer layer];
    _startedWordsShapeLayer.lineWidth = LINE_WIDTH;
    _startedWordsShapeLayer.strokeEnd = 0.0f;
    _startedWordsShapeLayer.strokeColor = COLOR_FROM_HEX_AND_ALPHA(0x6ba300, 0.4f).CGColor;
    _startedWordsShapeLayer.fillColor = [UIColor clearColor].CGColor;
    // LTR Path
    UIBezierPath *startedWordsPath = [UIBezierPath bezierPath];
    CGFloat originY = self.bounds.size.height - 50 - (LINE_WIDTH / 2) * 3;
    CGPoint origin = CGPointMake(0, originY);
    CGPoint end = CGPointMake(LINE_HORIZONTAL_END_POINT, originY);
    [startedWordsPath moveToPoint:origin];
    [startedWordsPath addLineToPoint:end];
    _startedWordsShapeLayer.path = startedWordsPath.CGPath;
    [self.layer addSublayer:_startedWordsShapeLayer];
    
    _completedWordsShapeLayer = [CAShapeLayer layer];
    _completedWordsShapeLayer.lineWidth = LINE_WIDTH;
    _completedWordsShapeLayer.strokeEnd = 0.0f;
    _completedWordsShapeLayer.strokeColor = COLOR_FROM_HEX_AND_ALPHA(0xffa317, 0.4f).CGColor;
    _completedWordsShapeLayer.fillColor = [UIColor clearColor].CGColor;
    // Also a LTR path but below the previous one
    UIBezierPath *finishedWordsPath = [UIBezierPath bezierPath];
    originY = origin.y + LINE_WIDTH * 2;
    [finishedWordsPath moveToPoint:CGPointMake(0, originY)];
    [finishedWordsPath addLineToPoint:CGPointMake(LINE_HORIZONTAL_END_POINT, originY)];
    _completedWordsShapeLayer.path = finishedWordsPath.CGPath;
    [self.layer addSublayer:_completedWordsShapeLayer];
}

- (void)configureWithProgress:(CourseStepProgress *)progress
{
    _courseStepName.text = progress.courseStep.title;
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"100%"];//progress.completedPercentageString];
    [message addAttribute:NSFontAttributeName value:FONT_TYPE(@"UltraLight", 40) range:NSMakeRange([message length] - 1, 1)];
    _completedPercentage.attributedText = message;
    [_completedPercentage sizeToFit];
    
    _backgroundImageView.image = [[UIImage imageNamed:progress.courseStep.imageName] applyDarkEffect];
    
    _startedWordsStrokeEnd = (float)progress.completedItems / progress.courseStep.numberOfItems;
    _completedWordsStrokeEnd = (float)progress.startedItems / progress.courseStep.numberOfItems;
}

// Private method not referenced in .m file
- (void)animate
{
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 2;
    strokeEndAnimation.fromValue = @(_startedWordsShapeLayer.strokeEnd);
    strokeEndAnimation.toValue = @(1.f);
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    strokeEndAnimation.repeatCount = 0.f;
    strokeEndAnimation.beginTime = CACurrentMediaTime() + 2;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [_startedWordsShapeLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    strokeEndAnimation.toValue = @(_completedWordsStrokeEnd);
    [_completedWordsShapeLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimationFin"];
}



@end
