//
//  ImageViewItem.m
//  YWGalleryView
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "ImageViewItem.h"

@implementation ImageViewItem

- (NSMutableArray *)imageViewArr {
    if (_imageViewArr == nil) {
        _imageViewArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imageViewArr;
}

@end
