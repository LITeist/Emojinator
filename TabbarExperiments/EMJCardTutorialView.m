//
//  EMJCardTutorialView.m
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJCardTutorialView.h"
#import "EmojyHelper.h"


@interface EMJCardTutorialView ()

@property (nonatomic, retain) EMJTutorialObject *object;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain) UIButton *lastPageButton;

@end


@implementation EMJCardTutorialView

- (instancetype)initWithTutorialObject:(EMJTutorialObject *)object;
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        
        _object = object;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        
        _iconImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:object.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _iconImageView.tintColor = yellowColor;
        _iconImageView.frame = CGRectMake(0, self.frame.size.height/4, 80, 80);
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        BOOL shouldMoveImage = [self.object.imageName isEqualToString:@"magicWand"];
        _iconImageView.center = CGPointMake(shouldMoveImage ? self.center.x + [EmojyHelper properValueWithDefaultValue:8] : self.center.x, self.iconImageView.center.y);
        [self addSubview:_iconImageView];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:[EmojyHelper properValueWithDefaultValue:25.0]];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.frame = CGRectMake(30, CGRectGetMaxY(_iconImageView.frame) + [EmojyHelper properValueWithDefaultValue:20], self.frame.size.width - 30 * 2, [EmojyHelper properValueWithDefaultValue:120]);
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = object.titleString;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:[EmojyHelper properValueWithDefaultValue:22.0]];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.frame = CGRectMake(30, CGRectGetMaxY(_titleLabel.frame) + [EmojyHelper properValueWithDefaultValue:20], self.frame.size.width - 30 * 2, [EmojyHelper properValueWithDefaultValue:180]);
        _descriptionLabel.numberOfLines = 4;
        _descriptionLabel.text = object.descriptionString;
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_descriptionLabel];
    }
    
    return self;
}

- (void)setShouldAddButton:(BOOL)shouldAddButton
{
    _shouldAddButton = shouldAddButton;
    if (shouldAddButton)
        [self addSubview:self.lastPageButton];
}

-(UIButton *)lastPageButton
{
    if (!_lastPageButton)
    {
        _lastPageButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.frame.size.height-75, self.frame.size.width - 40, 45)];
        _lastPageButton.layer.cornerRadius = 45.f/2;
        _lastPageButton.tintColor = [UIColor whiteColor];
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _lastPageButton.backgroundColor = yellowColor;
        [_lastPageButton setTitle:@"Погнали!" forState:UIControlStateNormal];
        [_lastPageButton.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:[EmojyHelper properValueWithDefaultValue:25.0]]];
        [_lastPageButton addTarget:self action:@selector(launchAppButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastPageButton;
}

- (void)launchAppButtonPressed
{
    [self.delegate continueButtonPressed];
}

@end
