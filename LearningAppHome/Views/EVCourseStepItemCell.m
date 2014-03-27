//
//  EVdTableViewCell.m
//  LearningAppHome
//
//  Created by Eric Velazquez on 3/27/14.
//
//

#import "EVCourseStepItemCell.h"

@interface EVCourseStepItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *kanjiLabel;
@property (weak, nonatomic) IBOutlet UILabel *transliterationLabel;
@property (weak, nonatomic) IBOutlet UILabel *meaningLabel;
@property (weak, nonatomic) IBOutlet UILabel *partOfSpeechLabel;

@end

@implementation EVCourseStepItemCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithModel:(CourseStepItem *)courseStepItem
{
    _kanjiLabel.text = courseStepItem.text;
    _transliterationLabel.text = courseStepItem.hiraganaWord;
    _meaningLabel.text = courseStepItem.meaning;
    _partOfSpeechLabel.text = courseStepItem.partOfSpeech;
}

@end
