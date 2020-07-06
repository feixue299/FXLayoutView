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
        label.text = [NSString stringWithFormat:@"hello, world.hello, world.hello, world.hello, world.hello, world.hello, world."];
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
        label.text = [NSString stringWithFormat:@"testtesttesttesttesttesttesttesttesttest"];

        [self.rowView addSubview:label];
    }

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.rowView];

    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rowView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.rowView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor constant:0].active = YES;
    [self.rowView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:200].active = YES;
    [self.rowView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [self.rowView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;

    [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

    UIBarButtonItem *startItem = [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStylePlain target:self action:@selector(startItem)];
    UIBarButtonItem *endItem = [[UIBarButtonItem alloc] initWithTitle:@"end" style:UIBarButtonItemStylePlain target:self action:@selector(endItem)];
    UIBarButtonItem *centerItem = [[UIBarButtonItem alloc] initWithTitle:@"center" style:UIBarButtonItemStylePlain target:self action:@selector(centerItem)];
    self.navigationItem.rightBarButtonItems = @[startItem, endItem, centerItem];
}

- (void)startItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentStart;
}

- (void)endItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentEnd;
}

- (void)centerItem {
    self.rowView.crossAxisAlignment = FXCrossAxisAlignmentCenter;
}

@end
