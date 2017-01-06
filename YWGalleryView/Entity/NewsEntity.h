//
//  NewsEntity.h
//  YWGalleryView
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsEntity : NSObject

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *URLString;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, copy  ) NSString *messageNum;
@property (nonatomic, copy  ) NSString *FavourNum;
@property (nonatomic, strong) NSArray  *imageURLArr;

@end
