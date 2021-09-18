//
//  EMJChooseDialog.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJDialogElement.h"
#import "EMJChooseElementView.h"


@protocol EMJChooseDialogDelegate <NSObject>
@optional
- (void)didSelectWithElement:(EMJDialogElement *)element;
@end


@interface EMJChooseDialog : UIView <EMJChooseElementViewDelegate>

@property (nonatomic, assign) id <EMJChooseDialogDelegate> delegate;
- (instancetype)initWithDialogElements:(NSArray *)elements;

@end
