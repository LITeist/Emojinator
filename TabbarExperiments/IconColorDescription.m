//
//  IconColorDescription.m
//  EmodjArt
//
//  Created by Alexey Levanov on 25.02.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "IconColorDescription.h"

static const CGFloat minDistanceForMainColor = 0.07; //0.11
static const CGFloat minDistanceForAverageColor = 0.10; //0.16

@interface IconColorDescription ()

@end


@implementation IconColorDescription

static NSDictionary* letterValues = nil;

+ (NSDictionary *)fireEmojiesDictionary
{
    static NSDictionary* fireEmojiesDictionary = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"fireJson" withExtension:@"bundle"];
        NSURL *url = [bundleURL URLByAppendingPathComponent:@"fire.json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *jsonDataDict = [NSDictionary new];
        jsonDataDict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions error:nil];
        fireEmojiesDictionary = [jsonDataDict valueForKey:@"fire"];
    });

    return fireEmojiesDictionary;
}

+ (NSArray *)colorsEmojiArray
{
    static NSArray* colorsArray = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"icons" withExtension:@"bundle"];
        NSURL *url = [bundleURL URLByAppendingPathComponent:@"icons.json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *jsonDataDict = [NSDictionary new];
        jsonDataDict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions error:nil];
        colorsArray = jsonDataDict[@"textColors"][@"colors"];
    });
    
    return colorsArray;
}


+ (NSArray *)emojiCodesArray
{
    static NSArray* emojiCodesArray = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"emojiCodes" withExtension:@"bundle"];
        NSURL *url = [bundleURL URLByAppendingPathComponent:@"emojiCodes.json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *jsonDataDict = [NSDictionary new];
        jsonDataDict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions error:nil];
        emojiCodesArray = jsonDataDict[@"colors"];
    });
    
    return emojiCodesArray;
}

+ (NSString *)imageNameForMainColor:(UIColor *)color withMinDistance:(CGFloat)minDistance
{
    if (minDistance < 0)
        minDistance = minDistanceForMainColor;
    else minDistance = minDistanceForMainColor + minDistance;
    
    const CGFloat *_components = CGColorGetComponents(color.CGColor);
    CGFloat baseRed     = _components[0];
    CGFloat baseGreen = _components[1];
    CGFloat baseBlue   = _components[2];
    
    NSMutableArray *arratOfMainColorsToCompare = [IconColorDescription mainColorsArray].mutableCopy;
    NSMutableArray *emojiNamesArray = [IconColorDescription imagesNameArray].mutableCopy;
    if ([EmojyHelper isFireEnabled])
    {
        arratOfMainColorsToCompare = [IconColorDescription arrayWithFireEmojiesArray:arratOfMainColorsToCompare forKey:@"mainColor"];
        emojiNamesArray = [IconColorDescription arrayWithFireEmojiesArray:emojiNamesArray forKey:@"iconName"];
    }
    for (int i=0; i<arratOfMainColorsToCompare.count; i++)
    {
        if (arratOfMainColorsToCompare.count > i)
        {
            UIColor *colorFromArray = arratOfMainColorsToCompare[i];
            const CGFloat *_components = CGColorGetComponents(colorFromArray.CGColor);
            CGFloat colorFromArrayRed     = _components[0];
            CGFloat colorFromArrayGreen = _components[1];
            CGFloat colorFromArrayBlue = _components[2];
            CGFloat distance = sqrtf(powf((baseRed - colorFromArrayRed), 2) + powf((baseGreen - colorFromArrayGreen), 2) + powf((baseBlue - colorFromArrayBlue), 2));
            if(distance <= minDistance)
            {
                if (emojiNamesArray.count > i)
                    return emojiNamesArray[i];
                else
                    return nil;
            }
        }
    }
    return nil;
}

