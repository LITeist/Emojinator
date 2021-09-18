//
//  EMJChooseDialog.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJChooseDialog.h"
#import "EMJDialogElement.h"


static const CGFloat EMJElementSizeHeight = 60;

@implementation EMJChooseDialog
{
    CGFloat yOffset;
}

- (instancetype)initWithDialogElements:(NSArray *)elements;
{
    yOffset = 0;
    CGFloat dialogHeight = EMJElementSizeHeight * (elements.count+1);
    self = [super initWithFrame:CGRectMake(0, 110 /* TABBAR HEIGHT */ - dialogHeight, [UIApplication sharedApplication].keyWindow.bounds.size.width, dialogHeight)];
    if (self)
    {
        for (int i=0; i<elements.count; i++)
        {
            EMJDialogElement *element = elements[i];
            [self addElementViewWithElement:element];
        }
        [self addElementViewWithElement:nil];
    }
    
    return self;
}

- (void)addElementViewWithElement:(EMJDialogElement *)element
{
    EMJChooseElementView *elementView = [[EMJChooseElementView alloc] initWithDialogElement:element];
    elementView.delegate = self;
    elementView.frame = CGRectMake(elementView.frame.origin.x, elementView.frame.origin.y + yOffset, elementView.frame.size.width, elementView.frame.size.height);
    yOffset = yOffset + elementView.frame.size.height;
    [self addSubview:elementView];
}


- (void)didSelectWithElement:(EMJDialogElement *)element
{
    [self.delegate didSelectWithElement:element];
}
@end
