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

@property (nonatomic) UILayoutConstraintAxis direction;
@end

@implementation FXLayoutView

- (instancetype)initWithDirection:(UILayoutConstraintAxis)direction {
    if (self = [super init]) {
        self.direction = direction;
    }
    return self;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self fx_addCrossAxisConstraintWithView:view];

    if (self.subviews.count == 1) {
        [self fx_addMainAxisConstraintsWithView:view preView:nil];
        self.maxView = view;
        [self fx_addSupplementConstraintWithView:view];
    } else {
        UIView *preView = self.subviews[self.subviews.count - 2];

        CGSize viewSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        CGSize max = [self.maxView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

        if (self.direction == UILayoutConstraintAxisHorizontal) {
        }
        switch (self.direction) {
            case UILayoutConstraintAxisHorizontal: {
                if (max.height < viewSize.height) {
                    self.maxView = view;
                    [self fx_addSupplementConstraintWithView:view];
                }
                break;
            }
            case UILayoutConstraintAxisVertical: {
                if (max.width < viewSize.width) {
                    self.maxView = view;
                    [self fx_addSupplementConstraintWithView:view];
                }
                break;
            }
        }

        [self fx_addMainAxisConstraintsWithView:view preView:preView];
        [preView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:self.direction];
        [view setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:self.direction];
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
    CGFloat mainAxisTotal = 0;
    for (UIView *view in self.subviews) {
        CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        switch (self.direction) {
            case UILayoutConstraintAxisHorizontal:
                mainAxisTotal += size.width;
                break;
            case UILayoutConstraintAxisVertical:
                mainAxisTotal += size.height;
                break;
        }
    }
    CGFloat mainAxis = self.direction == UILayoutConstraintAxisHorizontal ? self.frame.size.width : self.frame.size.height;
    CGFloat padding = MAX(mainAxis - mainAxisTotal, 0);

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
        case FXMainAxisAlignmentSpaceBetween: {
            CGFloat offset = padding / (self.subviews.count - 1);
            for (int i = 1; i < self.mainAxisConstraints.count; i++) {
                self.mainAxisConstraints[i].constant = -offset;
            }
            break;
        }
        case FXMainAxisAlignmentSpaceAround: {
            CGFloat offset = padding / self.subviews.count;
            for (int i = 1; i < self.mainAxisConstraints.count; i++) {
                self.mainAxisConstraints[i].constant = -offset;
            }
            self.mainAxisConstraints.firstObject.constant = offset / 2;
            self.mainAxisSupplementConstraints.lastObject.constant = -(offset / 2);
            break;
        }
        case FXMainAxisAlignmentSpaceEvenly: {
            CGFloat offset = padding / (self.subviews.count + 1);
            for (int i = 1; i < self.mainAxisConstraints.count; i++) {
                self.mainAxisConstraints[i].constant = -offset;
            }
            self.mainAxisConstraints.firstObject.constant = offset;
            self.mainAxisSupplementConstraints.lastObject.constant = -offset;
            break;
        }
    }
}

- (void)fx_addAllMainAxisConstraint {
    for (NSLayoutConstraint *layout in self.mainAxisConstraints) {
        layout.active = NO;
    }
    [self.mainAxisConstraints removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [self fx_addMainAxisConstraintsWithView:obj preView:idx == 0 ? nil : self.subviews[idx - 1]];
    }];
}

- (void)fx_addSupplementConstraintWithView:(UIView *)view {
    for (NSLayoutConstraint *layout in self.crossAxisSupplementConstraints) {
        layout.active = NO;
    }
    [self.crossAxisSupplementConstraints removeAllObjects];
    NSLayoutConstraint *crossAxisSupplementConstraint;
    switch (self.crossAxisAlignment) {
        case FXCrossAxisAlignmentStart: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisSupplementConstraint = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisSupplementConstraint = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0];
                    break;
            }
            break;
        }
        case FXCrossAxisAlignmentEnd: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisSupplementConstraint = [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisSupplementConstraint = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0];
                    break;
            }
            break;
        }
        case FXCrossAxisAlignmentCenter: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisSupplementConstraint = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisSupplementConstraint = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0];
                    break;
            }
            break;
        }
    }
    crossAxisSupplementConstraint.active = YES;
    [self.crossAxisSupplementConstraints addObject:crossAxisSupplementConstraint];
}