+ (NSString *)imageNameForAvarageColor:(UIColor *)color withMinDistance:(CGFloat)minDistance
{
    if (minDistance < 0)
        minDistance = minDistanceForAverageColor;// 0.25
    else
        minDistance = minDistanceForAverageColor + minDistance;
    
    const CGFloat *_components = CGColorGetComponents(color.CGColor);
    CGFloat baseRed     = _components[0];
    CGFloat baseGreen = _components[1];
    CGFloat baseBlue   = _components[2];
    
    NSMutableArray *arratOfMainColorsToCompare = [IconColorDescription avarageColorsArray].mutableCopy;
    NSMutableArray *emojiNamesArray = [IconColorDescription imagesNameArray].mutableCopy;
    if ([EmojyHelper isFireEnabled])
    {
        arratOfMainColorsToCompare = [IconColorDescription arrayWithFireEmojiesArray:arratOfMainColorsToCompare forKey:@"averageColor"];
        emojiNamesArray = [IconColorDescription arrayWithFireEmojiesArray:emojiNamesArray forKey:@"iconName"];
    }
    for (int i=0; i<arratOfMainColorsToCompare.count; i++)
    {
        UIColor *colorFromArray = arratOfMainColorsToCompare[i];
        const CGFloat *_components = CGColorGetComponents(colorFromArray.CGColor);
        CGFloat colorFromArrayRed     = _components[0];
        CGFloat colorFromArrayGreen = _components[1];
        CGFloat colorFromArrayBlue = _components[2];
        CGFloat distance = sqrtf(powf((baseRed - colorFromArrayRed), 2) + powf((baseGreen - colorFromArrayGreen), 2) + powf((baseBlue - colorFromArrayBlue), 2));
        if(distance <= minDistance)
            return emojiNamesArray[i];
    }
    return nil;
}

