//
//  EMJIntenseView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJIntenseView.h"
#import "EmojyHelper.h"


@interface EMJIntenseView ()
@property (nonatomic, strong) UILabel *editDescriptionLabel;
@property (nonatomic, strong) UISlider *tempSlider;
@end


@implementation EMJIntenseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        UIView *gradientView = [[UIView alloc] initWithFrame:frame];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = gradientView.bounds;
        gradient.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.8].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.6].CGColor];
        [gradientView.layer insertSublayer:gradient atIndex:0];
        [self addSubview:gradientView];
        
        self.editDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, [EmojyHelper properValueWithDefaultValue:5], 90, [EmojyHelper properValueWithDefaultValue:30])];
        self.editDescriptionLabel.textColor = [UIColor whiteColor];
        self.editDescriptionLabel.text = @"Интенсивность:";
        self.editDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        [self addSubview:self.editDescriptionLabel];
        
        [self.editDescriptionLabel sizeToFit];
        self.editDescriptionLabel.center = CGPointMake(self.editDescriptionLabel.center.x, gradientView.center.y);
        
        _tempSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.editDescriptionLabel.frame) + 10, [EmojyHelper properValueWithDefaultValue:6], frame.size.width - CGRectGetMaxX(self.editDescriptionLabel.frame) - 20, [EmojyHelper properValueWithDefaultValue:40 - 6 * 2])];
        _tempSlider.tintColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        [_tempSlider addTarget:self action:@selector(intensityValueChanged) forControlEvents:UIControlEventValueChanged];
        _tempSlider.thumbTintColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _tempSlider.value = _tempSlider.maximumValue;
        [self addSubview:_tempSlider];
    }
    
    return self;
}

- (void)intensityValueChanged
{
    [self.delegate sliderValueDidChange:self.tempSlider.value];
}

@end
