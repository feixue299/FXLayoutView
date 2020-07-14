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

@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *crossAxisSupplementConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *mainAxisConstraints;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *mainAxisSupplementConstraints;
@end

@implementation FXRowView

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self fx_addCrossAxisConstraintWithView:view];

    if (self.subviews.count == 1) {
        [self fx_addMainAxisConstraintsWithView:view preView:nil];
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
    [self fx_addSupplementConstraintWithView:self.maxHeightView];
}

- (void)setMainAxisAlignment:(FXMainAxisAlignment)mainAxisAlignment {
    if (_mainAxisAlignment == mainAxisAlignment) return;
    _mainAxisAlignment = mainAxisAlignment;
}

- (void)fx_updateMainAxisSupplementConstraints {
    CGFloat widthTotal = 0;
    for (UIView *view in self.subviews) {
        CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        widthTotal += size.width;
    }
    CGFloat width = self.frame.size.width;
    CGFloat rightPadding = MAX(width - widthTotal, 0);
    self.mainAxisSupplementConstraints.lastObject.constant = -rightPadding;
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
