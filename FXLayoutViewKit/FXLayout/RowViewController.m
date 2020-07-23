//
//  RowViewController.m
//  FXLayout
//
//  Created by Mr.wu on 2020/7/5.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import "RowViewController.h"

@interface RowViewController ()

@end

@implementation RowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.layoutView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
}

- (FXLayoutView *)layoutView {
    if (![super layoutView]) {
        [super setLayoutView:[[FXRowView alloc] init]];
    }
    return [super layoutView];
}

@end
