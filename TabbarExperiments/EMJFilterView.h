//
//  EMJFilterView.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIFilterHelper.h"


@protocol EMJFilterViewDelegate <NSObject>
@optional
- (void)didSelectFilterWithType:(FilterType)filterType;
@end

@interface EMJFilterView : UIView

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) id <EMJFilterViewDelegate> delegate;
@property (nonatomic, assign) FilterType filterType;

- (instancetype)initWithImage:(UIImage *)image andFilterType:(FilterType)filterType;

@end
