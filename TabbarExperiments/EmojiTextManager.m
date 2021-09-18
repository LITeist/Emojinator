//
//  EmojiTextManager.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 05.07.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EmojiTextManager.h"
#import "IconColorDescription.h"


@implementation EmojiTextManager
{
    NSString *emojiString;
}

+ (instancetype)shared
{
    static EmojiTextManager *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [EmojiTextManager new];
    });
    return sharedHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        emojiString = @"";
    }
    return self;
}

- (void)addString:(NSString *)string
{
    if (emojiString.length == 0)
        emojiString = string;
    else
        emojiString = [NSString stringWithFormat:@"%@;%@",emojiString,string];
}

- (NSString *)returnFormattedString
{
    NSArray *arrayAtString = [emojiString componentsSeparatedByString:@";"];
    NSString *newEmojiString;
//    NSString *invertedString;
    // TODO вот тут переворачивать
//    for (int i=0; i<12; i++)
//        for (int j=i; j<12*12; j=j+12)
//        {
//            if (!invertedString)
//                invertedString = arrayAtString[j];
//            else
//                invertedString = [NSString stringWithFormat:@"%@;%@",invertedString, arrayAtString[j]];
//        }
//    NSArray *invertedArray = [invertedString componentsSeparatedByString:@";"];
    for (int i=0; i<arrayAtString.count; i++)
    {
        if (!newEmojiString)
            newEmojiString = [IconColorDescription emojiCodeForImageName:arrayAtString[i]];
        else
            newEmojiString = [NSString stringWithFormat:@"%@%@", newEmojiString, [IconColorDescription emojiCodeForImageName:arrayAtString[i]]];
    }
    return newEmojiString;
}

- (void)clearString
{
    emojiString = @"";
}

@end
