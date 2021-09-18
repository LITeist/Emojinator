//
//  EMJTutorialObject.m
//  TutorialTest
//
//  Created by Alexey Levanov on 22.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJTutorialObject.h"


@interface EMJTutorialObject ()

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic, copy) NSString *imageName;

@end

@implementation EMJTutorialObject

+ (instancetype)initWithTitle:(NSString *)title description:(NSString *)description andImageName:(NSString *)imageName
{
    EMJTutorialObject *object = [EMJTutorialObject new];
    object.titleString = title;
    object.descriptionString = description;
    object.imageName = imageName;
    
    return object;
}

@end
