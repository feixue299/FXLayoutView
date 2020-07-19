//
//  FXLayoutView.h
//  FXLayoutView
//
//  Created by Mr.wu on 2020/7/16.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLayoutHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXLayoutView : UIView
@property (nonatomic) FXMainAxisAlignment mainAxisAlignment;
@property (nonatomic) FXCrossAxisAlignment crossAxisAlignment;
@end

NS_ASSUME_NONNULL_END
