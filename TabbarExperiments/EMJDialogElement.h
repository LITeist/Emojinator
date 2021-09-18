//
//  EMJDialogElement.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 08.06.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EMJDialogElement : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *imageName;

+ (instancetype)elementWithName:(NSString *)name andImageName:(NSString *)imageName;

@end
