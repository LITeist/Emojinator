//
//  EMJInappPurchaseScrollView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 30.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJInappPurchaseScrollView.h"
#import "EMJSingleInAppPurchaseView.h"
#import "EMJInAppObject.h"


static const NSInteger numberOfInApps = 4;
static const CGFloat EMJOffset = 15;

@interface EMJInappPurchaseScrollView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation EMJInappPurchaseScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(frame.size.width * numberOfInApps, frame.size.height);
        [self addSubview:_scrollView];
        CGFloat scrollViewWidth = frame.size.width;
        for (int i = 0; i < numberOfInApps; i++)
        {
            EMJInAppObject *inAppObject = [[EMJInAppObject alloc] initWithInAppType:i];
            EMJSingleInAppPurchaseView *singleView = [[EMJSingleInAppPurchaseView alloc] initWithInAppObject:inAppObject andFrame:CGRectMake(EMJOffset + i*scrollViewWidth, EMJOffset, scrollViewWidth - EMJOffset * 2, self.frame.size.height - 2 * EMJOffset)];
            [_scrollView addSubview:singleView];
        }
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - EMJOffset/2, CGRectGetWidth(frame), EMJOffset/2)];
        _pageControl.numberOfPages = numberOfInApps;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPageIndicatorTintColor = yellowColor;
        [self addSubview:_pageControl];
    }
    
    return self;
}

- (void)changePage
{
    CGFloat x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNumber = roundf(scrollView.contentOffset.x / (scrollView.frame.size.width));
    self.pageControl.currentPage = pageNumber;
}

@end
