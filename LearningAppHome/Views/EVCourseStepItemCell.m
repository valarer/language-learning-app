//
//  EVdTableViewCell.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "EVCourseStepItemCell.h"

@interface EVCourseStepItemCell ()

@property (strong, nonatomic) UILabel *wordLabel;
@property (strong, nonatomic) UILabel *transliterationLabel;
@property (strong, nonatomic) UILabel *meaningLabel;
@property (strong, nonatomic) UILabel *partOfSpeechLabel;

@end

@implementation EVCourseStepItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self instantiateViews];
    }
    return self;
}

- (void)instantiateViews
{
    _wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 76, 52)];
    _wordLabel.font = FONT(20);
    _wordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_wordLabel];
    
    _transliterationLabel = [[UILabel alloc] initWithFrame:CGRectMake(104, 20, 138, 16)];
    _transliterationLabel.font = FONT(14);
    [self addSubview:_transliterationLabel];
    
    _meaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(104, 28, 196, 34)];
    _meaningLabel.font = FONT_TYPE(@"Thin", 14);
    _meaningLabel.numberOfLines = 0;
    _meaningLabel.textColor = [UIColor lightGrayColor];
    _meaningLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_meaningLabel];
    
    _partOfSpeechLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 3, 85, 21)];
    _partOfSpeechLabel.font = FONT_TYPE(@"Light", 12);
    _partOfSpeechLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_partOfSpeechLabel];
}

#pragma mark - Data configuration

- (void)configureWithModel:(CourseStepItem *)courseStepItem
{
    _wordLabel.text = courseStepItem.text;
    _meaningLabel.text = courseStepItem.meaning;
    
    // Better to check the original object then the text assigned to a label
    if (![courseStepItem.partOfSpeech isEqualToString:@"None"]) {
        _partOfSpeechLabel.text = courseStepItem.partOfSpeech;
    }else {
        _partOfSpeechLabel.text = @"";
    }
    
    if ([courseStepItem.language isEqualToString:LANG_JA]) {
        _transliterationLabel.text = courseStepItem.hiraganaWord;
        if ([_transliterationLabel.text isEqualToString:_wordLabel.text]) {
            [self centerContentVertically];
        }
    }
    else if ([courseStepItem.language isEqualToString:LANG_EN]) {
        _wordLabel.font = FONT(15);
        [self centerContentVertically];
    }
    else {
        [self centerContentVertically];
    }
}

// You are calling this in all cases except when _transliterationLabel.text != _wordLabel.text
// Does it ever get reset? This table view cell will likely be reused. 
- (void)centerContentVertically
{
    _transliterationLabel.hidden = YES;
    _meaningLabel.center = CGPointMake(_meaningLabel.center.x, _meaningLabel.center.y - 10);
}

@end
