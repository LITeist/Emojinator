//
//  EMJSingleInAppPurchaseView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 30.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJSingleInAppPurchaseView.h"
#import "EmojiHolderView.h"
#import "EMJButtonAnimationEffect.h"
#import "EmojyHelper.h"


static const CGFloat EMJButtonSize = 45;

@interface EMJSingleInAppPurchaseView ()
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) EMJInAppObject *inAppObject;
@property (nonatomic, strong) EmojiHolderView *holderView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@end

@implementation EMJSingleInAppPurchaseView

- (instancetype)initWithInAppObject:(EMJInAppObject *)inAppObject andFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        self.backgroundColor = yellowColor;
        self.layer.cornerRadius = 15.f;
        _inAppObject = inAppObject;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - EMJButtonSize - 10 - 2)];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _holderView = [[EmojiHolderView alloc] initWithInAppType:inAppObject.inAppType andWidth:CGRectGetWidth(frame)];
        [_scrollView addSubview:_holderView];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_holderView.frame) + 15/* Proper Value добавить*/, CGRectGetWidth(frame) - 30 * 2, 60)];
        _titleLabel.text = inAppObject.inAppTitle;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.numberOfLines = 0;
        [_scrollView addSubview:_titleLabel];
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_titleLabel.frame) + 15/* Proper Value добавить*/, CGRectGetWidth(frame) - 30 * 2, 30 * 5)];
        _descriptionLabel.text = inAppObject.inAppDescription;
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:19];
        _descriptionLabel.numberOfLines = 0;
        [_scrollView addSubview:_descriptionLabel];
        [_descriptionLabel sizeToFit];
        _scrollView.contentSize = CGSizeMake(frame.size.width, CGRectGetMaxY(_descriptionLabel.frame));
                            
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.frame = CGRectMake(20, CGRectGetHeight(frame) - EMJButtonSize - 10, CGRectGetWidth(frame) - 20 * 2, EMJButtonSize);
        [_buyButton setTitle:NSLocalizedString(@"Купить за 99₽", nil) forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(tryToBuyInApp) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchDown];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _buyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_buyButton setBackgroundColor:[UIColor colorWithRed:201/255.0 green:34/255.0 blue:24/255.0 alpha:1]];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyButton.layer.cornerRadius = EMJButtonSize/2;
        [self addSubview:_buyButton];
    }
    return self;
}

- (void)startAnimation
{
    if ([EmojyHelper isButtonAnimationEnabled])
    {
        [[EMJButtonAnimationEffect new] startAnimationWithType:EMJEffectTypeLove andFrame:CGRectMake(60, CGRectGetMinY  (self.buyButton.frame), CGRectGetWidth(self.buyButton.frame) - 20, CGRectGetHeight(self.buyButton.frame))];
    }
}

- (void)tryToBuyInApp
{
    // Привязываться к типу InApp и т.д.
}

@end
