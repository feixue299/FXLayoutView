//
//  LayoutViewController.h
//  FXLayout
//
//  Created by 8-PC on 2020/7/23.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FXLayoutViewKit/FXLayoutViewKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LayoutViewController : UIViewController
@property (nonatomic, strong) FXLayoutView *layoutView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
