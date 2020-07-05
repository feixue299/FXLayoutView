//
//  ViewController.m
//  FXLayout
//
//  Created by Mr.wu on 2020/7/5.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "ViewController.h"
#import <FXLayoutView/FXLayoutView.h>

@interface ViewController ()
@property (nonatomic, strong) FXRowView *rowView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        switchView.backgroundColor = UIColor.lightGrayColor;
        [self.rowView addSubview:switchView];
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.systemBlueColor;
        [view.heightAnchor constraintEqualToConstant:100].active = YES;
        [self.rowView addSubview:view];
    }
    {
        UILabel *label = [[UILabel alloc] init];
        
        label.backgroundColor = [UIColor colorWithRed:(float)arc4random_uniform(256) / 255 green:(float)arc4random_uniform(256) / 255 blue:(float)arc4random_uniform(256) / 255 alpha:1];
        label.text = [NSString stringWithFormat:@"test"];
        
        [self.rowView addSubview:label];
    }
    
    [self.view addSubview:self.rowView];
    
    self.rowView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.rowView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [self.rowView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    [self.rowView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:300].active = YES;
    
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
