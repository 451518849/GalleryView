//
//  YWHomeCellMiddleViewSixImage.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWMiddleViewOfSix.h"

@implementation YWMiddleViewOfSix

/**
 *  overwrite
 */
- (void)addImageViewsFrameToView {
   
    [self setImageHeightByDivide:3];
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < 3; i ++) {
        [arr1 addObject:[self.imagesArr objectAtIndex:i]];
    }
    for (int j = 3; j < self.imagesArr.count; j ++) {
        [arr2 addObject:[self.imagesArr objectAtIndex:j]];
    }
    
    [arr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
    
    /**
     *  5个排列方式不同
     */
    if (self.imagesArr.count == 5) {
        
        [arr2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:self.YWOneImageHeight+16];
        
    }else {
        
        [arr2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
        
    }
    
    
    [arr1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(self.YWOneImageHeight));
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    [arr2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(self.YWOneImageHeight));
        make.top.equalTo(arr1).offset(self.YWOneImageHeight+self.margin);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
}


@end