// Упорядоченный массив главных цветов
+ (NSArray *)mainColorsArray
{
    return @[
             [UIColor colorWithRed:255/255.0 green:95/255.0 blue:120/255.0 alpha:1],
             [UIColor colorWithRed:192/255.0 green:144/255.0 blue:240/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:144/255.0 blue:192/255.0 alpha:1],
             [UIColor colorWithRed:192/255.0 green:168/255.0 blue:240/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:216/255.0 blue:96/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:216/255.0 blue:216/255.0 alpha:1],
             [UIColor colorWithRed:120/255.0 green:192/255.0 blue:72/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:144/255.0 blue:192/255.0 alpha:1],
             [UIColor colorWithRed:192/255.0 green:216/255.0 blue:216/255.0 alpha:1],
             [UIColor colorWithRed:96/255.0 green:192/255.0 blue:240/255.0 alpha:1],
             [UIColor colorWithRed:192/255.0 green:144/255.0 blue:240/255.0 alpha:1],
             [UIColor colorWithRed:120/255.0 green:96/255.0 blue:168/255.0 alpha:1],
             [UIColor colorWithRed:120/255.0 green:192/255.0 blue:72/255.0 alpha:1],
             [UIColor colorWithRed:96/255.0 green:144/255.0 blue:48/255.0 alpha:1],
             [UIColor colorWithRed:144/255.0 green:96/255.0 blue:96/255.0 alpha:1],
             [UIColor colorWithRed:192/255.0 green:144/255.0 blue:96/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:168/255.0 blue:216/255.0 alpha:1],
             [UIColor colorWithRed:120/255.0 green:192/255.0 blue:216/255.0 alpha:1],
             [UIColor colorWithRed:75/255.0 green:134/255.0 blue:200/255.0 alpha:1],
             [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1],
             [UIColor colorWithRed:48/255.0 green:96/255.0 blue:168/255.0 alpha:1],
             [UIColor colorWithRed:48/255.0 green:96/255.0 blue:168/255.0 alpha:1],
             [UIColor colorWithRed:144/255.0 green:96/255.0 blue:72/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:216/255.0 blue:216/255.0 alpha:1],
             [UIColor colorWithRed:240/255.0 green:72/255.0 blue:48/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:189/255.0 alpha:1],
             [UIColor colorWithRed:218/255.0 green:227/255.0 blue:234/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:189/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:221/255.0 blue:103/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:221/255.0 blue:103/255.0 alpha:1],
             [UIColor colorWithRed:131/255.0 green:191/255.0 blue:79/255.0 alpha:1],
             [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1],
             [UIColor colorWithRed:59/255.0 green:170/255.0 blue:207/255.0 alpha:1],
             [UIColor colorWithRed:117/255.0 green:214/255.0 blue:255/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:221/255.0 blue:103/255.0 alpha:1],
             [UIColor colorWithRed:77/255.0 green:83/255.0 blue:87/255.0 alpha:1],
             [UIColor colorWithRed:77/255.0 green:83/255.0 blue:87/255.0 alpha:1],
             [UIColor colorWithRed:218/255.0 green:222/255.0 blue:224/255.0 alpha:1],
             [UIColor colorWithRed:186/255.0 green:182/255.0 blue:182/255.0 alpha:1],
             [UIColor colorWithRed:216/255.0 green:223/255.0 blue:235/255.0 alpha:1],
             [UIColor colorWithRed:255/255.0 green:216/255.0 blue:48/255.0 alpha:1],
             [UIColor colorWithRed:240/255.0 green:72/255.0 blue:96/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:96/255.0 blue:144/255.0 alpha:1],
             [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1],
             [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1],// disc
             [UIColor colorWithRed:181/255.0 green:180/255.0 blue:179/255.0 alpha:1],// ball
             [UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1],// joystick
             [UIColor colorWithRed:254/255.0 green:216/255.0 blue:99/255.0 alpha:1],// cry 255,216,96
             [UIColor colorWithRed:240/255.0 green:72/255.0 blue:144/255.0 alpha:1], // flour -240,72,144
             [UIColor colorWithRed:255/255.0 green:24/255.0 blue:72/255.0 alpha:1],// china - 255,24,72
             [UIColor colorWithRed:240/255.0 green:72/255.0 blue:144/255.0 alpha:1],// Beating_Pink_Heart_Emoji 240,72,144
             [UIColor colorWithRed:24/255.0 green:144/255.0 blue:48/255.0 alpha:1],//FROG_emoji_icon_png (24,144,48)
             [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1],// (216,216,216) Ghost_Emoji
             [UIColor colorWithRed:240/255.0 green:96/255.0 blue:48/255.0 alpha:1],//Very_Angry_Emoji 240,96,48
             [UIColor colorWithRed:240/255.0 green:192/255.0 blue:48/255.0 alpha:1],// alert 240,192,48
             [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1],// angel 240,240,240
             [UIColor colorWithRed:168/255.0 green:24/255.0 blue:48/255.0 alpha:1],// 168,24,48 bag
             [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1],// 24,24,24 bomb
             [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1],// bouling 120,120,120
             [UIColor colorWithRed:216/255.0 green:48/255.0 blue:48/255.0 alpha:1], // britain 216,48,48
             [UIColor colorWithRed:216/255.0 green:168/255.0 blue:96/255.0 alpha:1], //216,168,96 camel
             [UIColor colorWithRed:168/255.0 green:168/255.0 blue:144/255.0 alpha:1],// 168,168,144 cycle
             [UIColor colorWithRed:220/255.0 green:218/255.0 blue:202/255.0 alpha:1],// hand 1
             [UIColor colorWithRed:238/255.0 green:217/255.0 blue:185/255.0 alpha:1],//nose
             [UIColor colorWithRed:238/255.0 green:144/255.0 blue:48/255.0 alpha:1], // orange 240,144,48
             ];
    return nil;
}