- (void)fx_addCrossAxisConstraintWithView:(UIView *)view {
    NSLayoutConstraint *crossAxisConstraint;
    switch (self.crossAxisAlignment) {
        case FXCrossAxisAlignmentStart: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisConstraint = [view.topAnchor constraintEqualToAnchor:self.topAnchor];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisConstraint = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
                    break;
            }
            break;
        }
        case FXCrossAxisAlignmentEnd: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisConstraint = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisConstraint = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
                    break;
            }
            break;
        }
        case FXCrossAxisAlignmentCenter: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    crossAxisConstraint = [view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
                    break;
                case UILayoutConstraintAxisVertical:
                    crossAxisConstraint = [view.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
                    break;
            }
            break;
        }
    }
    crossAxisConstraint.active = YES;
    [self.crossAxisConstraints addObject:crossAxisConstraint];
}

- (void)fx_addMainAxisConstraintsWithView:(UIView *)view preView:(UIView *)preView {
    NSLayoutConstraint *layout;
    switch (self.mainAxisAlignment) {
        case FXMainAxisAlignmentStart:
        case FXMainAxisAlignmentCenter:
        case FXMainAxisAlignmentSpaceBetween:
        case FXMainAxisAlignmentSpaceAround:
        case FXMainAxisAlignmentSpaceEvenly: {
            if (preView) {
                switch (self.direction) {
                    case UILayoutConstraintAxisHorizontal:
                        layout = [preView.rightAnchor constraintEqualToAnchor:view.leftAnchor];
                        break;
                    case UILayoutConstraintAxisVertical:
                        layout = [preView.bottomAnchor constraintEqualToAnchor:view.topAnchor];
                        break;
                }
            } else {
                switch (self.direction) {
                    case UILayoutConstraintAxisHorizontal:
                        layout = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
                        break;
                    case UILayoutConstraintAxisVertical:
                        layout = [view.topAnchor constraintEqualToAnchor:self.topAnchor];
                        break;
                }
            }
            break;
        }
        case FXMainAxisAlignmentEnd: {
            if (preView) {
                switch (self.direction) {
                    case UILayoutConstraintAxisHorizontal:
                        layout = [preView.leftAnchor constraintEqualToAnchor:view.rightAnchor];
                        break;
                    case UILayoutConstraintAxisVertical:
                        layout = [preView.topAnchor constraintEqualToAnchor:view.bottomAnchor];
                        break;
                }
            } else {
                switch (self.direction) {
                    case UILayoutConstraintAxisHorizontal:
                        layout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
                        break;
                    case UILayoutConstraintAxisVertical:
                        layout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
                        break;
                }
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
        case FXMainAxisAlignmentStart:
        case FXMainAxisAlignmentCenter:
        case FXMainAxisAlignmentSpaceBetween:
        case FXMainAxisAlignmentSpaceAround:
        case FXMainAxisAlignmentSpaceEvenly: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    layout = [view.rightAnchor constraintEqualToAnchor:self.rightAnchor];
                    break;
                case UILayoutConstraintAxisVertical:
                    layout = [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
                    break;
            }
            break;
        }
        case FXMainAxisAlignmentEnd: {
            switch (self.direction) {
                case UILayoutConstraintAxisHorizontal:
                    layout = [view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
                    break;
                case UILayoutConstraintAxisVertical:
                    layout = [view.topAnchor constraintEqualToAnchor:self.topAnchor];
                    break;
            }
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
