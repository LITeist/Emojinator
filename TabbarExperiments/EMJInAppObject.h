//
//  EMJInAppObject.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 01.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum EMJInaAppType : NSUInteger
{
    EMJInAppTypeAdds = 0,
    EMJInAppTypeAnimals,
    EMJInAppTypeSpace,
    EMJInAppObjectFire
}InAppType;

@interface EMJInAppObject : NSObject

@property (nonatomic, copy) NSString *inAppTitle;
@property (nonatomic, copy) NSString *sumToBuy;
@property (nonatomic, copy) NSString *inAppDescription;
@property (nonatomic, assign) InAppType inAppType;

- (instancetype)initWithInAppType:(InAppType )inAppType;

@end
