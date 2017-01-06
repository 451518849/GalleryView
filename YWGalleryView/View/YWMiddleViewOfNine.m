//
//  YWHomeCellMiddleViewNineImage.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWMiddleViewOfNine.h"

@implementation YWMiddleViewOfNine

- (void)addImageViewsFrameToView {
    
    [self setImageHeightByDivide:3];
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i < 3; i ++) {
        [arr1 addObject:[self.imagesArr objectAtIndex:i]];
    }
    for (int j = 3; j < 6; j ++) {
        [arr2 addObject:[self.imagesArr objectAtIndex:j]];
    }
    
    for (int k = 6; k < self.imagesArr.count; k ++) {
        [arr3 addObject:[self.imagesArr objectAtIndex:k]];
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
    }];
    
    /**
     *  7、8、9个排列方式不同
     */
    if (self.imagesArr.count == 7) {
        
        //第七个单独排列一行
        UIImageView *imageView7 = [arr3 objectAtIndex:0];
        
        [imageView7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(arr2).offset(self.YWOneImageHeight+self.margin);
            make.left.equalTo(self);
            //  make.right.equalTo(self.mas_right).offset(-(self.YWOneImageHeight + self.margin)*2);
            make.height.width.mas_equalTo(self.YWOneImageHeight);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
    }else if(self.imagesArr.count == 8) {
        
        [arr3 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:self.YWOneImageHeight + 16];
        [arr3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(self.YWOneImageHeight));
            make.top.equalTo(arr2).offset(self.YWOneImageHeight+self.margin);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }else {
        [arr3 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.margin leadSpacing:0 tailSpacing:0];
        [arr3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@(self.YWOneImageHeight));
            make.top.equalTo(arr2).offset(self.YWOneImageHeight+self.margin);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            
        }];
        
    }
}



@end
