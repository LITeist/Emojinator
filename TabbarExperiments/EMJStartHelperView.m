//
//  EMJStartHelperView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 11.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJStartHelperView.h"
#import "EmojyHelper.h"


@implementation EMJStartHelperView

- (instancetype)initWithFrame:(CGRect)frame
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];//UIBlurEffectStyleRegular];
    self = [super initWithEffect:blurEffect];
    if (self)
    {
        self.frame = frame;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.60];
        self.clipsToBounds = YES;
//        self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f].CGColor;
//        self.layer.borderWidth = 1.0;
        
        // label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [EmojyHelper properValueWithDefaultValue:20], frame.size.width, [EmojyHelper properValueWithDefaultValue:65])];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:27]];
        label.numberOfLines = 3;
        label.text = @"Выберите фото\nс помощью:";
        label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(label.frame) + [EmojyHelper properValueWithDefaultValue:9], [EmojyHelper properValueWithDefaultValue:125], [EmojyHelper properValueWithDefaultValue:125])];
        imageView.center = CGPointMake(self.contentView.center.x, imageView.center.y);
        UIImage *plusImage = [UIImage imageNamed:@"plus"];
        imageView.image = [plusImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:0.7f]];
        // add the label to effect view
        [self.contentView addSubview:label];
        [self.contentView addSubview:imageView];
        
        UILabel *emojinatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) - [EmojyHelper properValueWithDefaultValue:13], frame.size.width, [EmojyHelper properValueWithDefaultValue:110])];
        emojinatorLabel.textAlignment = NSTextAlignmentCenter;
        emojinatorLabel.font = [UIFont systemFontOfSize:[EmojyHelper properValueWithDefaultValue:27]];
        emojinatorLabel.numberOfLines = 3;
        emojinatorLabel.text = @"Начните эмоджинацию\nнажав на:";
        emojinatorLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        [self.contentView addSubview:emojinatorLabel];
        
        UIImageView *magicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emojinatorLabel.frame) - [EmojyHelper properValueWithDefaultValue:5], [EmojyHelper properValueWithDefaultValue:65], [EmojyHelper properValueWithDefaultValue:65])];
        magicImageView.center = CGPointMake(self.contentView.center.x + [EmojyHelper properValueWithDefaultValue:5], magicImageView.center.y);
        UIImage *magicImage = [UIImage imageNamed:@"magicWand"];
        magicImageView.image = [magicImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [magicImageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:0.7f]];
        [self.contentView addSubview:magicImageView];
    }
    return self;
}

@end
