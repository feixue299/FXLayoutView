//
//  ColumnViewController.m
//  FXLayout
//
//  Created by Mr.wu on 2020/7/21.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "ColumnViewController.h"

@interface ColumnViewController ()


@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.layoutView.heightAnchor constraintEqualToConstant:300].active = YES;
}

- (FXLayoutView *)layoutView {
    if (![super layoutView]) {
        [super setLayoutView:[[FXColumnView alloc] init]];
    }
    return [super layoutView];
}

@end