// Упорядоченный массив средних цветов
+ (NSArray *)avarageColorsArray
{
    /* Где-то потерялась картинка и лишний цвет */
    return @[
             [UIColor colorWithRed:154/255.0 green:54/255.0 blue:72/255.0 alpha:1],
             [UIColor colorWithRed:145/255.0 green:113/255.0 blue:172/255.0 alpha:1],
             [UIColor colorWithRed:78/255.0 green:127/255.0 blue:156/255.0 alpha:1],
             [UIColor colorWithRed:114/255.0 green:94/255.0 blue:110/255.0 alpha:1],
             [UIColor colorWithRed:171/255.0 green:148/255.0 blue:68/255.0 alpha:1],
             [UIColor colorWithRed:73/255.0 green:154/255.0 blue:159/255.0 alpha:1],
             [UIColor colorWithRed:85/255.0 green:85/255.0 blue:35/255.0 alpha:1],
             [UIColor colorWithRed:63/255.0 green:109/255.0 blue:143/255.0 alpha:1],
             [UIColor colorWithRed:80/255.0 green:104/255.0 blue:78/255.0 alpha:1],
             [UIColor colorWithRed:52/255.0 green:104/255.0 blue:125/255.0 alpha:1],
             [UIColor colorWithRed:146/255.0 green:110/255.0 blue:166/255.0 alpha:1],
             [UIColor colorWithRed:104/255.0 green:86/255.0 blue:127/255.0 alpha:1],
             [UIColor colorWithRed:69/255.0 green:101/255.0 blue:40/255.0 alpha:1],
             [UIColor colorWithRed:92/255.0 green:119/255.0 blue:61/255.0 alpha:1],
             [UIColor colorWithRed:73/255.0 green:90/255.0 blue:103/255.0 alpha:1],
             [UIColor colorWithRed:114/255.0 green:86/255.0 blue:64/255.0 alpha:1],
             [UIColor colorWithRed:42/255.0 green:112/255.0 blue:148/255.0 alpha:1],
             [UIColor colorWithRed:44/255.0 green:86/255.0 blue:106/255.0 alpha:1],
             [UIColor colorWithRed:42/255.0 green:71/255.0 blue:88/255.0 alpha:1],
             [UIColor colorWithRed:58/255.0 green:58/255.0 blue:59/255.0 alpha:1],
             [UIColor colorWithRed:69/255.0 green:83/255.0 blue:117/255.0 alpha:1],
             [UIColor colorWithRed:39/255.0 green:72/255.0 blue:108/255.0 alpha:1],
             [UIColor colorWithRed:96/255.0 green:76/255.0 blue:64/255.0 alpha:1],
             [UIColor colorWithRed:76/255.0 green:154/255.0 blue:159/255.0 alpha:1],
             [UIColor colorWithRed:182/255.0 green:108/255.0 blue:32/255.0 alpha:1],
             [UIColor colorWithRed:135/255.0 green:116/255.0 blue:97/255.0 alpha:1],
             [UIColor colorWithRed:111/255.0 green:116/255.0 blue:120/255.0 alpha:1],
             [UIColor colorWithRed:148/255.0 green:128/255.0 blue:107/255.0 alpha:1],
             [UIColor colorWithRed:131/255.0 green:116/255.0 blue:62/255.0 alpha:1],
             [UIColor colorWithRed:135/255.0 green:113/255.0 blue:53/255.0 alpha:1],
             [UIColor colorWithRed:106/255.0 green:142/255.0 blue:70/255.0 alpha:1],
             [UIColor colorWithRed:60/255.0 green:51/255.0 blue:55/255.0 alpha:1],
             [UIColor colorWithRed:24/255.0 green:49/255.0 blue:57/255.0 alpha:1],
             [UIColor colorWithRed:44/255.0 green:81/255.0 blue:97/255.0 alpha:1],
             [UIColor colorWithRed:96/255.0 green:111/255.0 blue:99/255.0 alpha:1],
             [UIColor colorWithRed:27/255.0 green:29/255.0 blue:30/255.0 alpha:1],
             [UIColor colorWithRed:158/255.0 green:127/255.0 blue:129/255.0 alpha:1],
             [UIColor colorWithRed:115/255.0 green:112/255.0 blue:112/255.0 alpha:1],
             [UIColor colorWithRed:117/255.0 green:121/255.0 blue:127/255.0 alpha:1],
             [UIColor colorWithRed:103/255.0 green:103/255.0 blue:70/255.0 alpha:1],
             [UIColor colorWithRed:75/255.0 green:43/255.0 blue:47/255.0 alpha:1],
             [UIColor colorWithRed:109/255.0 green:135/255.0 blue:122/255.0 alpha:1],
             [UIColor colorWithRed:86/255.0 green:90/255.0 blue:89/255.0 alpha:1],
             [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1],// disc 153, 153, 153
             [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1],// ball
             [UIColor colorWithRed:28/255.0 green:27/255.0 blue:25/255.0 alpha:1],// joystick 28, 27, 25
             [UIColor colorWithRed:155/255.0 green:144/255.0 blue:88/255.0 alpha:1],// cry 155, 144, 88
             [UIColor colorWithRed:135/255.0 green:43/255.0 blue:77/255.0 alpha:1], // flour 135, 43, 77
             [UIColor colorWithRed:114/255.0 green:31/255.0 blue:28/255.0 alpha:1], //china 114, 31, 28
             [UIColor colorWithRed:78/255.0 green:32/255.0 blue:52/255.0 alpha:1], // Beating_Pink_Heart_Emoji 78, 32, 52
             [UIColor colorWithRed:27/255.0 green:91/255.0 blue:32/255.0 alpha:1],//FROG_emoji_icon_png 27, 91, 32
             [UIColor colorWithRed:123/255.0 green:117/255.0 blue:118/255.0 alpha:1],//Ghost_Emoji 123, 117, 118
             [UIColor colorWithRed:158/255.0 green:74/255.0 blue:41/255.0 alpha:1],//Very_Angry_Emoji (158, 74, 41
             [UIColor colorWithRed:100/255.0 green:86/255.0 blue:26/255.0 alpha:1],//alert 100, 86, 26
             [UIColor colorWithRed:93/255.0 green:91/255.0 blue:85/255.0 alpha:1],//93, 91, 85 angel
             [UIColor colorWithRed:97/255.0 green:25/255.0 blue:34/255.0 alpha:1],// 97, 25, 34 bag
             [UIColor colorWithRed:45/255.0 green:39/255.0 blue:42/255.0 alpha:1],// 52, 46, 47 bomb
             [UIColor colorWithRed:55/255.0 green:53/255.0 blue:53/255.0 alpha:1],// (55, 53, 53 bouling
             [UIColor colorWithRed:92/255.0 green:68/255.0 blue:82/255.0 alpha:1], // 92, 68, 82 britain
             [UIColor colorWithRed:69/255.0 green:52/255.0 blue:31/255.0 alpha:1],// camel 69, 52, 31
             [UIColor colorWithRed:125/255.0 green:102/255.0 blue:75/255.0 alpha:1],// 125, 102, 75 cycle
             [UIColor colorWithRed:220/255.0 green:218/255.0 blue:202/255.0 alpha:1],// hand 1
             [UIColor colorWithRed:238/255.0 green:217/255.0 blue:185/255.0 alpha:1],//nose
             [UIColor colorWithRed:132/255.0 green:82/255.0 blue:31/255.0 alpha:1] // orange 132, 82, 31
             ];
    return nil;
}

