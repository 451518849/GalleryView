//
//  GalleryViewModel.m
//  YWGalleryView
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "GalleryViewModel.h"

@implementation GalleryViewModel

- (NSString *)idForRowByEntity:(NewsEntity *)entity {
    
    if (entity.imageURLArr.count == 1) {
        return @"one";
    }
    else if (entity.imageURLArr.count == 2) {
        return @"two";
    }
    else if (entity.imageURLArr.count == 3) {
        return @"three";
    }
    else if (entity.imageURLArr.count == 6) {
        return @"six";
    }
    else if (entity.imageURLArr.count == 6) {
        return @"nine";
    }
    return @"none";
}

- (void)setupModelOfCell:(YWGalleryBaseCell *)cell entity:(NewsEntity *)entity {
    
    cell.titleView.title.label.text   = entity.title;
    cell.contentText.text             = entity.content;

    cell.middleView.imagesItem.URLArr = entity.imageURLArr;
    
    [entity.imageURLArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * stop) {
        
        UIImageView *imageView = [cell viewWithTag:idx+1];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
    }];

}

@end










