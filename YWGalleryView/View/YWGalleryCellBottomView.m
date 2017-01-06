//
//  YWHomeCellBottomView.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWGalleryCellBottomView.h"

@implementation YWGalleryCellBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createSubViews];

    }
    return self;
}

- (void)createSubViews {

    _headImageView                     = [[UIImageView alloc] init];
    _nickname                          = [[UILabel alloc] init];
    _time                              = [[UILabel alloc] init];

    _favour                            = [[YWSpringButton alloc ] initWithSelectedImage:[UIImage imageNamed:@"heart_red"]
                                                                         andCancelImage:[UIImage imageNamed:@"heart_gray"]];
    _favour.tag                        = 1;

    _more                              = [[YWAlertButton alloc] init];
    _message                           = [[UIButton alloc] init];
    _favourLabel                       = [[UILabel alloc] init];
    _messageLabel                      = [[UILabel alloc] init];

    _favourLabel.tag                   = 101;

    _headImageView.image               = [UIImage imageNamed:@"touxiang"];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius  = 20;
    
    [_message setBackgroundImage:[UIImage imageNamed:@"bub_gray"]
                        forState:UIControlStateNormal];
    [_more setBackgroundImage:[UIImage imageNamed:@"more_gray"]
                     forState:UIControlStateNormal];
    
    //添加点击事件
    [_message addTarget:self
                 action:@selector(selectMessage)
       forControlEvents:UIControlEventTouchUpInside];
    [_headImageView addTapAction:@selector(selectBottomView:) target:self];
    [_nickname addTapAction:@selector(selectBottomView:) target:self];
    
    _nickname.font = [UIFont systemFontOfSize:12];
    _time.font     = [UIFont systemFontOfSize:10];

    _nickname.textColor     = [UIColor colorWithHexString:THEME_COLOR_2];
    _time.textColor         = [UIColor colorWithHexString:THEME_COLOR_3];
    _favourLabel.textColor  = [UIColor colorWithHexString:THEME_COLOR_4];
    _messageLabel.textColor = [UIColor colorWithHexString:THEME_COLOR_4];


    [self addSubview:_headImageView];
    [self addSubview:_nickname];
    [self addSubview:_time];
    [self addSubview:_favour];
    [self addSubview:_message];
    [self addSubview:_more];
    [self addSubview:_favourLabel];
    [self addSubview:_messageLabel];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(7.5);
        make.centerY.equalTo(_headImageView.mas_centerY).offset(-7.5);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickname.mas_left);
        make.top.equalTo(_nickname.mas_bottom).offset(7.5);
    }];
    
    [_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(self.mas_right);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(_more.mas_left).offset(-10);
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageLabel.mas_left).offset(-5);
        make.centerY.equalTo(_headImageView);
    }];
    
    [_favourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(_message.mas_left).offset(-10);
    }];
    
    [_favour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_favourLabel.mas_left).offset(-5);
        make.centerY.equalTo(_headImageView);
    }];

    
}

- (void)selectMessage {
    if ([self.delegate respondsToSelector:@selector(didSelecteMessageWithBtn:)]) {
        [self.delegate didSelecteMessageWithBtn:_message];
    }
}

- (void)selectBottomView:(UITapGestureRecognizer *) tap{
    
    YWGalleryCellBottomView *homeBottomView = (YWGalleryCellBottomView *)[[tap view] superview];
    if ([self.delegate respondsToSelector:@selector(didSelectHomeBottomView:)]) {
        [self.delegate didSelectHomeBottomView:homeBottomView];
    }
    
}

@end











