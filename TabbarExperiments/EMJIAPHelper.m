//
//  WordsIAPHelper.m
//  words
//
//  Created by Dmitry Sakal on 17.10.12.
//  Copyright (c) 2012 Dmitry Sakal. All rights reserved.
//

#import "EMJIAPHelper.h"

@implementation EMJIAPHelper

+ (EMJIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static EMJIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"fullversionenabled",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchasedWithNotification:) name:IAPHelperProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchaseErrorWithNotification:) name:IAPHelperProductPurchaseErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productRestoredWithNotification:) name:IAPHelperProductRestorePurchaseNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productRestoreErrorWithNotification:) name:IAPHelperProductRestorePurchaseErrorNotification object:nil];
    return [super initWithProductIdentifiers:productIdentifiers];
}

- (void)productPurchasedWithNotification:(NSNotification *)notification
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([notification.object isEqualToString:@"fullversionenabled"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FULL_VERSION_ENABLED"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_NEEDS_REDRAW" object:nil];
}

- (void)productPurchaseErrorWithNotification:(NSNotification *)notification
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)productRestoredWithNotification:(NSNotification *)notification
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Purchases restored. Thank you!", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)productRestoreErrorWithNotification:(NSNotification *)notification
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
