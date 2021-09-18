//
//  EmojiTextManager.h
//  TabbarExperiments
//
//  Created by Alexey Levanov on 05.07.17.
//  Copyright © 2017 Alexey Levanov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EmojiTextManager : NSObject

+ (instancetype)shared;

- (void)clearString;
- (void)addString:(NSString *)string;
- (NSString *)returnFormattedString;

@end
