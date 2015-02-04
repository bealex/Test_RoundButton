//
//  Created by alex on 02.01.14.
//
//  Created by Alexander Babaev on 28.01.15.
//  Copyright (c) 2015 Alexander Babaev. All rights reserved.
//


#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #import <UIKit/UIKit.h>
#endif


@interface DPLUIScreenshots : NSObject
    + (UIImage *)captureScreenInRect:(CGRect)aRectToCaptureInWindowCoordinates fromWindow:(UIWindow *)aWindow;
@end
