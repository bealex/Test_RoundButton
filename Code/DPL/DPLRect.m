//
//  Created by alex on 18.01.13.
//
//  Created by Alexander Babaev on 28.01.15.
//  Copyright (c) 2015 Alexander Babaev. All rights reserved.
//


#import "DPLRect.h"

@implementation DPLRect
    + (CGPathRef)createRoundPathForRect:(CGRect)aRect withRadius:(CGFloat)aRadius {
        return [self createRoundPathForRect:aRect withRadius:aRadius ratioFix:1 topLineCallback:nil];
    }

    + (CGPathRef)createRoundPathForRect:(CGRect)aRect withRadius:(CGFloat)aRadius ratioFix:(CGFloat)aRatioFix topLineCallback:(void (^)(CGMutablePathRef aPath))aTopCallback {
        CGMutablePathRef path = CGPathCreateMutable();

        CGFloat left = aRect.origin.x;
        CGFloat right = aRect.origin.x + aRect.size.width;

        CGFloat top = aRect.origin.y;
        CGFloat bottom = aRect.origin.y + aRect.size.height;

        CGFloat radiusHorizontal = aRadius;
        CGFloat radiusVertical = aRadius;
        CGFloat controlPointsLengthHorizontal = (CGFloat) (aRadius*0.2);
        CGFloat controlPointsLengthVertical = controlPointsLengthHorizontal/aRatioFix;

        CGPathMoveToPoint(path, NULL, left, bottom - radiusHorizontal);
        CGPathAddLineToPoint(path, NULL, left, top + radiusVertical);
        // left-top
        CGPathAddCurveToPoint(path, NULL,
                left, top + controlPointsLengthVertical,
                left + controlPointsLengthHorizontal, top,
                left + radiusHorizontal, top);

        if (aTopCallback != nil) {
            aTopCallback(path);
        }

        // right-top
        CGPathAddLineToPoint(path, NULL, right - radiusHorizontal, top);
        CGPathAddCurveToPoint(path, NULL,
                right - controlPointsLengthHorizontal, top,
                right, top + controlPointsLengthVertical,
                right, top + radiusVertical);
        // right-bottom
        CGPathAddLineToPoint(path, NULL, right, bottom - radiusVertical);
        CGPathAddCurveToPoint(path, NULL,
                right, bottom - controlPointsLengthVertical,
                right - controlPointsLengthHorizontal, bottom,
                right - radiusHorizontal, bottom);
        // left-bottom
        CGPathAddLineToPoint(path, NULL, left + radiusHorizontal, bottom);
        CGPathAddCurveToPoint(path, NULL,
                left + controlPointsLengthHorizontal, bottom,
                left, bottom - controlPointsLengthVertical,
                left, bottom - radiusVertical);

        CGPathCloseSubpath(path);

        return path;
    }
@end
