//
//  YWHomeCellMiddleViewThreeImage.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWMiddleViewOfThree.h"

@implementation YWMiddleViewOfThree

/**
 *  overwrite
 */
- (void)addImageViewsFrameToView {
    
    [self setImageHeightByDivide:3];
    
    [self.imagesArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
    [self.imagesArr mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(self.YWOneImageHeight));
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        
    }];
    
}


@end
