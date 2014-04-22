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
#import "NSString+HTMLHelpers.h"

#define VIEW_HEIGHT 150.0f
#define PARALLAX_OFFSET CGSizeMake(20, 10)
#define LINE_WIDTH 14.0f
#define LINE_HORIZONTAL_END_POINT 160.0f

@interface EVCourseView () {
    UILabel *courseStepNameLabel;
    UITextView *courseStepDescriptionTextView;
    UIImageView *backgroundImageView;
}

@property (retain, nonatomic) UILabel *courseStepNameLabel;
@property (retain, nonatomic) UITextView *courseStepDescriptionTextView;
@property (retain, nonatomic) UIImageView *backgroundImageView;

@end

@implementation EVCourseView

@synthesize courseStepNameLabel;
@synthesize courseStepDescriptionTextView;
@synthesize backgroundImageView;

+ (CGFloat)defaultHeight
{
    return VIEW_HEIGHT;
}

- (instancetype)initWithOrigin:(CGPoint)origin {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, VIEW_HEIGHT)];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.layer.masksToBounds = YES;
    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-PARALLAX_OFFSET.width,
                                                                         -PARALLAX_OFFSET.height,
                                                                         self.bounds.size.width + PARALLAX_OFFSET.width * 2,
                                                                         self.bounds.size.height + PARALLAX_OFFSET.height * 2)];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundImageView];
    
    [EVMotionHelper parallaxMotionForView:backgroundImageView movementOffset:PARALLAX_OFFSET];
    
    CGFloat margin = 10.0f; // Move to macro
    courseStepNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 10,
                                                                self.bounds.size.width - margin * 2, 20)];
    courseStepNameLabel.numberOfLines = 0;
    courseStepNameLabel.textColor = [UIColor whiteColor];
    courseStepNameLabel.font = FONT_TYPE(@"Light", 18);
    [self addSubview:courseStepNameLabel];
    
    courseStepDescriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(margin,
                                                                                 courseStepNameLabel.frame.origin.y + courseStepNameLabel.frame.size.height,
                                                                                 self.bounds.size.width - margin * 2,
                                                                                 self.bounds.size.height - courseStepNameLabel.frame.origin.y)];
    courseStepDescriptionTextView.textColor = [UIColor whiteColor];
    courseStepDescriptionTextView.font = FONT_TYPE(@"Thin", 13);
    courseStepDescriptionTextView.backgroundColor = [UIColor clearColor];
    courseStepDescriptionTextView.dataDetectorTypes = UIDataDetectorTypeLink;
    courseStepDescriptionTextView.selectable = YES;
    courseStepDescriptionTextView.editable = NO;
    [self addSubview:courseStepDescriptionTextView];
}

- (void)configureWithCourseStep:(CourseStep *)courseStep {
    courseStepNameLabel.text = courseStep.title;
    courseStepDescriptionTextView.text = [courseStep.descriptionText stripTags];
    backgroundImageView.image = [[UIImage imageNamed:@"takayama.jpg"] applyDarkEffect];
}

- (void)dealloc {
    RELEASE_AND_NULLIFY(courseStepNameLabel);
    RELEASE_AND_NULLIFY(courseStepDescriptionTextView);
    RELEASE_AND_NULLIFY(backgroundImageView);
    [super dealloc];
}

@end
