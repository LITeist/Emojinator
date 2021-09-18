//
//  EMJTutorialView.m
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJTutorialView.h"
#import "EMJCardTutorialView.h"


static const CGFloat EMJOffset = 15;

@interface EMJTutorialView() <UIScrollViewDelegate, EMJCardTutorialViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation EMJTutorialView

- (instancetype)initWithCardTutorialViews:(NSArray *)arrayOfCard
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        CGFloat width = CGRectGetWidth(self.frame);
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _contentScrollView.delegate = self;
        _contentScrollView.contentSize = CGSizeMake(width * arrayOfCard.count, self.frame.size.height);
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _contentScrollView.contentSize.width, _contentScrollView.contentSize.height)];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
        [_contentScrollView addSubview:_backgroundImageView];
        [self addSubview:_contentScrollView];
        
        for (int i=0; i < arrayOfCard.count; i++)
        {
            EMJCardTutorialView *cardTutorialView = arrayOfCard[i];
            cardTutorialView.center = CGPointMake(cardTutorialView.center.x + i*CGRectGetWidth(self.frame), cardTutorialView.center.y);
            if (i == arrayOfCard.count - 1)
            {
                cardTutorialView.shouldAddButton = YES;
                cardTutorialView.delegate = self;
            }
            [_contentScrollView addSubview:cardTutorialView];
        }
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *closeIconImage = [UIImage imageNamed:@"closeNew"];
        closeIconImage = [closeIconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _closeButton.tintColor = yellowColor;
        [_closeButton setImage:closeIconImage forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(15,30, 35, 35);
        [_closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 3*EMJOffset/2, CGRectGetWidth(self.frame), EMJOffset/2)];
        _pageControl.numberOfPages = arrayOfCard.count;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPageIndicatorTintColor = yellowColor;
        [self addSubview:_pageControl];

    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    _backgroundImageView.image = backgroundImage;
}

- (void)closeButtonPressed
{
//    [self.tutorialDelegate addTutorialView];
    [self removeFromSuperview];
}

- (void)continueButtonPressed
{
//    [self.tutorialDelegate addTutorialView];
    [self removeFromSuperview];
}

- (void)changePage
{
    CGFloat x = self.pageControl.currentPage * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNumber = roundf(scrollView.contentOffset.x / (scrollView.frame.size.width));
    self.pageControl.currentPage = pageNumber;
}

@end
