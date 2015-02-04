//
//  TRBMainViewController.m
//  TestRoundButtons
//
//  Created by Alexander Babaev on 28.01.15.
//  Copyright (c) 2015 Alexander Babaev. All rights reserved.
//

#import <DPL/DPL.h>
#import "TRBMainViewController.h"


@interface TRBMainViewController ()
    @property (weak, nonatomic) IBOutlet UIButton *roundButton;
    @property (weak, nonatomic) IBOutlet UIButton *sausageButton;
    @property (weak, nonatomic) IBOutlet UIImageView *scaledImageView;

    @property (weak, nonatomic) IBOutlet UILabel *cornerRadiusLabel;
    @property (weak, nonatomic) IBOutlet UILabel *roundButtonTypeLabel;
    @property (weak, nonatomic) IBOutlet UILabel *sausageButtonTypeLabel;
@end

typedef NS_ENUM(NSInteger, TRBRoundButtonType) {
    TRBRoundButtonType_CornerRadius,
    TRBRoundButtonType_MaskEllipse,
    TRBRoundButtonType_MaskRoundedRect
};

typedef NS_ENUM(NSInteger, TRBSausageButtonType) {
    TRBSausageButtonType_CornerRadius,
    TRBSausageButtonType_MaskOS,
    TRBSausageButtonType_MaskCorrect
};


@implementation TRBMainViewController {
        TRBRoundButtonType _roundType;
        TRBSausageButtonType _sausageType;

        CGFloat _sliderValue;
    };

    - (void)viewDidLoad {
        [super viewDidLoad];
        _sliderValue = 25;
    }

    - (void)viewDidAppear:(BOOL)animated {
        [super viewDidAppear:animated];

        [self updateRoundButton];
        [self updateSausageButton];
        [self updateLargerView];
        [self updateLabel];
    }

    - (IBAction)sliderValueChanged:(UISlider *)sender {
        _sliderValue = (CGFloat) round(sender.value);

        [self updateRoundButton];
        [self updateSausageButton];
        [self updateLargerView];
        [self updateLabel];
    }

    - (IBAction)tappedOnRoundButton:(id)sender {
        _roundType++;
        if (_roundType > TRBRoundButtonType_MaskRoundedRect) {
            _roundType = TRBRoundButtonType_CornerRadius;
        }

        [self updateRoundButton];
        [self updateLargerView];
        [self updateLabel];
    }

    - (IBAction)tappedOnSasuageButton:(UIButton *)sender {
        _sausageType++;
        if (_sausageType > TRBSausageButtonType_MaskCorrect) {
            _sausageType = TRBSausageButtonType_CornerRadius;
        }

        [self updateSausageButton];
        [self updateLargerView];
        [self updateLabel];
    }

    - (void)updateRoundButton {
        if (_roundType == TRBRoundButtonType_CornerRadius) {
            _roundButton.layer.cornerRadius = _sliderValue;
            _roundButton.layer.masksToBounds = NO;
            _roundButton.layer.mask = nil;
        } else if (_roundType == TRBRoundButtonType_MaskEllipse) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.path = CGPathCreateWithEllipseInRect(_roundButton.bounds, NULL);

            _roundButton.layer.cornerRadius = 0;
            _roundButton.layer.masksToBounds = YES;
            _roundButton.layer.mask = layer;
        } else if (_roundType == TRBRoundButtonType_MaskRoundedRect) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_roundButton.bounds cornerRadius:_sliderValue];
            layer.path = path.CGPath;

            _roundButton.layer.cornerRadius = 0;
            _roundButton.layer.masksToBounds = YES;
            _roundButton.layer.mask = layer;
        }
    }

    - (void)updateSausageButton {
        if (_sausageType == TRBSausageButtonType_CornerRadius) {
            _sausageButton.layer.cornerRadius = _sliderValue;
            _sausageButton.layer.masksToBounds = NO;
            _sausageButton.layer.mask = nil;
        } else if (_sausageType == TRBSausageButtonType_MaskOS) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_sausageButton.bounds cornerRadius:_sliderValue];
            layer.path = path.CGPath;

            _sausageButton.layer.cornerRadius = 0;
            _sausageButton.layer.masksToBounds = YES;
            _sausageButton.layer.mask = layer;
        } else if (_sausageType == TRBSausageButtonType_MaskCorrect) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.path = [DPLRect createRoundPathForRect:_sausageButton.bounds withRadius:_sliderValue];

            _sausageButton.layer.cornerRadius = 0;
            _sausageButton.layer.masksToBounds = YES;
            _sausageButton.layer.mask = layer;
        }
    }

    - (void)updateLargerView {
        CGRect rect = CGRectMake(_roundButton.frame.origin.x + _roundButton.frame.size.width - 45, _roundButton.frame.origin.y - 5, 100, 60);

        UIImage *image = [DPLUIScreenshots captureScreenInRect:rect fromWindow:self.view.window];
        _scaledImageView.image = image;
        _scaledImageView.layer.magnificationFilter = kCAFilterNearest;
    }

    - (void)updateLabel {
        NSString *roundType = @"Corner Radius";
        if (_roundType == TRBRoundButtonType_MaskRoundedRect) {
            roundType = @"Rounded Rect";
        } else if (_roundType == TRBRoundButtonType_MaskEllipse) {
            roundType = @"Ellipse";
        }

        NSString *sausageType = @"Corner Radius";
        if (_sausageType == TRBSausageButtonType_MaskOS) {
            sausageType = @"Rounded OS";
        } else if (_sausageType == TRBSausageButtonType_MaskCorrect) {
            sausageType = @"Rounded Correctly";
        }

        _roundButtonTypeLabel.text = roundType;
        _sausageButtonTypeLabel.text = sausageType;
        _cornerRadiusLabel.text = [NSString stringWithFormat:@"%d", (int) _sliderValue];
    }

@end
