//
//  EMJDialogElement.m
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import "EMJDialogElement.h"


@interface EMJDialogElement ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;

@end


@implementation EMJDialogElement

+ (instancetype)elementWithName:(NSString *)name andImageName:(NSString *)imageName
{
    EMJDialogElement *element = [EMJDialogElement new];
    element.name = name;
    element.imageName = imageName;
    
    return element;
}

@end
