//
//  YWHomeCellBottomView.h
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWSpringButton.h"
#import "YWAlertButton.h"

@protocol YWGalleryCellBottomViewDelegate;


@interface YWGalleryCellBottomView : UIView

@property (nonatomic, strong) UIImageView    *headImageView;
@property (nonatomic, strong) UILabel        *nickname;
@property (nonatomic, strong) UILabel        *time;
@property (nonatomic, strong) YWSpringButton *favour;
@property (nonatomic, strong) UIButton       *message;
@property (nonatomic, strong) YWAlertButton  *more;

@property (nonatomic, assign) int            user_id;

@property (nonatomic, strong) UILabel        *favourLabel;
@property (nonatomic, strong) UILabel        *messageLabel;

@property (nonatomic, assign) id<YWGalleryCellBottomViewDelegate> delegate;

@end

@protocol YWGalleryCellBottomViewDelegate <NSObject>

- (void) didSelecteMessageWithBtn:(UIButton *)message;

@optional
- (void) didSelectHomeBottomView:(YWGalleryCellBottomView *)bottomView;


@end
