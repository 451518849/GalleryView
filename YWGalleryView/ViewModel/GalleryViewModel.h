//
//  GalleryViewModel.h
//  YWGalleryView
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWGalleryCellOfOne.h"
#import "YWGalleryCellOfTwo.h"
#import "YWGalleryCellOfThree.h"
#import "YWGalleryCellOfFour.h"
#import "YWGalleryCellOfSix.h"
#import "YWGalleryCellOfNine.h"

#import "NewsEntity.h"

@interface GalleryViewModel : NSObject

- (NSString *)idForRowByEntity:(NewsEntity *)entity;


- (void)setupModelOfCell:(YWGalleryBaseCell *)cell entity:(NewsEntity *)entity;

@end
