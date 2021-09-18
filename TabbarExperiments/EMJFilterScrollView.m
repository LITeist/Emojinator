//
//  EMJFilterScrollView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJFilterScrollView.h"


static const CGFloat EMJNumberOfFilters = 12;

@interface EMJFilterScrollView () 
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation EMJFilterScrollView

- (instancetype)initWithImageForFilters:(UIImage *)image
{
    const CGFloat viewHeights = [UIScreen mainScreen].bounds.size.width/4;
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewHeights)];
    if (self)
    {
        UIView *gradientView = [[UIView alloc] initWithFrame:self.frame];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = gradientView.bounds;
        gradient.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.6].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.8].CGColor];
        [gradientView.layer insertSublayer:gradient atIndex:0];
        [self addSubview:gradientView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:_scrollView];
        for (int i = 0; i < EMJNumberOfFilters; i++)
        {
            EMJFilterView *filterView = [[EMJFilterView alloc] initWithImage:image andFilterType:i];
            filterView.isSelected = (i == 0) ? YES : NO;
            filterView.center = CGPointMake(filterView.frame.size.width/2 + i * filterView.frame.size.width, filterView.center.y);
            filterView.delegate = self;
            [_scrollView addSubview:filterView];
        }
        
        _scrollView.contentSize = CGSizeMake(viewHeights * EMJNumberOfFilters, viewHeights);
    }
    return self;
}


#pragma mark - FilterDelegate
- (void)didSelectFilterWithType:(FilterType)filterType
{
    for (EMJFilterView *filterView in self.scrollView.subviews)
    {
        if ([filterView isKindOfClass:[EMJFilterView class]])
        {
            filterView.isSelected = (filterView.filterType == filterType) ? YES : NO;
        }
    }
    [self.delegate colorMaimImageWithFilter:filterType];
}

@end
