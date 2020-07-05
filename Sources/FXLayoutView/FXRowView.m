//
//  FXRowView.m
//  FXLayoutView
//
//  Created by Mr.wu on 2020/7/5.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "FXRowView.h"

@interface FXRowView ()
@property (nonatomic, strong) UIView *maxHeightView;
@property (nonatomic, strong) NSLayoutConstraint *rightLayout;

@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *supplementLayouts;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisConstraints;
@end

@implementation FXRowView

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self fx_addCrossAxisConstraintWithView:view];

    if (self.subviews.count == 1) {
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
        [self fx_addSupplementConstraintWithView:view];
        
        self.rightLayout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0];
        self.rightLayout.active = YES;
        self.maxHeightView = view;
    } else {
        UIView *preView = self.subviews[self.subviews.count - 2];

        CGSize viewSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGSize maxHeight = [self.maxHeightView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

        if (maxHeight.height < viewSize.height) {
            self.maxHeightView = view;
            [self fx_addSupplementConstraintWithView:view];
        }

        self.rightLayout.active = NO;
        [view.leftAnchor constraintEqualToAnchor:preView.rightAnchor constant:0].active = YES;
        self.rightLayout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0];
        self.rightLayout.active = YES;
    }
}

- (void)fx_addSupplementConstraintWithView:(UIView *)view {
    for (NSLayoutConstraint *layout in self.supplementLayouts) {
        layout.active = NO;
    }
    [self.supplementLayouts removeAllObjects];
    switch (self.crossAxisAlignment) {
        case FXCrossAxisAlignmentStart: {
            NSLayoutConstraint *bottomLayout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
            bottomLayout.active = YES;
            [self.supplementLayouts addObject:bottomLayout];
            break;
        }
        case FXCrossAxisAlignmentEnd: {
            NSLayoutConstraint *topLayout = [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
            topLayout.active = YES;
            [self.supplementLayouts addObject:topLayout];
            break;
        }
        case FXCrossAxisAlignmentCenter: {
            NSLayoutConstraint *topLayout = [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
            topLayout.active = YES;
            NSLayoutConstraint *bottomLayout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
            bottomLayout.active = YES;
            [self.supplementLayouts addObject:topLayout];
            [self.supplementLayouts addObject:bottomLayout];
            break;
        }
    }
}

- (void)fx_addCrossAxisConstraintWithView:(UIView *)view {
    switch (self.crossAxisAlignment) {
        case FXCrossAxisAlignmentStart: {
            NSLayoutConstraint *topLayout = [view.topAnchor constraintEqualToAnchor:self.topAnchor];
            topLayout.active = YES;
            [self.crossAxisConstraints addObject:topLayout];
            break;
        }
        case FXCrossAxisAlignmentEnd: {
            NSLayoutConstraint *bottomLayout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
            bottomLayout.active = YES;
            [self.crossAxisConstraints addObject:bottomLayout];
            break;
        }
        case FXCrossAxisAlignmentCenter: {
            NSLayoutConstraint *centerYLayout = [view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
            centerYLayout.active = YES;
            [self.crossAxisConstraints addObject:centerYLayout];
            break;
        }
    }
}

- (void)fx_addAllCrossAxisConstraint {
    for (NSLayoutConstraint *layout in self.crossAxisConstraints) {
        layout.active = NO;
    }
    [self.crossAxisConstraints removeAllObjects];
    for (UIView *view in self.subviews) {
        [self fx_addCrossAxisConstraintWithView:view];
    }
}

- (void)setCrossAxisAlignment:(FXCrossAxisAlignment)crossAxisAlignment {
    if (_crossAxisAlignment == crossAxisAlignment) return;
    _crossAxisAlignment = crossAxisAlignment;
    [self fx_addAllCrossAxisConstraint];
    [self fx_addSupplementConstraintWithView:self.maxHeightView];
}

- (NSMutableArray<NSLayoutConstraint *> *)crossAxisConstraints {
    if (!_crossAxisConstraints) {
        _crossAxisConstraints = @[].mutableCopy;
    }
    return _crossAxisConstraints;
}

- (NSMutableArray<NSLayoutConstraint *> *)supplementLayouts {
    if (!_supplementLayouts) {
        _supplementLayouts = @[].mutableCopy;
    }
    return _supplementLayouts;
}

@end
