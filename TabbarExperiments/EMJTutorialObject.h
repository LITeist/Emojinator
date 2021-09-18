//
//  EMJTutorialObject.h
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EMJTutorialObject : NSObject

@property (nonatomic, readonly) NSString *titleString;
@property (nonatomic, readonly) NSString *descriptionString;
@property (nonatomic, readonly) NSString *imageName;

+ (instancetype)initWithTitle:(NSString *)title description:(NSString *)description andImageName:(NSString *)imageName;

@end
