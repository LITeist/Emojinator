//
//  CIFilterHelper.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "CIFilterHelper.h"


@interface CIFilterHelper ()
@property (nonatomic, strong) CIContext *context;
@end

@implementation CIFilterHelper

+ (instancetype)shared
{
    static CIFilterHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [CIFilterHelper new];
    });
    return sharedHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _context = [CIContext contextWithOptions:nil];
    }
    return self;
}

- (UIImage *)applyMonoChromeWithRandColor:(UIImage *)uIImage
{
    @autoreleasepool
    {
        //  Convert UIColor to CIColor
        CGFloat randomRed = arc4random_uniform(255);
        CGFloat randomGreen = arc4random_uniform(255);
        CGFloat randomBlue = arc4random_uniform(255);
        CGColorRef colorRef = [UIColor colorWithRed:randomRed/255.0 green:randomGreen/255.0 blue:randomBlue/255.0 alpha:1].CGColor;
        NSString *colorString = [CIColor colorWithCGColor:colorRef].stringRepresentation;
        CIColor *coreColor = [CIColor colorWithString:colorString];
        
        //  Convert UIImage to CIImage
        CIImage *ciImage = [[CIImage alloc] initWithImage:uIImage];
        //  Set values for CIColorMonochrome Filter
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:@1.0 forKey:@"inputIntensity"];
        [filter setValue:coreColor forKey:@"inputColor"];
        
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyColorMatrixFilter:(UIImage *)uIImage withColorType:(ColorType)colorType andIntensity:(NSNumber *)intensity
{
    @autoreleasepool
    {
        CGFloat intenistyFloat = intensity.floatValue;
        //  Convert UIImage to CIImage
        CIImage *ciImage = [[CIImage alloc] initWithImage:uIImage];
        //  Set values for CIColorMonochrome Filter
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMatrix"];
        // Полученную интенсивность конвертить в cgfloat и вставлять в вектор
        [filter setValue:[CIVector vectorWithX:intenistyFloat Y:intenistyFloat Z:intenistyFloat W:0] forKey:[CIFilterHelper stringColorFromColorType:colorType]]; // 5
        [filter setValue:ciImage forKey:kCIInputImageKey];
        
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyPixellateFilterWithImage:(UIImage *)image andScale:(NSNumber *)scale
{
    // scaleNumber; Если размер 800, а scaleFactor - 80 - будет 10 квадратов пикселей
    // То есть идея алгоритма - делим от 15 прямоугольников до тех же 165, но берем только один пиксел
    @autoreleasepool
    {
        //  Convert UIImage to CIImage
        CGFloat scaleFloatValue = scale.floatValue;
        if (scaleFloatValue == 0)
            scaleFloatValue = 0.01;
        NSNumber *scaleNumber = [NSNumber numberWithFloat:scaleFloatValue * 20];//20
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:scaleNumber forKey:@"inputScale"];
        
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage); 
        return filteredImage;
    }
}

+ (NSString *)stringColorFromColorType:(ColorType)colorType
{
    switch (colorType)
    {
        case EmojiColorTypeRed:
            return @"inputRVector";
        case EmojiColorTypeBlue:
            return @"inputBVector";
        case EmojiColorTypeGreen:
            return @"inputGVector";
        default:
            break;
    }
    return nil;
}

- (UIImage *)applyTwirlFilterWithImage:(UIImage *)image andIntensity:(NSNumber *)intenisty
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CGFloat intensityFloatValue = intenisty.floatValue * 380;
        if (intensityFloatValue == 0)
            intensityFloatValue = 0.3;
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CITwirlDistortion"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:[CIVector vectorWithX:image.size.width/2 Y:image.size.height/2] forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:intensityFloatValue] forKey:@"inputRadius"];
        //[filter setValue:[NSNumber numberWithFloat:intensityFloatValue] forKey:@"inputAngle"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyImageWithTorusLensDistrotionFilterWithImage:(UIImage *)image andIntensity:(NSNumber *)intensity
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CITorusLensDistortion"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:[CIVector vectorWithX:image.size.width/2 Y:image.size.height/2] forKey:@"inputCenter"];
        [filter setValue:[NSNumber numberWithFloat:intensity.floatValue * 135] forKey:@"inputWidth"];
        [filter setValue:[NSNumber numberWithFloat:intensity.floatValue * 275] forKey:@"inputRadius"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyComicsEffectFilterWithImage:(UIImage *)image andIntensity:(NSNumber *)intensity
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CIComicEffect"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyShadowAdjustFilterWithImage:(UIImage *)image andIntensity:(NSNumber *)intensity
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:intensity forKey:@"inputHighlightAmount"];
        [filter setValue:intensity forKey:@"inputShadowAmount"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyColdFilterWithImage:(UIImage *)image andIntenisty:(NSNumber *)intensity
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CIGlassDistortion"];
        CIImage *textureImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"vawes.jpg"]];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:textureImage forKey:@"inputTexture"];
        [filter setValue:[CIVector vectorWithX:image.size.width/2 Y:image.size.height/2] forKey:@"inputCenter"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyBletFilterWithImage:(UIImage *)image andIntensity:(NSNumber *)intensity
{
    @autoreleasepool
    {
        // Вынести в отдельный метод с параметрами
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
        [filter setValue:ciImage forKey:kCIInputImageKey];
        [filter setValue:intensity forKey:@"inputHighlightAmount"];
        [filter setValue:intensity forKey:@"inputShadowAmount"];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)applyBleatFilterWithImage:(UIImage *)image
{
    @autoreleasepool
    {
        // TODO сделать возможность настройки
        CIImage *ciImage = [[CIImage alloc] initWithImage:image];
        CIFilter *firstFilter = [CIFilter filterWithName:@"CIBumpDistortionLinear"];
        [firstFilter setValue:ciImage forKey:kCIInputImageKey];
        [firstFilter setValue:@0.27 forKey:@"inputScale"];
        [firstFilter setValue:@395 forKey:@"inputRadius"];
        [firstFilter setValue:[CIVector vectorWithX:image.size.width/2 Y:image.size.height/3.7] forKey:@"inputCenter"];
        CIImage *result = [firstFilter valueForKey:kCIOutputImageKey];
        
        CIFilter *secondFilter = [CIFilter filterWithName:@"CIColorMatrix"];
        [secondFilter setValue:[CIVector vectorWithX:1 Y:1 Z:1 W:0] forKey:[CIFilterHelper stringColorFromColorType:EmojiColorTypeRed]];
        [secondFilter setValue:result forKey:kCIInputImageKey];
        result = [secondFilter valueForKey:kCIOutputImageKey];
        
        CGRect extent = [result extent];
        CGImageRef cgImage = [self.context createCGImage:result fromRect:extent];
        UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
        CFRelease(cgImage);
        return filteredImage;
    }
}

- (UIImage *)imageForFilterType:(FilterType)filterType withImage:(UIImage *)image andIntensity:(NSNumber *)intensity;
{
    switch (filterType)
    {
        case EmojiFilterTypeOne:
            return image;
        case EmojiFilterTypeTwo:
            return [self applyColorMatrixFilter:image withColorType:EmojiColorTypeRed andIntensity:intensity];
        case EmojiFilterTypeThree:
            return [self applyColorMatrixFilter:image withColorType:EmojiColorTypeGreen andIntensity:intensity];
        case EmojiFilterTypeFour:
            return [self applyColorMatrixFilter:image withColorType:EmojiColorTypeBlue andIntensity:intensity];
        case EmojiFilterTypeFive:
            return [self applyMonoChromeWithRandColor:image];
        case EmojiFilterTypeSix:
            return [self applyPixellateFilterWithImage:image andScale:intensity];
        case EmojiFilterTypeSeven:
            return [self applyTwirlFilterWithImage:image andIntensity:intensity];
        case EmojiFilterTypeEight:
            return [self applyImageWithTorusLensDistrotionFilterWithImage:image andIntensity:intensity];
        case EmojiFilterTypeComicEffect:
            return [self applyComicsEffectFilterWithImage:image andIntensity:intensity];
        case EmojiFilterTypeShadowAdjust:
            return [self applyShadowAdjustFilterWithImage:image andIntensity:intensity];
        case EmojiFilterTypeCold:
            return [self applyColdFilterWithImage:image andIntenisty:intensity];
        case EmojiFilterTypeBletEffect:
            return [self applyBleatFilterWithImage:image];
        default:
            break;
    }
    return [self applyMonoChromeWithRandColor:image];
}

@end
