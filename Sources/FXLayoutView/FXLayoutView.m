//
//  FXLayoutView.m
//  FXLayoutView
//
//  Created by Mr.wu on 2020/7/16.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "FXLayoutView.h"

@interface FXLayoutView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *maxView;

@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisSupplementConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *mainAxisConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *mainAxisSupplementConstraints;
@end

@implementation FXLayoutView

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self fx_addCrossAxisConstraintWithView:view];

    if (self.subviews.count == 1) {
        [self fx_addMainAxisConstraintsWithView:view preView:nil];
        [self fx_addSupplementConstraintWithView:view];
        self.maxView = view;
    } else {
        UIView *preView = self.subviews[self.subviews.count - 2];

        CGSize viewSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGSize maxHeight = [self.maxView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

        if (maxHeight.height < viewSize.height) {
            self.maxView = view;
            [self fx_addSupplementConstraintWithView:view];
        }
        [self fx_addMainAxisConstraintsWithView:view preView:preView];
        [preView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [view setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    [self fx_addMainAxisSupplementConstraintsWithView:view];
    [self fx_updateMainAxisSupplementConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fx_updateMainAxisSupplementConstraints];
}

- (void)setCrossAxisAlignment:(FXCrossAxisAlignment)crossAxisAlignment {
    if (_crossAxisAlignment == crossAxisAlignment) return;
    _crossAxisAlignment = crossAxisAlignment;
    [self fx_addAllCrossAxisConstraint];
    [self fx_addSupplementConstraintWithView:self.maxView];
}

- (void)setMainAxisAlignment:(FXMainAxisAlignment)mainAxisAlignment {
    if (_mainAxisAlignment == mainAxisAlignment) return;
    _mainAxisAlignment = mainAxisAlignment;
    [self fx_addAllMainAxisConstraint];
    [self fx_addMainAxisSupplementConstraintsWithView:self.subviews.lastObject];
}

- (void)fx_updateMainAxisSupplementConstraints {
    CGFloat widthTotal = 0;
    for (UIView *view in self.subviews) {
        CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        widthTotal += size.width;
    }
    CGFloat width = self.frame.size.width;
    CGFloat padding = MAX(width - widthTotal, 0);

    switch (self.mainAxisAlignment) {
        case FXMainAxisAlignmentCenter: {
            self.mainAxisSupplementConstraints.lastObject.constant = -padding / 2;
            self.mainAxisConstraints.firstObject.constant = padding / 2;
            break;
        }
        case FXMainAxisAlignmentStart: {
            self.mainAxisSupplementConstraints.lastObject.constant = -padding;
            break;
        }
        case FXMainAxisAlignmentEnd: {
            self.mainAxisSupplementConstraints.lastObject.constant = padding;
            break;
        }
    }
}

- (void)fx_addAllMainAxisConstraint {
    for (NSLayoutConstraint *layout in self.mainAxisConstraints) {
        layout.active = NO;
    }
    [self.mainAxisConstraints removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self fx_addMainAxisConstraintsWithView:obj preView:idx == 0 ? nil : self.subviews[idx - 1]];
    }];
}

- (void)fx_addSupplementConstraintWithView:(UIView *)view {
    for (NSLayoutConstraint *layout in self.crossAxisSupplementConstraints) {
        layout.active = NO;
    }
    [self.crossAxisSupplementConstraints removeAllObjects];
    switch (self.crossAxisAlignment) {
        case FXCrossAxisAlignmentStart: {
            NSLayoutConstraint *bottomLayout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
            bottomLayout.active = YES;
            [self.crossAxisSupplementConstraints addObject:bottomLayout];
            break;
        }
        case FXCrossAxisAlignmentEnd: {
            NSLayoutConstraint *topLayout = [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
            topLayout.active = YES;
            [self.crossAxisSupplementConstraints addObject:topLayout];
            break;
        }
        case FXCrossAxisAlignmentCenter: {
            NSLayoutConstraint *topLayout = [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
            topLayout.active = YES;
            NSLayoutConstraint *bottomLayout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
            bottomLayout.active = YES;
            [self.crossAxisSupplementConstraints addObject:topLayout];
            [self.crossAxisSupplementConstraints addObject:bottomLayout];
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

- (void)fx_addMainAxisConstraintsWithView:(UIView *)view preView:(UIView *)preView {
    NSLayoutConstraint *layout;
    switch (self.mainAxisAlignment) {
        case FXMainAxisAlignmentStart: {
            if (preView) {
                layout = [preView.rightAnchor constraintEqualToAnchor:view.leftAnchor];
            } else {
                layout = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
            }
            break;
        }
        case FXMainAxisAlignmentEnd: {
            if (preView) {
                layout = [preView.leftAnchor constraintEqualToAnchor:view.rightAnchor];
            } else {
                layout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
            }
            break;
        }
        case FXMainAxisAlignmentCenter: {
            if (preView) {
                layout = [preView.rightAnchor constraintEqualToAnchor:view.leftAnchor];
            } else {
                layout = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
            }
            break;
        }
    }

    layout.active = YES;
    [self.mainAxisConstraints addObject:layout];
}

- (void)fx_addMainAxisSupplementConstraintsWithView:(UIView *)view {
    for (NSLayoutConstraint *layout in self.mainAxisSupplementConstraints) {
        layout.active = NO;
    }
    [self.mainAxisSupplementConstraints removeAllObjects];
    NSLayoutConstraint *layout;
    switch (self.mainAxisAlignment) {

        case FXMainAxisAlignmentStart: {
            layout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
            break;
        }
        case FXMainAxisAlignmentEnd: {
            layout = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
            break;
        }

        case FXMainAxisAlignmentCenter: {
            layout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
            break;
        }

    }
    layout.active = YES;
    [self.mainAxisSupplementConstraints addObject:layout];
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

- (NSMutableArray<NSLayoutConstraint *> *)crossAxisSupplementConstraints {
    if (!_crossAxisSupplementConstraints) {
        _crossAxisSupplementConstraints = @[].mutableCopy;
    }
    return _crossAxisSupplementConstraints;
}

- (NSMutableArray<NSLayoutConstraint *> *)mainAxisConstraints {
    if (!_mainAxisConstraints) {
        _mainAxisConstraints = @[].mutableCopy;
    }
    return _mainAxisConstraints;
}

- (NSMutableArray<NSLayoutConstraint *> *)mainAxisSupplementConstraints {
    if (!_mainAxisSupplementConstraints) {
        _mainAxisSupplementConstraints = @[].mutableCopy;
    }
    return _mainAxisSupplementConstraints;
}

@end
