//
//  EMJTabbarControl.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 17.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJTabbarControl.h"
#import "EMJButtonAnimationEffect.h"
#import "BadgeView.h"


static const CGFloat EMJCircleButtonSize = 80;

@interface EMJTabbarControl ()
@property (nonatomic, strong) UIView *tabBarBackgroundView;
@property (nonatomic, strong) UIView *tabBarCircleBackground;

@property (nonatomic, strong) UIButton *mainCircleButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImageView *mainButtonImage;
@property (nonatomic, strong) UIImageView *leftButtonImage;
@property (nonatomic, strong) UIImageView *rightButtonImage;

@property (nonatomic, strong) UIButton *mainButton;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) EMJChooseDialog *dialogView;
@end

@implementation EMJTabbarControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        const CGFloat EMJBackgroundOffset = 110/2;//frame.size.height/2;
        
        _tabBarCircleBackground = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2 - EMJCircleButtonSize/2, 25 + (200 - 110), EMJCircleButtonSize, EMJCircleButtonSize)];
        _tabBarCircleBackground.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        _tabBarCircleBackground.layer.cornerRadius = EMJCircleButtonSize/2;
        _tabBarCircleBackground.layer.masksToBounds = YES;
        _tabBarCircleBackground.layer.borderColor = [UIColor colorWithRed:235/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
        _tabBarCircleBackground.layer.borderWidth = 2;
        [self addSubview:_tabBarCircleBackground];
        
        self.backgroundColor = [UIColor clearColor];
        _tabBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, EMJBackgroundOffset + (200 - 110), frame.size.width, EMJBackgroundOffset)];
        _tabBarBackgroundView.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        [self addSubview:_tabBarBackgroundView];
        
        UIView *tabBarLeftBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, EMJBackgroundOffset + (200 - 110), self.frame.size.width/2 - EMJCircleButtonSize/2 + 2, 2)];
        tabBarLeftBorderView.backgroundColor = [UIColor colorWithRed:235/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self addSubview:tabBarLeftBorderView];
        
        UIView *tabBarRightBorderView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 + EMJCircleButtonSize/2 - 2, EMJBackgroundOffset + (200 - 110), self.frame.size.width/2 - EMJCircleButtonSize/2, 2)];
        tabBarRightBorderView.backgroundColor = [UIColor colorWithRed:235/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self addSubview:tabBarRightBorderView];
        
        const CGFloat EMJMainCircleSize = EMJCircleButtonSize - 10;
        _mainCircleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mainCircleButton.frame = CGRectMake(frame.size.width/2 - EMJCircleButtonSize/2 + 5, 20 + 10 + (200 - 110), EMJMainCircleSize, EMJMainCircleSize);
        _mainCircleButton.layer.cornerRadius = EMJMainCircleSize/2;
        _mainCircleButton.layer.masksToBounds = YES;
        _mainCircleButton.backgroundColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        [_mainCircleButton addTarget:self action:@selector(startGlow) forControlEvents:UIControlEventTouchDown];
        [_mainCircleButton addTarget:self action:@selector(endGlow) forControlEvents:UIControlEventTouchCancel];
        [_mainCircleButton addTarget:self action:@selector(endGlow) forControlEvents:UIControlEventTouchUpOutside];
        [_mainCircleButton addTarget:self action:@selector(doMagic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mainCircleButton];
        
        _mainButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magicWand"]];
        _mainButtonImage.image = [_mainButtonImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_mainButtonImage setTintColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1]];
        _mainButtonImage.frame = CGRectMake(0, 0, 40, 40);
        _mainButtonImage.center = CGPointMake(_mainCircleButton.center.x + 3, _mainCircleButton.center.y - 1);
        [self addSubview:_mainButtonImage];
        
        _leftButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inApp"]];
        _leftButtonImage.image = [_leftButtonImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_leftButtonImage setTintColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1]];
        _leftButtonImage.frame = CGRectMake(0, 0, 28, 28);
        _leftButtonImage.center = CGPointMake(5 * frame.size.width/6, _tabBarBackgroundView.center.y - 2);
        [self addSubview:_leftButtonImage];
		
		BadgeView *badgeView = [[BadgeView alloc] initWithNumberInteger:5];
		badgeView.center = CGPointMake(_leftButtonImage.center.x + 9, _leftButtonImage.center.y - 8);
		[self addSubview:badgeView];
        
        _rightButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings"]];
        _rightButtonImage.image = [_rightButtonImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_rightButtonImage setTintColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1]];
        _rightButtonImage.frame = CGRectMake(0, 0, 35, 35);
        _rightButtonImage.center = CGPointMake(frame.size.width/6, _tabBarBackgroundView.center.y);
        [self addSubview:_rightButtonImage];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = _rightButtonImage.frame;
        _leftButton.center = _rightButtonImage.center;
        [_leftButton addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:_leftButton];
        
        _rightButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = _leftButtonImage.frame;
        _rightButton.center = _leftButtonImage.center;
        [_rightButton addTarget:self action:@selector(openShareVC) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitle:@"" forState:UIControlStateNormal];
        [self addSubview:_rightButton];

    }
    return self;
}

