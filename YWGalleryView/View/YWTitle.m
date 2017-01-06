//
//  YWLabel.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWTitle.h"

@implementation YWTitle

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:BACKGROUND_COLOR];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 14;

        [self createSubViews];
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(selectLabel:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)createSubViews {
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 1;
    _label.font = [UIFont systemFontOfSize:14];
    
    _label.textColor = [UIColor colorWithHexString:THEME_COLOR_1];
    
    [self addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(4, 8, 4, 8));

    }];
}

- (void)selectLabel:(UITapGestureRecognizer *) tap{
    
    YWTitle *label = (YWTitle *)[tap view];
    
    if ([self.delegate respondsToSelector:@selector(didSelectLabel:)]) {
        [self.delegate didSelectLabel:label];
    }
    
}

@end
