//
//  Created by alex on 18.01.13.
//
//  Created by Alexander Babaev on 28.01.15.
//  Copyright (c) 2015 Alexander Babaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #import <UIKit/UIKit.h>
#endif

@interface DPLRect : NSObject
    + (CGPathRef)createRoundPathForRect:(CGRect)aRect withRadius:(CGFloat)aRadius CF_RETURNS_RETAINED;
@end