- (void)updateLeftButtonWithMainType:(ButtonType)buttonType
{
    /* ШО ПО ТУПИЗНЕ - Лево и Право перепутал :((( */
    [_leftButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    switch (buttonType)
    {
        case EmojiCircleButtonSmallSettings:
        {
            _rightButtonImage.image = [UIImage imageNamed:@"settings"];
            _rightButtonImage.frame = CGRectMake(0, 0, 35, 35);
            _rightButtonImage.center = CGPointMake(self.frame.size.width/6, _tabBarBackgroundView.center.y);
            [_leftButton addTarget:self action:@selector(openImageLibrary) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case EmojiCircleButtonSmallReloadImage:
        {
            _rightButtonImage.image = [UIImage imageNamed:@"reloadIcn"];
            _rightButtonImage.frame = CGRectMake(0, 0, 35, 35);
            _rightButtonImage.center = CGPointMake(self.frame.size.width/6, _tabBarBackgroundView.center.y);
            [_leftButton addTarget:self action:@selector(openImageLibrary) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        default:
            break;
    }
    _rightButtonImage.image = [_rightButtonImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_rightButtonImage setTintColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1]];
}

- (void)updateMainButtonWithMainType:(ButtonType)buttonType
{
    [_mainCircleButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    switch (buttonType)
    {
        case EmojiCircleButtonPlainMain:
        case EmojiCircleButtonCameraMain:
        {
            [_mainCircleButton addTarget:self action:@selector(chooseSource) forControlEvents:UIControlEventTouchUpInside];
            
            UIImage *plusImage = [UIImage imageNamed:@"plus"];
            self.mainButtonImage.frame = CGRectMake(0, 0, 85, 85);
            self.mainButtonImage.center = self.mainCircleButton.center;
            self.mainButtonImage.image = plusImage;
        }
            break;
        case EmojiCircleButtonMagicMain:
        {
            [_mainCircleButton addTarget:self action:@selector(doMagic) forControlEvents:UIControlEventTouchUpInside];

            UIImage *magicWand = [UIImage imageNamed:@"magicWand"];
            self.mainButtonImage.frame = CGRectMake(0, 0, 40, 40);
            self.mainButtonImage.center = CGPointMake(self.mainCircleButton.center.x + 3, self.mainCircleButton.center.y - 1);
            self.mainButtonImage.image = magicWand;
        }
            break;
        case EmojiCircleButtonCloseMain:
        {
            [_mainCircleButton addTarget:self action:@selector(closeIcon) forControlEvents:UIControlEventTouchUpInside];

            UIImage *closeIcon = [UIImage imageNamed:@"closeIcn"];
            self.mainButtonImage.frame = CGRectMake(0, 0, 60, 60);
            self.mainButtonImage.center = self.mainCircleButton.center;
            self.mainButtonImage.image = closeIcon;
        }
            break;
        default:
            break;
    }
    self.mainButtonImage.image = [self.mainButtonImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.mainButtonImage setTintColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1]];
}

- (void)updateRightButtonWithMainType:(ButtonType)buttonType
{
    
}

- (void)startGlow
{
    const CGFloat EMJMainButtonOffset = 2.7;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainCircleButton.layer.cornerRadius = self.mainCircleButton.layer.cornerRadius + EMJMainButtonOffset;
        self.mainCircleButton.frame = CGRectMake(CGRectGetMinX(self.mainCircleButton.frame) - EMJMainButtonOffset, CGRectGetMinY(self.mainCircleButton.frame) - EMJMainButtonOffset, CGRectGetWidth(self.mainCircleButton.frame) + 2 * EMJMainButtonOffset, CGRectGetHeight(self.mainCircleButton.frame) + 2 * EMJMainButtonOffset);
    } completion:^(BOOL finished) {
    }];
}

- (void)endGlow
{
    const CGFloat EMJMainButtonOffset = 2.7;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainCircleButton.layer.cornerRadius = self.mainCircleButton.layer.cornerRadius - EMJMainButtonOffset;
        self.mainCircleButton.frame = CGRectMake(CGRectGetMinX(self.mainCircleButton.frame) + EMJMainButtonOffset, CGRectGetMinY(self.mainCircleButton.frame) + EMJMainButtonOffset, CGRectGetWidth(self.mainCircleButton.frame) - 2 * EMJMainButtonOffset, CGRectGetHeight(self.mainCircleButton.frame) - 2 * EMJMainButtonOffset);
    } completion:nil];
}

