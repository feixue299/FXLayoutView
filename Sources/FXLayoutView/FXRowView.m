//
//  FXRowView.m
//  FXLayoutView
//
//  Created by Mr.wu on 2020/7/5.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "FXRowView.h"

@interface FXRowView ()
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *maxHeightView;
@property (nonatomic, strong) NSLayoutConstraint *rightLayout;

@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *supplementLayouts;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *mainAxisConstraints;
@end

@implementation FXRowView

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self fx_addCrossAxisConstraintWithView:view];

    if (self.subviews.count == 1) {
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [self fx_addSupplementConstraintWithView:view];
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
        [preView.rightAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
        [preView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [view setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    self.rightLayout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
    self.rightLayout.active = YES;
    [self fx_updateRightConstant];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fx_updateRightConstant];
}

- (void)setCrossAxisAlignment:(FXCrossAxisAlignment)crossAxisAlignment {
    if (_crossAxisAlignment == crossAxisAlignment) return;
    _crossAxisAlignment = crossAxisAlignment;
    [self fx_addAllCrossAxisConstraint];
    [self fx_addSupplementConstraintWithView:self.maxHeightView];
}

- (void)setMainAxisAlignment:(FXMainAxisAlignment)mainAxisAlignment {
    if (_mainAxisAlignment == mainAxisAlignment) return;
    _mainAxisAlignment = mainAxisAlignment;
}

- (void)fx_updateRightConstant {
    CGFloat widthTotal = 0;
    for (UIView *view in self.subviews) {
        CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        widthTotal += size.width;
    }
    CGFloat width = self.frame.size.width;
    CGFloat rightPadding = MAX(width - widthTotal, 0);
    self.rightLayout.constant = -rightPadding;
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

- (void)fx_addMainAxisConstraints {

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

- (NSMutableArray<NSLayoutConstraint *> *)mainAxisConstraints {
    if (!_mainAxisConstraints) {
        _mainAxisConstraints = @[].mutableCopy;
    }
    return _mainAxisConstraints;
}

@end
