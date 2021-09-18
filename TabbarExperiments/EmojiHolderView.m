//
//  EmojiHolderView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 04.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EmojiHolderView.h"


static const CGFloat EMJViewHeight = 55;
static const CGFloat EMJEMojiWidth = 35;

@implementation EmojiHolderView

- (instancetype)initWithInAppType:(InAppType)inAppType andWidth:(CGFloat)width
{
    self = [super initWithFrame:CGRectMake(20, 15, width - 20 * 2, EMJViewHeight)];
    if (self)
    {        
        self.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        self.layer.cornerRadius = 45/2;
        CGFloat widthForEmojies = width - 20 * 2 - 45/2;
        CGFloat numberOfEmoji = fabs(widthForEmojies/(EMJEMojiWidth + 15));
        NSInteger realNumberOfEmojies = numberOfEmoji;
        CGFloat gapBetweenEmoji = (widthForEmojies - realNumberOfEmojies*EMJEMojiWidth)/realNumberOfEmojies;
        
        CGFloat xOffset = gapBetweenEmoji;
        NSArray *imagesArray = [self imageNamesForType:inAppType];
        for (int i=0; i<realNumberOfEmojies; i++)
        {
            UIImageView *emjImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xOffset, 10, EMJEMojiWidth, EMJEMojiWidth)];
            if (imagesArray.count > i)
                emjImageView.image = [UIImage imageNamed:imagesArray[i]];
            [self addSubview:emjImageView];
            xOffset = xOffset + gapBetweenEmoji + EMJEMojiWidth;
        }
    }
    return self;
}

- (NSArray *)imageNamesForType:(InAppType)inAppType
{
    NSMutableArray *imageNamesArray = [NSMutableArray new];
    switch (inAppType)
    {
        case EMJInAppTypeAdds:
            imageNamesArray = @[@"add1", @"add2", @"add3", @"add4", @"add5", @"add6"].copy;
            break;
        case EMJInAppTypeSpace:
            imageNamesArray = @[@"star1", @"star2", @"star3", @"star4", @"star5", @"star6"].copy;
            break;
        case EMJInAppObjectFire:
            imageNamesArray = @[@"fire1", @"fire2", @"fire3", @"fire4", @"fire5", @"fire6"].copy;
            break;
        case EMJInAppTypeAnimals:
            imageNamesArray = @[@"an1", @"an2", @"an3", @"an4", @"an5", @"an6"].copy;
            break;
        default:
            break;
    }
    
    return imageNamesArray;
}

@end
