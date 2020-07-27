//
//  LayoutViewController.m
//  FXLayout
//
//  Created by 8-PC on 2020/7/23.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "LayoutViewController.h"

@interface LayoutViewController ()

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] init];
    self.layoutView.backgroundColor = UIColor.systemRedColor;

    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello"];

        [self.layoutView addSubview:label];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"hello, world"];
        [label.heightAnchor constraintEqualToConstant:50].active = YES;
        [self.layoutView addSubview:label];
    }
    {
        UISwitch *switchView = [[UISwitch alloc] init];
        [self.layoutView addSubview:switchView];
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.systemBlueColor;
        [view.heightAnchor constraintEqualToConstant:100].active = YES;
        [view.widthAnchor constraintEqualToConstant:100].active = YES;

        [self.layoutView addSubview:view];
    }
    {
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"test"];

        [self.layoutView addSubview:label];
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
    UIStackView *crossOtherView = [[UIStackView alloc] init];
    crossOtherView.alignment = UIStackViewAlignmentFill;
    crossOtherView.axis = UILayoutConstraintAxisHorizontal;
    crossOtherView.distribution = UIStackViewDistributionFillEqually;
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"CrossStretch" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(crossStretchItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [crossOtherView addArrangedSubview:button];
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

    UIStackView *mainSpaceView = [[UIStackView alloc] init];
    mainSpaceView.alignment = UIStackViewAlignmentFill;
    mainSpaceView.axis = UILayoutConstraintAxisHorizontal;
    mainSpaceView.distribution = UIStackViewDistributionFillEqually;

    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainSpaceBetween" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainSpaceBetweenItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainSpaceView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainSpaceAround" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainSpaceAroundItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainSpaceView addArrangedSubview:button];
    }
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"MainSpaceEvenly" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(mainSpaceEvenlyItem) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [mainSpaceView addArrangedSubview:button];
    }

    [self.view addSubview:crossView];
    [self.view addSubview:crossOtherView];
    [self.view addSubview:mainView];
    [self.view addSubview:mainSpaceView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.layoutView];

    crossView.translatesAutoresizingMaskIntoConstraints = NO;
    crossOtherView.translatesAutoresizingMaskIntoConstraints = NO;
    mainView.translatesAutoresizingMaskIntoConstraints = NO;
    mainSpaceView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.layoutView.translatesAutoresizingMaskIntoConstraints = NO;

    [crossView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [crossView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [crossView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [crossView.heightAnchor constraintEqualToConstant:50].active = YES;
    [crossOtherView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [crossOtherView.topAnchor constraintEqualToAnchor:crossView.bottomAnchor].active = YES;
    [crossOtherView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [crossOtherView.heightAnchor constraintEqualToConstant:50].active = YES;
    [mainView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [mainView.topAnchor constraintEqualToAnchor:crossOtherView.bottomAnchor].active = YES;
    [mainView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [mainView.heightAnchor constraintEqualToConstant:50].active = YES;
    [mainSpaceView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [mainSpaceView.topAnchor constraintEqualToAnchor:mainView.bottomAnchor].active = YES;
    [mainSpaceView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [mainSpaceView.heightAnchor constraintEqualToConstant:50].active = YES;

    [self.layoutView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor constant:0].active = YES;
    [self.layoutView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:200].active = YES;
    [self.layoutView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [self.layoutView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;

    [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:mainSpaceView.bottomAnchor].active = YES;
    [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)crossStartItem {
    self.layoutView.crossAxisAlignment = FXCrossAxisAlignmentStart;
}

- (void)crossEndItem {
    self.layoutView.crossAxisAlignment = FXCrossAxisAlignmentEnd;
}

- (void)crossCenterItem {
    self.layoutView.crossAxisAlignment = FXCrossAxisAlignmentCenter;
}

- (void)crossStretchItem {
    self.layoutView.crossAxisAlignment = FXCrossAxisAlignmentStretch;
}

- (void)mainStartItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentStart;
}

- (void)mainEndItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentEnd;
}

- (void)mainCenterItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentCenter;
}

- (void)mainSpaceBetweenItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentSpaceBetween;
}

- (void)mainSpaceAroundItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentSpaceAround;
}

- (void)mainSpaceEvenlyItem {
    self.layoutView.mainAxisAlignment = FXMainAxisAlignmentSpaceEvenly;
}


@end
