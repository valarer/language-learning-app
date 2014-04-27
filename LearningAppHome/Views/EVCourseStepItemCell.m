//
//  EVdTableViewCell.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "EVCourseStepItemCell.h"

#define MEANING_LABEL_FRAME CGRectMake(104, 18, 196, 34)

@interface EVCourseStepItemCell ()

@property (retain, nonatomic) UILabel *wordLabel;
@property (retain, nonatomic) UILabel *transliterationLabel;
@property (retain, nonatomic) UILabel *meaningLabel;
@property (retain, nonatomic) UILabel *partOfSpeechLabel;

@end

@implementation EVCourseStepItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 76, 52)];
    _wordLabel.font = FONT(20);
    _wordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_wordLabel];
    
    _transliterationLabel = [[UILabel alloc] initWithFrame:CGRectMake(104, 20, 138, 16)];
    _transliterationLabel.font = FONT(14);
    _transliterationLabel.hidden = YES;
    [self addSubview:_transliterationLabel];
    
    _meaningLabel = [[UILabel alloc] initWithFrame:MEANING_LABEL_FRAME];
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

- (void)dealloc {
    RELEASE_AND_NULLIFY(_wordLabel);
    RELEASE_AND_NULLIFY(_transliterationLabel);
    RELEASE_AND_NULLIFY(_meaningLabel);
    RELEASE_AND_NULLIFY(_partOfSpeechLabel);
    [super dealloc];
}

#pragma mark - Data configuration

- (void)configureWithModel:(CourseStepItem *)courseStepItem {
    
    [self resetView];
    
    _wordLabel.text = courseStepItem.text;
    _meaningLabel.text = courseStepItem.meaning;

    if (![courseStepItem.partOfSpeech isEqualToString:@"None"]) {
        _partOfSpeechLabel.text = courseStepItem.partOfSpeech;
    }
    else {
        _partOfSpeechLabel.text = @"";
    }
    
    if ([courseStepItem.language isEqualToString:LANG_JA]) {
        _transliterationLabel.text = courseStepItem.hiraganaWord;
        if (![_transliterationLabel.text isEqualToString:_wordLabel.text]) {
            [self layoutForCellWithTransliteration];
        }
    }
    else if ([courseStepItem.language isEqualToString:LANG_EN]) {
        _wordLabel.font = FONT(15);
    }
}

- (void)layoutForCellWithTransliteration {
    _transliterationLabel.hidden = NO;
    _meaningLabel.center = CGPointMake(_meaningLabel.center.x, _meaningLabel.center.y + 10);
}

- (void)resetView {
    _transliterationLabel.hidden = YES;
    _meaningLabel.frame = MEANING_LABEL_FRAME;
}

@end
