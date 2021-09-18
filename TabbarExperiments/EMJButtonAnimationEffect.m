//
//  EMJButtonAnimationEffect.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 06.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJButtonAnimationEffect.h"

//kittyLove, add6
static const CGFloat EMJNumberOfEmojies = 25;

@interface EMJButtonAnimationEffect ()

@property (nonatomic, assign) EffectType effectType;
@end

@implementation EMJButtonAnimationEffect

/* Метод запускает емодзи на высоту frame от окончания frame */
- (void)startAnimationWithType:(EffectType)effectType andFrame:(CGRect)rectFrame;
{
    self.effectType = effectType;
    NSInteger numberOfEmojies = [self numberOfEmojies];
    for (int i = 1; i <= numberOfEmojies; i++)
    {
        CGFloat size = [self randomSize:rectFrame];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([self randomXCoordinate:rectFrame], CGRectGetMaxY(rectFrame), size, size)];
        imageView.image = [self imageForType:effectType];
        [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        CGFloat time = [self timeDependOnSize:size andBaseFrame:rectFrame];
        
        // TODO добавить свойство анимации - отсанавливаться к окончанию
        [UIView animateWithDuration:time delay:[self delayTime] options:UIViewAnimationOptionCurveEaseOut animations:^{
            [[UIApplication sharedApplication].keyWindow addSubview:imageView];

            imageView.center = CGPointMake(imageView.center.x, imageView.center.y - rectFrame.size.height);
            imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
}

- (CGFloat)numberOfEmojies
{
    NSInteger numberOfEmojies = EMJNumberOfEmojies * 2;
    if (self.effectType == EMJEffectTypeMoney)
        numberOfEmojies = EMJNumberOfEmojies * 3;
    else if (self.effectType == EMJEffectTypeStartMagic || self.effectType == EMJEffectTypeChoosePicture)
        numberOfEmojies = EMJNumberOfEmojies * 5;

    return numberOfEmojies;
}

- (void)stopLoveAnimation
{
    
}

- (UIImage *)imageForType:(EffectType)effectType
{
    UIImage *image = [UIImage new];
    switch (effectType)
    {
        case EMJEffectTypeLove:
        {
            image = [UIImage imageNamed:@"kittyLove"];
        }
            break;
        case EMJEffectTypeMoney:
        {
            image = [UIImage imageNamed:@"add6"];
        }
            break;
        case EMJEffectTypeStartMagic:
        {
            image = [UIImage imageNamed:@"yellowLove"];
        }
            break;
        case EMJEffectTypeChoosePicture:
        {
            image = [UIImage imageNamed:@"photoEMJ"];
        }
            break;
        default:
            break;
    }
    return image;
}

- (CGFloat)randomXCoordinate:(CGRect)rectFrame
{
    CGFloat maxValue = CGRectGetMaxX(rectFrame) - CGRectGetMinX(rectFrame);
    return CGRectGetMinX(rectFrame) + arc4random_uniform(maxValue);
}

- (CGFloat)randomSize:(CGRect)rectFrame
{
    CGFloat maxValue = CGRectGetHeight(rectFrame);
    return arc4random_uniform(maxValue);
}

- (CGFloat)timeDependOnSize:(CGFloat)emojiSize andBaseFrame:(CGRect)frame
{
  // Тяжелые - медленнее, легкие - быстрее
    return [self animationTime] * emojiSize/CGRectGetHeight(frame);
}

- (CGFloat)animationTime
{
    switch (self.effectType)
    {
        case EMJEffectTypeLove:
        case EMJEffectTypeMoney:
            return 1.1;
        case EMJEffectTypeStartMagic:
        case EMJEffectTypeChoosePicture:
            return 0.75;
        default:
            break;
    }
}

- (CGFloat)delayTime
{
    return (arc4random() % 1)/2;
}

//- (CGFloat)
@end