+ (NSArray *)imagesNameArray
{
    return @[@"heart", @"zodiak1", @"moneyBlue", @"noWomen", @"smile", @"letterA", @"selfieGreen", @"zodiak2", @"snowboarding", @"heartBlue", @"discIcon", @"zodiak3", @"clever", @"zodiak4", @"darkMuslim", @"potato", @"tShirt", @"book", @"carFront", @"badminton", @"flag", @"euroFlag", @"shit", @"cran", @"fries", @"armWhite", @"bank", @"fistWhite", @"highFiveYellow", @"armYellow", @"addidas", @"hat", @"headphones", @"raindrop", @"swimmingWhite", @"nota", @"kittyLove", @"dead", @"mouse", @"ukrain", @"moto", @"atm", @"target", @"disc", @"ball", @"joystick", @"cry", @"flour", @"china", @"Beating_Pink_Heart_Emoji", @"FROG_emoji_icon_png", @"Ghost_Emoji", @"Very_Angry_Emoji", @"alert", @"angel" ,@"bag", @"bomb", @"bouling", @"britain", @"camel", @"cycle", @"hand1", @"nose", @"orange"];
}
// Имя картинки под индексом массива
+ (NSString *)imageNameWithIndex:(int)index
{
    switch (index) {
        case 0:
            return @"heart";
            break;
        case 1:
            return @"zodiak1";
            break;
        case 2:
            return @"moneyBlue";
            break;
        case 3:
            return @"noWomen";
            break;
        case 4:
            return @"smile";
            break;
        case 5:
            return @"letterA";
            break;
        case 6:
            return @"selfieGreen";
            break;
        case 7:
            return @"zodiak2";
            break;
        case 8:
            return @"snowboarding";
            break;
        case 9:
            return @"heartBlue";
            break;
        case 10:
            return @"discIcon";
            break;
        case 11:
            return @"zodiak3";//?
            break;
        case 12:
            return @"clever";
            break;
        case 13:
            return @"zodiak4";
            break;
        case 14:
            return @"darkMuslim";
            break;
        case 15:
            return @"potato";
            break;
        case 16:
            return @"tShirt";
        case 17:
            return @"book";
        case 18:
            return @"carFront";
            break;
        case 19:
            return @"badminton";
            break;
        case 20:
            return @"flag1";
            break;
        case 21:
            return @"euroFlag";
            break;
        case 22:
            return @"shit";
            break;
        case 23:
            return @"cran";
            break;
        case 24:
            return @"fries";
            break;
        case 25:
            return @"armWhite";
            break;
        case 26:
            return @"bank";
            break;
        case 27:
            return @"fistWhite";
            break;
        case 28:
            return @"highFiveYellow";
            break;
        case 29:
            return @"armYellow";
            break;
        case 30:
            return @"addidas";
            break;
        case 31:
            return @"hat";
            break;
        case 32:
            return @"headphones";
            break;
        case 33:
            return @"raindrop";
        case 34:
            return @"swimmingWhite";
        case 35:
            return @"nota";
        case 36:
            return @"kittyLove";
        case 37:
            return @"dead";
        case 38:
            return @"mouse";
        case 39:
            return @"ukrain";
        case 40:
            return @"moto";
        case 41:
            return @"atm";
        case 42:
            return @"target";
        case 43:
            return @"disc";
        case 44:
            return @"ball";
        case 45:
            return @"joystick";
        case 46:
            return @"cry";
        case 47:
            return @"flour";
        case 48:
            return @"china";
        case 49:
            return @"Beating_Pink_Heart_Emoji";
        case 50:
            return @"FROG_emoji_icon_png";
        case 51:
            return @"Ghost_Emoji";
        case 52:
            return @"Very_Angry_Emoji";
        case 53:
            return @"alert";
        case 54:
            return @"angel";
        case 55:
            return @"bag";
        case 56:
            return @"bomb";
        case 57:
            return @"bouling";
        case 58:
            return @"britain";
        case 59:
            return @"camel";
        case 60:
            return @"cycle";
        case 61:
            return @"hand1";
        case 62:
            return @"nose";
        case 63:
            return @"orange";
        default:
            break;
    }
    return nil;
}

