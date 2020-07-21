//
//  ColumnViewController.m
//  FXLayout
//
//  Created by Mr.wu on 2020/7/21.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "ColumnViewController.h"
#import <FXLayoutViewKit/FXLayoutViewKit.h>

@interface ColumnViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FXColumnView *columnView;
@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] init];
    self.columnView = [[FXColumnView alloc] init];
    self.columnView.backgroundColor = UIColor.systemRedColor;

    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello"];

        [self.columnView addSubview:label];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello, world"];
        [label.heightAnchor constraintEqualToConstant:50].active = YES;
        [self.columnView addSubview:label];
    }
    {
        UISwitch *switchView = [[UISwitch alloc] init];
        [self.columnView addSubview:switchView];
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.systemBlueColor;
        [view.heightAnchor constraintEqualToConstant:100].active = YES;
        [view.widthAnchor constraintEqualToConstant:100].active = YES;

        [self.columnView addSubview:view];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"test"];

        [self.columnView addSubview:label];
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
    UIStackView *mainView = [[UIStackView alloc] init];
    mainView.alignment = UIStackViewAlignmentFill;
    mainView.axis = UILayoutConstraintAxisHorizontal;
    mainView.distribution = UIStackViewDistributionFillEqually;
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainStart" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainStartItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainEnd" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainEndItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainCenter" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainCenterItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainView addArrangedSubview:button];
    }

    [self.view addSubview:crossView];
    [self.view addSubview:mainView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.columnView];

    crossView.translatesAutoresizingMaskIntoConstraints = NO;
    mainView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.columnView.translatesAutoresizingMaskIntoConstraints = NO;

    [crossView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [crossView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [crossView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [crossView.heightAnchor constraintEqualToConstant:50].active = YES;
    [mainView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [mainView.topAnchor constraintEqualToAnchor:crossView.bottomAnchor].active = YES;
    [mainView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [mainView.heightAnchor constraintEqualToConstant:50].active = YES;

    [self.columnView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor constant:0].active = YES;
    [self.columnView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:200].active = YES;
    [self.columnView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [self.columnView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    [self.columnView.heightAnchor constraintEqualToConstant:300].active = YES;

    [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:mainView.bottomAnchor].active = YES;
    [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)crossStartItem {
    self.columnView.crossAxisAlignment = FXCrossAxisAlignmentStart;
}

- (void)crossEndItem {
    self.columnView.crossAxisAlignment = FXCrossAxisAlignmentEnd;
}

- (void)crossCenterItem {
    self.columnView.crossAxisAlignment = FXCrossAxisAlignmentCenter;
}

- (void)mainStartItem {
    self.columnView.mainAxisAlignment = FXMainAxisAlignmentStart;
}

- (void)mainEndItem {
    self.columnView.mainAxisAlignment = FXMainAxisAlignmentEnd;
}

- (void)mainCenterItem {
    self.columnView.mainAxisAlignment = FXMainAxisAlignmentCenter;
}

@end