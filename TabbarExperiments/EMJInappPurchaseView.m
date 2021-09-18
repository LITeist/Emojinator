//
//  EMJInappPurchaseView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 28.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJInappPurchaseView.h"
#import "EMJInappPurchaseScrollView.h"
#import "EMJSingleInAppPurchaseView.h"
#import "EMJButtonAnimationEffect.h"
#import "EmojyHelper.h"


static const CGFloat EMJButtonSize = 45.f;

@interface EMJInappPurchaseView ()
@property (nonatomic, strong)     UIButton *closeButton;
@property (nonatomic, strong)     UIVisualEffectView *visualEffectView;
// Возможно вся инфа будет на карточке - точно будет на карточке
@property (nonatomic, strong)     UIImageView *leftEmojiImageView;
@property (nonatomic, strong)     UIImageView *rightEmojiImageView;
@property (nonatomic, strong)     UIImageView *centralEmojiImageView;
@property (nonatomic, strong)     UILabel *topDescriptionLabel;
@property (nonatomic, strong)     EMJInappPurchaseScrollView *inAppScrollView;
//
@property (nonatomic, strong)     UIButton *restoreInAppButton;
@end

@implementation EMJInappPurchaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        self.layer.cornerRadius = 15;
        
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setTitle:@"Закрыть" forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(closeAndRemoveFromWindow) forControlEvents:UIControlEventTouchUpInside];
        self.closeButton.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - EMJButtonSize - 5, [UIScreen mainScreen].bounds.size.width, EMJButtonSize);
        [self.closeButton setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1] forState:UIControlStateNormal];
        self.alpha = 1;
        
        self.inAppScrollView = [[EMJInappPurchaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - EMJButtonSize - 20)];
        [self addSubview:self.inAppScrollView];
        
        self.restoreInAppButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.restoreInAppButton setTitle:NSLocalizedString(@"Восстановить покупки", nil) forState:UIControlStateNormal];
        [self.restoreInAppButton addTarget:self action:@selector(restoreInAppAction) forControlEvents:UIControlEventTouchUpInside];
        [self.restoreInAppButton addTarget:self action:@selector(startMoneyAnimation) forControlEvents:UIControlEventTouchDown];
        self.restoreInAppButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.restoreInAppButton setBackgroundColor:yellowColor];
        self.restoreInAppButton.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetHeight(self.frame) - EMJButtonSize - 10, CGRectGetWidth(self.frame) - CGRectGetMinX(self.frame)*2, EMJButtonSize);
        [self.restoreInAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.restoreInAppButton.layer.cornerRadius = EMJButtonSize/2;
        [self addSubview:self.restoreInAppButton];
    }
    return self;
}

- (void)presentOnWindow
{
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
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

- (void)prepareUI
{
    
}

- (void)restoreInAppAction
{
    // TODO - восстанавливать покупки
    // Тут же добавить анимацию
    
}

- (void)startMoneyAnimation
{
    if ([EmojyHelper isButtonAnimationEnabled])
    {
        [[EMJButtonAnimationEffect new] startAnimationWithType:EMJEffectTypeMoney andFrame:self.restoreInAppButton.frame];
    }
}

- (void)stopMoneyAnimation
{
    
}

@end