+ (NSString *)emojiWithIndex:(int)index
{
    switch (index) {
        case 0:
            return @"❤️";
            break;
        case 1:
            return @"♓";
            break;
        case 2:
            return @"📘";
            break;
        case 3:
            return @"🙅‍♀️";
            break;
        case 4:
            return @"😉";
            break;
        case 5:
            return @"Ⓜ️";
            break;
        case 6:
            return @"🍏";
            break;
        case 7:
            return @"🏧";
            break;
        case 8:
            return @"🏔️";
            break;
        case 9:
            return @"💙";
            break;
        case 10:
            return @"💟";
            break;
        case 11:
            return @"💜";
            break;
        case 12:
            return @"🍀";
            break;
        case 13:
            return @"zodiak4";
            break;
        case 14:
            return @"👳🏿";
            break;
        case 15:
            return @"🥔";
            break;
        case 16:
            return @"👕";
            break;
        case 17:
            return @"📘";
            break;
        case 18:
            return @"🚎";
            break;
        case 19:
            return @"🏸";
            break;
        case 20:
            return @"flag";
            break;
        case 21:
            return @"euroFlag";
            break;
        case 22:
            return @"shit";
            break;
        case 23:
            return @"cran";
            break;
        case 24:
            return @"fries";
            break;
        case 25:
            return @"armWhite";
            break;
        case 26:
            return @"bank";
            break;
        case 27:
            return @"fistWhite";
            break;
        case 28:
            return @"highFiveYellow";
            break;
        case 29:
            return @"armYellow";
            break;
        case 30:
            return @"addidas";
            break;
        case 31:
            return @"hat";
            break;
        case 32:
            return @"headphones";
            break;
        case 33:
            return @"raindrop";
            break;
        case 34:
            return @"swimmingWhite";
            break;
        case 35:
            return @"nota";
            break;
        case 36:
            return @"kittyLove";
            break;
        case 37:
            return @"dead";
            break;
        case 38:
            return @"mouse";
            break;
        case 39:
            return @"ukrain";
            break;
        case 40:
            return @"moto";
            break;
        case 41:
            return @"atm";
            break;
        case 42:
            return @"target";
            break;
        case 43:
            return @"disc";
            break;
        case 44:
            return @"ball";
            break;
        case 45:
            return @"joystick";
            break;
        case 46:
            return @"cry";
            break;
        case 47:
            return @"flour";
            break;
        case 48:
            return @"china";
            break;
        case 49:
            return @"Beating_Pink_Heart_Emoji";
            break;
        case 50:
            return @"🐸";
            break;
        case 51:
            return @"Ghost_Emoji";
            break;
        case 52:
            return @"Very_Angry_Emoji";
            break;
        case 53:
            return @"alert";
        case 54:
            return @"angel";
        case 55:
            return @"bag";
        case 56:
            return @"bomb";
        case 57:
            return @"bouling";
        case 58:
            return @"britain";
        case 59:
            return @"camel";
        case 60:
            return @"cycle";
        case 61:
            return @"hand1";
        case 62:
            return @"nose";
        case 63:
            return @"orange";
        default:
            break;
    }
    return nil;
}

