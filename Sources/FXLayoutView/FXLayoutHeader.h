//
//  FXLayoutHeader.h
//  FXLayoutView
//
//  Created by Mr.wu on 2020/7/6.
//  Copyright © 2020 Mr.wu. All rights reserved.
//

#ifndef FXLayoutHeader_h
#define FXLayoutHeader_h

typedef NS_ENUM(NSUInteger, FXMainAxisAlignment) {
    FXMainAxisAlignmentStart,
    FXMainAxisAlignmentEnd,
    FXMainAxisAlignmentCenter,
    FXMainAxisAlignmentSpaceBetween,
    FXMainAxisAlignmentSpaceAround,
    FXMainAxisAlignmentSpaceEvenly,
};

typedef NS_ENUM(NSUInteger, FXCrossAxisAlignment) {
    FXCrossAxisAlignmentStart,
    FXCrossAxisAlignmentEnd,
    FXCrossAxisAlignmentCenter,
    FXCrossAxisAlignmentStretch,
};

#endif /* FXLayoutHeader_h */