- (void)chooseSource
{
    [self endGlow];
    [self presentSourceTypeWindow];
}

- (void)presentSourceTypeWindow
{
    EMJDialogElement *title = [EMJDialogElement elementWithName:@"Выбрать картинку из:" andImageName:@""];
    EMJDialogElement *fromCamera = [EMJDialogElement elementWithName:@"Фотогалерея" andImageName:@"galeryIcn"];
    EMJDialogElement *fromGallery = [EMJDialogElement elementWithName:@"Камера" andImageName:@"cameraIcn"];
    self.dialogView = [[EMJChooseDialog alloc] initWithDialogElements:@[title, fromCamera, fromGallery]];
    self.dialogView.center = CGPointMake(self.dialogView.center.x, self.dialogView.center.y +  CGRectGetHeight(self.dialogView.frame) + (200 - 110));
    self.dialogView.delegate = self;
    [self insertSubview:self.dialogView belowSubview:self.tabBarBackgroundView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.dialogView.center = CGPointMake(self.dialogView.center.x, self.dialogView.center.y -  CGRectGetHeight(self.dialogView.frame));
    } completion:^(BOOL finished)
     {
         [self updateMainButtonWithMainType:EmojiCircleButtonCloseMain];
         UIVisualEffect *blurEffect;
         blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]; // LIGHT
         self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
         self.visualEffectView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.dialogView.frame));
         [[UIApplication sharedApplication].keyWindow addSubview:self.visualEffectView];
     }];

}

- (void)doMagic
{
    [self endGlow];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EMJMagic" object:nil];
    // send magic sign
}

- (void)closeIcon
{
    [self endGlow];
    [self closeIconAction];
}

- (void)closeIconAction
{
    [UIView animateWithDuration:0.2 animations:^{
        self.dialogView.center = CGPointMake(self.dialogView.center.x, self.dialogView.center.y +  CGRectGetHeight(self.dialogView.frame));
        [self.visualEffectView removeFromSuperview];
    }
                     completion:^(BOOL finished)
     {
         [self.dialogView removeFromSuperview];
         self.dialogView = nil;
         [self updateMainButtonWithMainType:EmojiCircleButtonCameraMain];
     }];
}

- (void)openImageLibrary
{
    [self.delegate sourceButtonDidTap];
}

- (void)openShareVC
{
    [self.delegate inAppButtonDidTap];
}

- (void)openSettings
{
    [self.delegate openSettings];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *view in self.subviews)
    {
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}

- (void)didSelectWithElement:(EMJDialogElement *)element
{
    [self closeIconAction];
    
    if ([element.name.lowercaseString containsString:@"галерея"])
        [self.delegate sourceButtonDidTap];
    else
        [self.delegate cameraButtonDidTap];
}
@end
