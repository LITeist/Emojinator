//
//  EMJFilterView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJFilterView.h"
#import "CIFilterHelper.h"


static const CGFloat EMJFilterViewParter = 5; // Не придумал быстро, как написать делитель

@interface EMJFilterView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *filterNameLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@end


@implementation EMJFilterView

/* Создается с размером 1/4 ширины экрана */
- (instancetype)initWithImage:(UIImage *)image andFilterType:(FilterType)filterType;
{
    const CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width/4;
    self = [super initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
    if (self)
    {
        _filterType = filterType;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth/EMJFilterViewParter, viewWidth/EMJFilterViewParter + 10, viewWidth - 2*viewWidth/EMJFilterViewParter, viewWidth - 2*viewWidth/EMJFilterViewParter)];
        
        //TODO применить фильтр (вынести в отдельный метод)
        _imageView.image = [[CIFilterHelper shared] imageForFilterType:filterType withImage:image andIntensity:@1];
        _imageView.userInteractionEnabled = YES;
        // TODO вынести цвета в константы
        UIColor *yellowColor = [UIColor colorWithRed:254/255.0 green:208/255.0 blue:71/255.0 alpha:1];
        _imageView.layer.borderColor = yellowColor.CGColor;
        _imageView.layer.borderWidth = 1;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, viewWidth, viewWidth/EMJFilterViewParter)];
        _filterNameLabel.textAlignment = NSTextAlignmentCenter;
        _filterNameLabel.text = [self filerNameForFilterType:filterType];
        _filterNameLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
        _filterNameLabel.font = [UIFont systemFontOfSize:13];
        _filterNameLabel.userInteractionEnabled = YES;
        [self addSubview:_filterNameLabel];
        
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wasTap)];
        _tapRecognizer.numberOfTouchesRequired = 1;
        _tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_tapRecognizer];
    }
    return self;
}

- (NSString *)filerNameForFilterType:(FilterType)filterType
{
    // TODO добавить описание
    // Первый - CIColorMatrix
    switch (filterType)
    {
        case EmojiFilterTypeOne:
            return @"Без фильтра";
        case EmojiFilterTypeTwo:
           return @"Укрощение";
        case EmojiFilterTypeThree:
            return @"Флора";
        case EmojiFilterTypeFour:
            return @"Гидротация";
        case EmojiFilterTypeFive:
            return @"Случай";
        case EmojiFilterTypeSix:
            return @"8 bit";
        case EmojiFilterTypeSeven:
            return @"Твист";
        case EmojiFilterTypeEight:
            return @"Глазурь";
        case EmojiFilterTypeComicEffect:
            return @"Марвел";
        case EmojiFilterTypeShadowAdjust:
            return @"Адажио";
        case EmojiFilterTypeCold:
            return @"Акварель";
        case EmojiFilterTypeBletEffect:
            return @"Блэт";
        default:
            break;
    }
    return @"Без фильтра";
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected != _isSelected)
    {
        _isSelected = isSelected;
        self.filterNameLabel.textColor = _isSelected ? [UIColor whiteColor] : [UIColor colorWithWhite:1 alpha:0.5];
        if (_isSelected)
        {
            [self animatePush];
        }
    }
}

- (void)wasTap
{
    // Отменять выделение прошлого фильтра
    self.isSelected = !_isSelected;
    [self.delegate didSelectFilterWithType:_filterType];
}

- (void)animatePush
{
    const CGFloat EMJBounceValue = 3;
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.frame = CGRectMake(CGRectGetMinX(self.imageView.frame) + EMJBounceValue, CGRectGetMinY(self.imageView.frame) + EMJBounceValue, self.imageView.frame.size.width - EMJBounceValue * 2, self.imageView.frame.size.height - EMJBounceValue * 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.imageView.frame) - EMJBounceValue, CGRectGetMinY(self.imageView.frame) - EMJBounceValue, self.imageView.frame.size.width + EMJBounceValue * 2, self.imageView.frame.size.height + EMJBounceValue * 2);
        }];
    }];
}

@end
