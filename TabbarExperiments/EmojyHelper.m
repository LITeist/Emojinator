//
//  EmojyHelper.m
//  EmodjArt
//
//  Created by Alexey Levanov on 23.02.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EmojyHelper.h"
#import "IconColorDescription.h"
#import "EmojiTextManager.h"
#import "Math.h"


//static const CGFloat numberOfRects = 50;
// от 15 до 150
@implementation EmojyHelper

+ (UIImage *)imageWithAvarageColorRectsForImage:(UIImage *)image withSliderValue:(CGFloat)floatSliderValue forText:(BOOL)forText
{
    CGFloat numberOfRects = -1;
    CGFloat optimalNumberOfRects = [EmojyHelper optimalRectNumberFromSlider:floatSliderValue];
    CGFloat minimumSize = (image.size.width > image.size.height) ? image.size.width : image.size.height;
    numberOfRects = [self numberOfRectsWithSize:minimumSize andOptimalNumber:optimalNumberOfRects];
    float rectSize = minimumSize/numberOfRects;
    for (float i = 0; i <= minimumSize - rectSize; i = i + rectSize)
        for (float j = 0; j <= minimumSize - rectSize; j = j + rectSize)
        {
  @autoreleasepool
            {
                CGFloat minDistance = 0;
                UIColor *averageColor = [EmojyHelper averageColorForImage:[EmojyHelper cropImage:image withRect:CGRectMake(i, j, rectSize, rectSize)]];
                UIImage *imageFromColor = [EmojyHelper imageFromColor:averageColor withRect:CGRectMake(0, 0, rectSize, rectSize)];
                UIImage *emojiFromColor = [EmojyHelper emodjiForColor:averageColor withRect:CGRectMake(0, 0, rectSize, rectSize) minDistance:minDistance forText:forText];
				float step = 0.02;//0.07
                while (!emojiFromColor)
                {
                    emojiFromColor = [EmojyHelper emodjiForColor:averageColor withRect:CGRectMake(0, 0, rectSize, rectSize)minDistance:minDistance forText:forText];
					minDistance = minDistance + step;
                };
                // Сначала делаем подложку среднего цвета (попробуем отключить подложку для текста)
				// TODO вот тут можно отменить отрисовку среднего цвета
                image = [EmojyHelper drawImage:imageFromColor onImage:image inRect:CGRectMake(i, j, rectSize, rectSize)];
                // Затем поверх нее рисуем иконку
                image = [EmojyHelper drawImage:emojiFromColor onImage:image inRect:CGRectMake(i, j, rectSize, rectSize)];
            };
        }
    return image;
}

+ (UIImage *)emojiImageFromImage:(UIImage *)image withSliderValue:(CGFloat)floatSliderValue anRect:(CGRect)rect forText:(BOOL)forText
{
    UIImage *returnImage = [UIImage new];
    @autoreleasepool
    {
        CGFloat minDistance = 0;
        UIColor *averageColor = [EmojyHelper averageColorForImage:[EmojyHelper cropImage:image withRect:rect]];
        UIImage *imageFromColor = [EmojyHelper imageFromColor:forText ? [UIColor whiteColor] : averageColor withRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        UIImage *emojiFromColor = [EmojyHelper emodjiForColor:averageColor withRect:CGRectMake(0, 0, rect.size.width, rect.size.height) minDistance:minDistance forText:forText];
		float step = 0.01;
        while (!emojiFromColor)
        {
            emojiFromColor = [EmojyHelper emodjiForColor:averageColor withRect:CGRectMake(0, 0, rect.size.width, rect.size.height) minDistance:minDistance forText:forText];
			minDistance = minDistance + step;
        };
		//
        returnImage = [EmojyHelper drawImage:emojiFromColor onImage:imageFromColor inRect:CGRectMake(0, 0, rect.size.width,     rect.size.height)];
    };
    return returnImage;
}

+ (CGFloat)optimalRectNumberFromSlider:(CGFloat)sliderValue
{
   return 15 + 60*sliderValue;
}

+ (UIColor *)averageColorForImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] != 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

+ (UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect {
    
    rect = CGRectMake(rect.origin.x * image.scale,
                      rect.origin.y * image.scale,
                      rect.size.width * image.scale,
                      rect.size.height * image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:image.scale
                                    orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

+ (UIImage *)drawImage:(UIImage *)inputImage onImage:(UIImage *)originImage inRect:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, originImage.scale);
    [originImage drawInRect:CGRectMake(0.0, 0.0, originImage.size.width, originImage.size.height)];
    [inputImage drawInRect:frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)emodjiForColor:(UIColor *)color withRect:(CGRect)rect minDistance:(CGFloat)minDistance forText:(BOOL)forText
{
    NSString *averageEmojiImageName;
    if (forText)
    {
        averageEmojiImageName = [IconColorDescription imageNameForAvarageColor:color withMinDistance:minDistance forText:YES];
//        NSString *emojiCode = [IconColorDescription emojiCodeForImageName:averageEmojiImageName];
        while (!averageEmojiImageName)
        {
            minDistance = minDistance + 0.01;
            averageEmojiImageName = [IconColorDescription imageNameForAvarageColor:color withMinDistance:minDistance forText:YES];
        }
		// TODO нужен переход на новую строку
		//
        [[EmojiTextManager shared] addString:averageEmojiImageName];
    }
    else
    {
        averageEmojiImageName = [IconColorDescription imageNameForAvarageColor:color withMinDistance:minDistance] ? : [IconColorDescription imageNameForMainColor:color withMinDistance:minDistance];
    }
    if (averageEmojiImageName)
    {
        /* Тут с точкой отрисовки могут быть проблемы */
        UIImage *returnEmojiImage = [UIImage imageNamed:averageEmojiImageName];
        return [EmojyHelper imageWithImage:returnEmojiImage scaledToWidth:rect.size.width];
    }
    return nil;
}


+ (UIImage *)imageFromColor:(UIColor *)color withRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (CGFloat)numberOfRectsWithSize:(int)size andOptimalNumber:(CGFloat)numberOfRects
{
    if (size < numberOfRects)
    {
        if (size%2 == 0)
            return size;
        else return size-1;
    }
    else return numberOfRects;
}

//  scale картинки

+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)isMagicEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"isMagicEnabled"];
}

+ (void)setIsMagicEnabled:(BOOL)isEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEnabled forKey:@"isMagicEnabled"];
    [defaults synchronize];
}

+ (BOOL)isButtonAnimationEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"isButtonAnimationEnabled"];
}

+ (void)setIsButtonAnimationEnabled:(BOOL)isEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEnabled forKey:@"isButtonAnimationEnabled"];
    [defaults synchronize];
}

+ (BOOL)isFireEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"isFireBought"];
}

+ (void)setIsFireEnabled:(BOOL)isFireEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isFireEnabled forKey:@"isFireBought"];
    [defaults synchronize];
}

+ (BOOL)wasTutorialShown
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"tutorialWasShown"];
}

+ (void)setNeedShowTutorial:(BOOL)needShow
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:!needShow forKey:@"tutorialWasShown"];
    [defaults synchronize];
}

+ (CGFloat)properValueWithDefaultValue:(CGFloat)iphone6Value
{
    if ([UIScreen mainScreen].bounds.size.width <= 320)
        return iphone6Value * 0.75;
    else if ([UIScreen mainScreen].bounds.size.width <= 375)
        return iphone6Value;
    else
        return iphone6Value * 1.2;
}

@end
