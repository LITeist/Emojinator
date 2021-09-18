//
//  EMJSettingsScreen.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 11.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJSettingsScreen.h"
#import "DVSwitch.h"
#import "EmojyHelper.h"


static const CGFloat EMJButtonSize = 45.f;

@interface EMJSettingsScreen ()
@property (nonatomic, strong) UIView *cardContentView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *magicDescriptionLabel;
@property (nonatomic, strong) UILabel *buttonDescriptionLabel;
@property (nonatomic, strong) DVSwitch *animationMagicSwitcher;
@property (nonatomic, strong) DVSwitch *animationButtonSwitcher;
@property (nonatomic, strong) UIView *separatorView;
@end

@implementation EMJSettingsScreen


- (instancetype)initWithFrame:(CGRect)frame
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self = [super initWithEffect:blurEffect];
    if (self)
    {
        self.frame = frame;
        
        _cardContentView = [[UIView alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height, self.frame.size.width - 20*2, [UIScreen mainScreen].bounds.size.height - 145)];
        _cardContentView.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        _cardContentView.layer.cornerRadius = 15.f;
        [self.contentView addSubview:_cardContentView];
        [self addSettings];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"Закрыть" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAndRemoveFromWindow) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - EMJButtonSize - 5, [UIScreen mainScreen].bounds.size.width, EMJButtonSize);
        [_closeButton setTitleColor:[UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        _closeButton.hidden = YES;
        [self.contentView addSubview:_closeButton];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.cardContentView.center = CGPointMake(self.cardContentView.center.x, self.cardContentView.center.y - ([UIScreen mainScreen].bounds.size.height - 45));
    } completion:^(BOOL finished) {
        self.closeButton.hidden = NO;
    }];
}

- (void)closeAndRemoveFromWindow
{
    self.closeButton.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
          self.cardContentView.center = CGPointMake(self.cardContentView.center.x, self.cardContentView.center.y + ([UIScreen mainScreen].bounds.size.height - 45));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addSettings
{
    self.separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.cardContentView.frame)/2 - 1, CGRectGetWidth(self.cardContentView.frame), 1)];
    self.separatorView.backgroundColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    [self.cardContentView addSubview:self.separatorView];
    
    self.magicDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 50, self.cardContentView.frame.size.width - 25 * 2, 60)];
    self.magicDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.magicDescriptionLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:23]];
    self.magicDescriptionLabel.numberOfLines = 2;
    self.magicDescriptionLabel.text = @"Анимация\nэмоджинации:";
    self.magicDescriptionLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    [self.cardContentView addSubview:self.magicDescriptionLabel];
    self.animationMagicSwitcher = [[DVSwitch alloc] initWithStringsArray:@[@"Процесс", @"Загрузка"]];
    self.animationMagicSwitcher.frame = CGRectMake(25, CGRectGetMaxY(self.magicDescriptionLabel.frame) + [EmojyHelper properValueWithDefaultValue:25], self.cardContentView.frame.size.width - 2 * 25, [EmojyHelper properValueWithDefaultValue:35]);
    self.animationMagicSwitcher.backgroundColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
    self.animationMagicSwitcher.sliderColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    self.animationMagicSwitcher.labelTextColorInsideSlider = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    self.animationMagicSwitcher.labelTextColorOutsideSlider = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    [self.cardContentView addSubview:self.animationMagicSwitcher];
    [self.animationMagicSwitcher setPressedHandler:^(NSUInteger index)
    {
        [EmojyHelper setIsMagicEnabled:(index == 0) ? YES : NO];
    }];

    self.buttonDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 45 + CGRectGetMaxY(self.separatorView.frame), self.cardContentView.frame.size.width - 25 * 2, 60)];
    self.buttonDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonDescriptionLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:23]];
    self.buttonDescriptionLabel.numberOfLines = 2;
    self.buttonDescriptionLabel.text = @"Анимация нажатия на кнопку:";
    self.buttonDescriptionLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    [self.cardContentView addSubview:self.buttonDescriptionLabel];
    self.animationButtonSwitcher = [[DVSwitch alloc] initWithStringsArray:@[@"Эмодзи", @"Нет"]];
    self.animationButtonSwitcher.frame = CGRectMake(25, CGRectGetMaxY(self.buttonDescriptionLabel.frame) + [EmojyHelper properValueWithDefaultValue:25], self.cardContentView.frame.size.width - 2 * 25, [EmojyHelper properValueWithDefaultValue:35]);
    self.animationButtonSwitcher.backgroundColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
    self.animationButtonSwitcher.sliderColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    self.animationButtonSwitcher.labelTextColorInsideSlider = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
    self.animationButtonSwitcher.labelTextColorOutsideSlider = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
    [self.cardContentView addSubview:self.animationButtonSwitcher];
    [self.animationButtonSwitcher setPressedHandler:^(NSUInteger index)
    {
        [EmojyHelper setIsButtonAnimationEnabled:(index == 0) ? YES : NO];
    }];

    [self.animationMagicSwitcher selectIndex:[EmojyHelper isMagicEnabled] ? 0 : 1 animated:NO];
    [self.animationButtonSwitcher selectIndex:[EmojyHelper isButtonAnimationEnabled] ? 0 : 1 animated:NO];
        
    // TODO вытаскиваем из EmojyHelper'a и задавать с помощью - (void)selectIndex:(NSInteger)index animated:(BOOL)animated;
}

@end
