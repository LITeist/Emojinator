//
//  EMJTabbarControl.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 17.05.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMJChooseDialog.h"


@protocol EMJTabbarControlDelegate <NSObject>
@optional
- (void)sourceButtonDidTap;
- (void)shareButtonDidTap;
- (void)inAppButtonDidTap;
- (void)cameraButtonDidTap;
- (void)openSettings;
@end

typedef enum EmojiButtonType : NSUInteger
{
    EmojiCircleButtonPlainMain,
    EmojiCircleButtonCameraMain,
    EmojiCircleButtonMagicMain,
    EmojiCircleButtonCloseMain,
    EmojiCircleButtonSmallSettings,
    EmojiCircleButtonSmallInAppPurchase,
    EmojiCircleButtonSmallReloadImage
}ButtonType;

@interface EMJTabbarControl : UIView <EMJChooseDialogDelegate>

@property (nonatomic, assign) id <EMJTabbarControlDelegate> delegate;
@property (nonatomic, assign) CGFloat hardCodeSize;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)updateLeftButtonWithMainType:(ButtonType)buttonType;
- (void)updateRightButtonWithMainType:(ButtonType)buttonType;
- (void)updateMainButtonWithMainType:(ButtonType)buttonType;

- (void)presentSourceTypeWindow;
@end
