//
//  CIFilterHelper.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum EmojiColorType : NSUInteger
{
    EmojiColorTypeRed,
    EmojiColorTypeGreen,
    EmojiColorTypeBlue
}ColorType;

typedef enum EmojiFilterType : NSUInteger
{
    EmojiFilterTypeOne,
    EmojiFilterTypeTwo,
    EmojiFilterTypeThree,
    EmojiFilterTypeFour,
    EmojiFilterTypeFive,
    EmojiFilterTypeSix,
    EmojiFilterTypeSeven,
    EmojiFilterTypeEight,
    EmojiFilterTypeComicEffect,
    EmojiFilterTypeShadowAdjust,
    EmojiFilterTypeCold,
    EmojiFilterTypeBletEffect
}FilterType;

@interface CIFilterHelper : NSObject

+ (instancetype)shared;
- (UIImage *)applyMonoChromeWithRandColor:(UIImage *)uIImage;
- (UIImage *)applyColorMatrixFilter:(UIImage *)uIImage withColorType:(ColorType)colorType andIntensity:(NSNumber *)intensity;

- (UIImage *)imageForFilterType:(FilterType)filterType withImage:(UIImage *)image andIntensity:(NSNumber *)intensity;
@end
