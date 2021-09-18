//
//  EMJCardTutorialView.h
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJTutorialObject.h"



@protocol EMJCardTutorialViewDelegate <NSObject>
@optional
- (void)continueButtonPressed;
@end


@interface EMJCardTutorialView : UIView

@property (nonatomic, assign) BOOL shouldAddButton;

- (instancetype)initWithTutorialObject:(EMJTutorialObject *)object;
@property (nonatomic, assign) id <EMJCardTutorialViewDelegate> delegate;

@end
