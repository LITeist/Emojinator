//
//  UnderConstructionView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.07.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "UnderConstructionView.h"
#import "EmojyHelper.h"


static const CGFloat EMJButtonSize = 45.f;

@interface UnderConstructionView ()
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *cardView;
@end

@implementation UnderConstructionView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _cardView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width - 15 * 2, [UIScreen mainScreen].bounds.size.height - EMJButtonSize - 145)];
        _cardView.layer.cornerRadius = 15.f;
        _cardView.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        [self addSubview:_cardView];
        
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _imageView.image = [[UIImage imageNamed:@"underConstr"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageView.center = CGPointMake(self.center.x - 13, 135);
        _imageView.tintColor = yellowColor;
        [_cardView addSubview:_imageView];
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageView.frame) + 35, _cardView.frame.size.width - 20*2, [EmojyHelper properValueWithDefaultValue:155])];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:20]];
        _descriptionLabel.text = @"В скором времени тут появятся новые фильтры и способы эмоджинации.\nАбсолютно бесплатно!\nStay turned!";
        [_cardView addSubview:_descriptionLabel];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"Закрыть" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAndRemoveFromWindow) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - EMJButtonSize - 5, [UIScreen mainScreen].bounds.size.width, EMJButtonSize);
        [_closeButton setTitleColor:[UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        self.alpha = 1;
    }
    
    return self;
}

- (void)presentOnWindow
{
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self.visualEffectView];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.closeButton];
    }];
}

- (void)closeAndRemoveFromWindow
{
    [self.closeButton removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self.visualEffectView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
