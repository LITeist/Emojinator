//
//  EMJFilterScrollView.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 21.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJFilterView.h"

@protocol EMJFilterScrollViewDelegate <NSObject>
@optional
- (void)colorMaimImageWithFilter:(FilterType)filterType;
@end

@interface EMJFilterScrollView : UIView <EMJFilterViewDelegate>

@property (nonatomic, assign) id <EMJFilterScrollViewDelegate> delegate;
- (instancetype)initWithImageForFilters:(UIImage *)image;

@end
