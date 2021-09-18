//
//  EMJSingleInAppPurchaseView.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 30.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJInAppObject.h"


@interface EMJSingleInAppPurchaseView : UIView <UIScrollViewDelegate>

- (instancetype)initWithInAppObject:(EMJInAppObject *)inAppObject andFrame:(CGRect)frame;

@end
