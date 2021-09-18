//
//  EMJChooseElementView.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJChooseElementView.h"


static const CGFloat EMJDialogElementHeight = 60.f;
static const CGFloat EMJIconSize = 40.f;

@interface EMJChooseElementView ()
@property (nonatomic, retain) EMJDialogElement *dialogElement;
@property (nonatomic, retain) UILabel *elementNameLabel;
@property (nonatomic, retain) UIImageView *elementImageView;
@end

@implementation EMJChooseElementView

- (instancetype)initWithDialogElement:(EMJDialogElement *)element
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, EMJDialogElementHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:242/255.0 alpha:1];
        _dialogElement = element;
        
        _elementNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 15*3 - EMJIconSize, EMJDialogElementHeight)];
        _elementNameLabel.text = element.name;
        _elementNameLabel.font = [UIFont systemFontOfSize:19];
        _elementNameLabel.textColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        [self addSubview:_elementNameLabel];
        
        _elementImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 15 - EMJIconSize, (60 - EMJIconSize)/2, EMJIconSize, EMJIconSize)];
        _elementImageView.image = [UIImage imageNamed:element.imageName];
        _elementImageView.image = [_elementImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _elementImageView.tintColor = [UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1];
        [self addSubview:_elementImageView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectWithElement)];
        tapRecognizer.numberOfTouchesRequired = 1;
        tapRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)didSelectWithElement
{
    [self.delegate didSelectWithElement:self.dialogElement];
}

@end
