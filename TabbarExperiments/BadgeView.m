//
//  BadgeView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 17.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "BadgeView.h"


static const CGFloat EMJBadgeSzie = 19;

@interface BadgeView ()
@property (nonatomic, copy) UILabel *badgeCount;
@end

@implementation BadgeView

- (instancetype)initWithNumberInteger:(NSInteger)numberInteger
{
	self = [super initWithFrame:CGRectMake(0, 0, EMJBadgeSzie, EMJBadgeSzie)];
	if (self)
	{
		// Желтый с белым или белый с желтым?
		UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
		self.backgroundColor = yellowColor;
		self.layer.cornerRadius = EMJBadgeSzie/2;
		self.layer.masksToBounds = YES;
		self.textColor = [UIColor whiteColor];
		self.textAlignment = NSTextAlignmentCenter;
		self.text = [NSString stringWithFormat:@"%ld", (long)numberInteger];
		[self addSubview:_badgeCount];
	}
	return self;
}

@end
