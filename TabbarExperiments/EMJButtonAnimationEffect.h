//
//  EMJButtonAnimationEffect.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 06.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum EMJEffectType : NSUInteger
{
    EMJEffectTypeLove,
    EMJEffectTypeMoney,
    EMJEffectTypeStartMagic,
    EMJEffectTypeChoosePicture
}EffectType;

@interface EMJButtonAnimationEffect : NSObject

- (void)startAnimationWithType:(EffectType)effectType andFrame:(CGRect)rectFrame;
- (void)stopLoveAnimation;

@end
