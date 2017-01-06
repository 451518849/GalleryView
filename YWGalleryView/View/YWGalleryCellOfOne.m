//
//  YWHomeTableViewBaseCell.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWGalleryCellOfOne.h"
#import "YWMiddleViewOfOne.h"
@implementation YWGalleryCellOfOne


- (void)createSubviews {
    
    self.middleView     = [[YWMiddleViewOfOne alloc] initWithImagesNumber:1];

}

- (void)layoutSubviews {
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 2.5, 10));
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.backgroundView.mas_top).offset(10);
        make.left.equalTo(self.backgroundView.mas_left).offset(5);
        make.right.equalTo(self.backgroundView.mas_right).offset(-5);
    }];
    
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView.mas_left).offset(15);
        make.right.equalTo(self.backgroundView.mas_right).offset(-15);
        make.top.equalTo(self.titleView.mas_bottom).offset(10);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView.mas_left).offset(15);
        make.right.equalTo(self.backgroundView.mas_right).offset(-15);
        make.top.equalTo(self.contentText.mas_bottom);
    }];
    
    [self.bottemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset(10);
        make.left.equalTo(self.backgroundView.mas_left).offset(15);
        make.right.equalTo(self.backgroundView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.backgroundView.mas_bottom).offset(-10);
    }];
    
}

- (void)addImageViewByImageArr:(NSMutableArray *)imageArr {
    [self.middleView addImageViewByImageArr:imageArr];
}

@end
