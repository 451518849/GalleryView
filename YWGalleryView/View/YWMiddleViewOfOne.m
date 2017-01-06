//
//  YWHomeCellMiddleView.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWMiddleViewOfOne.h"

@implementation YWMiddleViewOfOne

-(void)addImageViewsFrameToView {
    
    [self setImageHeightByDivide:1];
    
    UIImageView *imageView = [self.imagesArr objectAtIndex:0];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(self.YWOneImageHeight)).priorityHigh();
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
}

@end
