//
//  IAPHelper.h
//  words
//
//  Created by Dmitry Sakal on 17.10.12.
//  Copyright (c) 2012 Dmitry Sakal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;
UIKIT_EXTERN NSString *const IAPHelperProductPurchaseErrorNotification;
UIKIT_EXTERN NSString *const IAPHelperProductRestorePurchaseNotification;
UIKIT_EXTERN NSString *const IAPHelperProductRestorePurchaseErrorNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restorePurchases;

@end
