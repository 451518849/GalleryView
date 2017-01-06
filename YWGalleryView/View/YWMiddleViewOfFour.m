//
//  YWHomeCellMiddleViewFourImage.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWMiddleViewOfFour.h"

@implementation YWMiddleViewOfFour

/**
 *  overwrite
 */
- (void)addImageViewsFrameToView {
    
    [self setImageHeightByDivide:2];
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:2];
    
    for (int i = 0; i < 2; i ++) {
        [arr1 addObject:[self.imagesArr objectAtIndex:i]];
    }
    for (int j = 2; j < self.imagesArr.count; j ++) {
        [arr2 addObject:[self.imagesArr objectAtIndex:j]];
    }
    
    [arr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
    [arr2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
    
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
