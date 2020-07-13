//
//  RowViewController.m
//  FXLayout
//
//  Created by Mr.wu on 2020/7/5.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "RowViewController.h"
#import <FXLayoutView/FXLayoutView.h>

@interface RowViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FXRowView *rowView;
@end

@implementation RowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] init];
    self.rowView = [[FXRowView alloc] init];
    self.rowView.backgroundColor = UIColor.systemRedColor;

    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello"];

        [self.rowView addSubview:label];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello, world"];
        [label.heightAnchor constraintEqualToConstant:50].active = YES;
        [self.rowView addSubview:label];
    }
    {
        UISwitch *switchView = [[UISwitch alloc] init];
        [self.rowView addSubview:switchView];
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.systemBlueColor;
        [view.heightAnchor constraintEqualToConstant:100].active = YES;
        [view.widthAnchor constraintEqualToConstant:100].active = YES;

        [self.rowView addSubview:view];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"test"];

        [self.rowView addSubview:label];
    }
    UIStackView *crossView = [[UIStackView alloc] init];
    crossView.alignment = UIStackViewAlignmentFill;
    crossView.axis = UILayoutConstraintAxisHorizontal;
    crossView.distribution = UIStackViewDistributionFillEqually;
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"CrossStart" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(crossStartItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [crossView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"CrossEnd" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(crossEndItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [crossView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"CrossCenter" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(crossCenterItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [crossView addArrangedSubview:button];
    }

    [self.view addSubview:crossView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.rowView];

    crossView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rowView.translatesAutoresizingMaskIntoConstraints = NO;

    [crossView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [crossView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [crossView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [crossView.heightAnchor constraintEqualToConstant:50].active = YES;

    [self.rowView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor constant:0].active = YES;
    [self.rowView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:200].active = YES;
    [self.rowView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [self.rowView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    [self.rowView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;

    [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:crossView.bottomAnchor].active = YES;
    [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)crossStartItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentStart;
}

- (void)crossEndItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentEnd;
}

- (void)crossCenterItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentCenter;
}

@end
