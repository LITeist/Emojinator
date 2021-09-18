//
//  EMJTutorialView.h
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJCardTutorialView.h"


@protocol EMJTutorialViewDelegate <NSObject>
@optional
- (void)addTutorialView;
@end

@interface EMJTutorialView : UIView

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, weak) id <EMJTutorialViewDelegate> tutorialDelegate;

- (instancetype)initWithCardTutorialViews:(NSArray *)arrayOfCard;

@end
