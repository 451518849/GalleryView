//
//  ImageViewItem.h
//  YWGalleryView
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageViewItem : NSObject

//图片链接
@property (nonatomic, copy  ) NSArray *URLArr;
//小图
@property (nonatomic, strong) NSMutableArray *imageViewArr;

@end
