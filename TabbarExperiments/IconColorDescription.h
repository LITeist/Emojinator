//
//  IconColorDescription.h
//  EmodjArt
//
//  Created by Alexey Levanov on 25.02.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EmojyHelper.h"


@interface IconColorDescription : NSObject

+ (NSString *)imageNameForMainColor:(UIColor *)color withMinDistance:(CGFloat)minDistance;
+ (NSString *)imageNameForAvarageColor:(UIColor *)color withMinDistance:(CGFloat)minDistance;

// Для текста
+ (NSString *)imageNameForAvarageColor:(UIColor *)color withMinDistance:(CGFloat)minDistance forText:(BOOL)isText;
+ (NSString *)emojiCodeForImageName:(NSString *)imageName;
+ (NSString *)emojiStringFromUnicodeString:(NSString *)unicodeString shouldSubstring:(BOOL)shouldSubstring;

@end
