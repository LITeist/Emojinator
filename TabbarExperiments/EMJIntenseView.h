//
//  EMJIntenseView.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EMJIntenseViewDelegate <NSObject>
@optional
- (void)sliderValueDidChange:(CGFloat)sliderValue;
@end

@interface EMJIntenseView : UIView

@property (nonatomic, assign) id <EMJIntenseViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
