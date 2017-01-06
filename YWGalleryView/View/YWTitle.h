//
//  YWLabel.h
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWTitleDelegate;

@interface YWTitle : UIView

@property (nonatomic, strong) UILabel         *label;
@property (nonatomic, assign) int             topic_id;
@property (nonatomic, assign) id<YWTitleDelegate> delegate;

@end

@protocol YWTitleDelegate <NSObject>

- (void)didSelectLabel:(YWTitle *)label;

@end