+ (NSString *)stringFromFile
{
    static NSString *_stringFromFile;
    if (!_stringFromFile)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"txt"];
        _stringFromFile = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    
    return _stringFromFile;
}

+ (NSArray *)avarageColorArray
{
    static NSMutableArray *_avarageColorArray;
    if (!_avarageColorArray)
    {
        _avarageColorArray = [NSMutableArray new];
        NSArray *allColorArray = [IconColorDescription allColorsArray];
        for (int i=0; i < allColorArray.count; i++)
        {
            if (i % 2 != 0)
            {
                // Нечетные
                [_avarageColorArray addObject:allColorArray[i]];
            }
        }
    }
    
    return _avarageColorArray.copy;
}

+ (NSArray *)mainColorArray
{
    static NSMutableArray *_mainColorArray;
    if (!_mainColorArray)
    {
        _mainColorArray = [NSMutableArray new];
        NSArray *allColorArray = [IconColorDescription allColorsArray];
        for (int i=0; i < allColorArray.count; i++)
        {
            if (i % 2 == 0)
            {
                // Четные
                [_mainColorArray addObject:allColorArray[i]];
            }
        }
    }
    
    return _mainColorArray.copy;
}

+ (NSArray *)allColorsArray
{
    static NSArray *_allColorArray;
    if (!_allColorArray)
    {
        NSString *allFilesString = [self stringFromFile];
        allFilesString = [allFilesString stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        allFilesString = [allFilesString stringByReplacingOccurrencesOfString:@"  " withString:@","];
        allFilesString = [allFilesString stringByReplacingOccurrencesOfString:@" " withString:@""];
        _allColorArray = [allFilesString componentsSeparatedByString:@","];
    }
    
    return _allColorArray;
}

+ (UIColor *)colorFromHex:(NSString *)hexString
{
    return [IconColorDescription colorWithHexString:hexString];
}

+ (UIColor *)colorWithHexString:(NSString *)str_HEX
{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (NSString *)imageNameFromFileWithIndex:(int)index
{
    return [NSString stringWithFormat:@"%d", index];
}

/* TODO проставить */
+ (NSMutableArray *)arrayWithFireEmojiesArray:(NSMutableArray *)arrayOfMainColorsToCompare forKey:(NSString *)key
{
    NSDictionary *fireEmojiDictionary = [IconColorDescription fireEmojiesDictionary];
    NSArray *fireColors = fireEmojiDictionary[@"colors"];
    for (int i=0; i<fireColors.count; i++)
    {
        NSDictionary *colorObjectDictionary = fireColors[i];
        NSString *currentColorString = colorObjectDictionary[key];
        if (![key isEqualToString:@"iconName"])
        {
            NSArray* arrayOfColorStrings = [currentColorString componentsSeparatedByString:@","];
            CGFloat redColorComponent = [arrayOfColorStrings[0] floatValue];
            CGFloat greenColorComponent = [arrayOfColorStrings[1] floatValue];
            CGFloat blueColorComponent = [arrayOfColorStrings[2] floatValue];
            UIColor *currentColor = [UIColor colorWithRed:redColorComponent/255.0 green:greenColorComponent/255.0 blue:blueColorComponent/255.0 alpha:1];
            [arrayOfMainColorsToCompare addObject:currentColor];
        }
        else
        {
            [arrayOfMainColorsToCompare addObject:currentColorString];
        }
    }
    return [arrayOfMainColorsToCompare copy];
}

+ (NSString *)imageNameForAvarageColor:(UIColor *)color withMinDistance:(CGFloat)minDistance forText:(BOOL)isText
{
    if (minDistance <= 0)
        minDistance = 0.03;
    else minDistance = minDistance + 0.01;
    
    const CGFloat *_components = CGColorGetComponents(color.CGColor);
    CGFloat baseRed     = _components[0];
    CGFloat baseGreen = _components[1];
    CGFloat baseBlue   = _components[2];
    
    /* Вот тут нужно распарсить и показывать главный цвет */
    NSMutableArray *arrayOfAllColorsToCompare = [IconColorDescription colorsEmojiArray].mutableCopy;
//    NSMutableArray *emojiNamesArray = [IconColorDescription imagesNameArray].mutableCopy;
    for (int i=0; i<203; i++)//arrayOfAllColorsToCompare.count.count, пока - 203
    {
        NSArray* arrayAtString = [arrayOfAllColorsToCompare[i] componentsSeparatedByString:@"|"];
        NSString *averageIconColor = arrayAtString.lastObject; //  На самом деле берем средний цвет
        NSArray *colorComponents = [averageIconColor componentsSeparatedByString:@","];
        CGFloat colorFromArrayRed = [colorComponents[0] floatValue];
        CGFloat colorFromArrayGreen = [colorComponents[1] floatValue];
        CGFloat colorFromArrayBlue = [colorComponents[2] floatValue];
        CGFloat distance = sqrtf(powf((baseRed - colorFromArrayRed), 2) + powf((baseGreen - colorFromArrayGreen), 2) + powf((baseBlue - colorFromArrayBlue), 2));
        if(distance <= minDistance)
            return [NSString stringWithFormat:@"%d.png", i+1];
    }
    return nil;

}

+ (NSString *)emojiCodeForImageName:(NSString *)imageName
{
    if (imageName)
    {
        NSArray *emojiCodes = [IconColorDescription emojiCodesArray];
        NSArray *arrayAtString = [imageName componentsSeparatedByString:@"."];
        NSInteger numberInt = [arrayAtString.firstObject integerValue];
        if (numberInt < emojiCodes.count)
        {
            if (numberInt > 1)
            {
//                NSLog(@"%@", [IconColorDescription emojiStringFromUnicodeString:emojiCodes[numberInt-1]]);
                return [IconColorDescription emojiStringFromUnicodeString:emojiCodes[numberInt-1] shouldSubstring:YES];
            }
            return @"";
        }
    }
    return @"";
}

+ (NSString *)emojiStringFromUnicodeString:(NSString *)unicodeString shouldSubstring:(BOOL)shouldSubstring;
{
    // отрезаем первые два символа
//    if (shouldSubstring)
//        unicodeString = [unicodeString substringFromIndex:2];
    unicodeString = [unicodeString stringByReplacingOccurrencesOfString:@"U+" withString:@""];
    
    unsigned unicodeInt = 0;
    if (unicodeString.length)
    NSLog(@"Длинна строки - %@", unicodeString);
    //convert unicode character to int
    [[NSScanner scannerWithString:unicodeString] scanHexInt:&unicodeInt];
    
    //convert this integer to a char array (bytes)
    char chars[4];
    int len = 4;
    
    chars[0] = (unicodeInt >> 24) & (1 << 24) - 1;
    chars[1] = (unicodeInt >> 16) & (1 << 16) - 1;
    chars[2] = (unicodeInt >> 8) & (1 << 8) - 1;
    chars[3] = unicodeInt & (1 << 8) - 1;
    
    
    NSString *emojiString = [[NSString alloc] initWithBytes:chars
                                                       length:len
                                                     encoding:NSUTF32StringEncoding];
    return emojiString;
}

@end
