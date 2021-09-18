//
//  EMJChooseElementView.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJDialogElement.h"


@protocol EMJChooseElementViewDelegate <NSObject>
@optional
- (void)didSelectWithElement:(EMJDialogElement *)element;
@end


@interface EMJChooseElementView : UIView

@property (nonatomic, assign) id <EMJChooseElementViewDelegate> delegate;
- (instancetype)initWithDialogElement:(EMJDialogElement *)element;

@end
