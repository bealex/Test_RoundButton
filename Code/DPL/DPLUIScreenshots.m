//
//  Created by alex on 02.01.14.
//
//  Created by Alexander Babaev on 28.01.15.
//  Copyright (c) 2015 Alexander Babaev. All rights reserved.
//


#import "DPLUIScreenshots.h"


@implementation DPLUIScreenshots
    + (UIImage *)captureScreenInRect:(CGRect)aRectToCaptureInWindowCoordinates fromWindow:(UIWindow *)aWindow {
        return [self captureScreenInRect:aRectToCaptureInWindowCoordinates fromWindow:aWindow afterScreenUpdates:YES];
    }

    + (UIImage *)captureScreenInRect:(CGRect)aRectToCaptureInWindowCoordinates fromWindow:(UIWindow *)aWindow afterScreenUpdates:(BOOL)afterScreenUpdates {
        UIImage *result = nil;

        if ([aWindow respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            UIGraphicsBeginImageContextWithOptions(aRectToCaptureInWindowCoordinates.size, NO, 0);
            {
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextSaveGState(context);
                CGContextTranslateCTM(context, -aRectToCaptureInWindowCoordinates.origin.x, -aRectToCaptureInWindowCoordinates.origin.y);

#ifdef __IPHONE_7_0
                if (![aWindow drawViewHierarchyInRect:aWindow.bounds afterScreenUpdates:afterScreenUpdates]) {
#else
                if (![aWindow performSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)
                                   withObject:[NSValue valueWithCGRect:aWindow.bounds]
                                   withObject:[NSNumber numberWithBool:YES]]) {
#endif
                    NSLog(@"ERROR during capturing screenshot for main window");
                }

                CGContextRestoreGState(context);

                result = UIGraphicsGetImageFromCurrentImageContext();
            }
            UIGraphicsEndImageContext();
        }

        return result;
    }
@end
