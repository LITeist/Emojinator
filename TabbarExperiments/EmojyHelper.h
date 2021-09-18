//
//  EmojyHelper.h
//  EmodjArt
//
//  Created by Alexey Levanov on 23.02.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface EmojyHelper : NSObject

/* Функция вернет картинку, состоящую из прямоугольников со среднеми цветами внутри */
+ (UIImage *)imageWithAvarageColorRectsForImage:(UIImage *)image withSliderValue:(CGFloat)floatSliderValue forText:(BOOL)forText;
+ (UIImage *)emojiImageFromImage:(UIImage *)image withSliderValue:(CGFloat)floatSliderValue anRect:(CGRect)rect forText:(BOOL)forText;

/* Функция вернет картинку, состоящую из емоджи */
//+ (UIImage *)imageRedrawWithEmodgies:(UIImage *)image;

/* Функция вернет картинку, состоящую из мемчиков */
//+ (UIImage *)imageRedrawWithMems:(UIImage *)image;

/* Функция вернет картинку, состоящую из наиболее подходящих мемов и эмоджи */
//+ (UIImage *)imagrRedrawOptimal:(UIImage *)image;

+ (CGFloat)numberOfRectsWithSize:(int)size;

+ (UIColor *)averageColorForImage:(UIImage *)image;
+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)i_width;
+ (CGFloat)optimalRectNumberFromSlider:(CGFloat)sliderValue;
+ (CGFloat)numberOfRectsWithSize:(int)size andOptimalNumber:(CGFloat)numberOfRects;
+ (UIImage *)drawImage:(UIImage *)inputImage onImage:(UIImage *)originImage inRect:(CGRect)frame;
+ (UIImage *)imageFromColor:(UIColor *)color withRect:(CGRect)rect;
+ (UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect;
+ (NSString *)emojiSymbolForColor:(UIColor *)color;

+ (BOOL)isMagicEnabled; /** Показывает, включена ли анимация эмоджинации */
+ (void)setIsMagicEnabled:(BOOL)isEnabled;

+ (BOOL)isButtonAnimationEnabled; /** Показывает, нужна ли анимация у кнопок */
+ (void)setIsButtonAnimationEnabled:(BOOL)isEnabled;

+ (BOOL)isFireEnabled;
+ (void)setIsFireEnabled:(BOOL)isFireEnabled;

+ (BOOL)wasTutorialShown;
+ (void)setNeedShowTutorial:(BOOL)needShow;

// IPHONE 6
+ (CGFloat)properValueWithDefaultValue:(CGFloat)iphone6Value;
@end
