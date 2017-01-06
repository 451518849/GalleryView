//
//  UIView+Frame.h
//  SXDownLoader
//
//  Created by 董尚先 on 15/1/2.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  这个分类使得View获取frame的各种参数变的更加简单
 */
@interface UIView (Frame)

// 自己模仿frame写出他的四个属性
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

- (void)addTapAction:(SEL)tapAction target:(id)target;
@end
