//
//  YWHomeCellMiddleViewBase.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWBaseMiddleView.h"

@implementation YWBaseMiddleView

- (ImageViewItem *)imagesItem {
    if (_imagesItem == nil) {
        _imagesItem = [[ImageViewItem alloc] init];
    }
    return _imagesItem;
}

- (instancetype)initWithImagesNumber:(NSInteger)num
{
    self = [super init];
    if (self) {
        
        [self createSubviewByImagesNumber:num];
        
    }
    return  self;
}

- (void)setImageHeightByDivide:(double) divide {
    
    if (divide == 1) {
        
        //图片宽度计算方式
        //SCREEN_WIDTH - 10*2 - 5 *2 这个计算出来的是MiddleView的实际宽度
        //self.margin * 1 这个是减去图片中间的间隙：self.margin
        //当图片一行放两个时候的宽度
        self.YWOneImageHeight = (SCREEN_WIDTH - 10*2 - 5 *2)/divide;
        
    }
    else if (divide == 2.0) {
        
        //图片宽度计算方式
        //SCREEN_WIDTH - 10*2 - 5 *2 这个计算出来的是MiddleView的实际宽度
        //self.margin * 1 这个是减去图片中间的间隙：self.margin
        //当图片一行放两个时候的宽度
        self.YWOneImageHeight = (SCREEN_WIDTH - 10*2 - 5 *2 - self.margin * 1)/divide;
        
    }else if (divide == 3) {
        
        //图片宽度计算方式
        //SCREEN_WIDTH - 10*2 - 5 *2 这个计算出来的是MiddleView的实际宽度
        //self.margin * 1 这个是减去图片中间的间隙：self.margin
        //当图片一行放三个时候的宽度
        self.YWOneImageHeight = (SCREEN_WIDTH - 10*2 - 5 *2 - self.margin * 2)/divide;
    }
}

- (double)margin {
    
    _margin = 2;
    
    return _margin;
}

- (void)createSubviewByImagesNumber:(NSInteger)num {
    
    _imagesArr = [NSMutableArray arrayWithCapacity:num];
    
    for (int i = 0; i < num; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag          = i+1;
        
        [_imagesArr addObject:imageView];
        
        [self addSubview:imageView];
        
        //约束的key，最好检查错误的时候最好设置一下
        imageView.mas_key = [NSString stringWithFormat:@"imageView%d",i];
        
        //给每个图片添加点击事件
        UITapGestureRecognizer *tap      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImageView:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
    }
    
    [self addImageViewsFrameToView];
}

- (void)addImageViewsFrameToView {
    
}


- (void)addImageViewByImageArr:(NSMutableArray *)imageArr {
    
    //只显示9张
    if (imageArr.count <= 9) {
        
        for (int i = 0; i < imageArr.count; i ++) {
            
            UIImageView *newImageView = [imageArr objectAtIndex:i];
            UIImageView *oldImageView = (UIImageView *)[self viewWithTag:i+1];
            oldImageView.image        = newImageView.image;

        }
    }else {
        for (int i = 0; i < 9; i ++) {
            
            UIImageView *newImageView = [imageArr objectAtIndex:i];
            UIImageView *oldImageView = [self viewWithTag:i+1];
            oldImageView.image        = newImageView.image;

        }
    }
    
}

- (void)selectedImageView:(UIGestureRecognizer *)gesture {
    UIImageView *imageView = (UIImageView *)gesture.view;
    
    [self convertImageViewArr];
    
    self.imageTapBlock(imageView,self.imagesItem);
        
}

- (void)convertImageViewArr {
    
    [self.imagesItem.URLArr enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * stop) {
        
        //保存imageView在cell上的位置
        UIImageView *oldImageView = [self.imagesArr objectAtIndex:idx];
        
        //oldImageView有可能是空的，只是个占位imageView
        if (oldImageView.image == nil) {
            return;
        }
        UIImageView *newImageView = [[UIImageView alloc] init];
        newImageView.image        = oldImageView.image;
        newImageView.tag          = oldImageView.tag;
        newImageView.frame        = [oldImageView.superview convertRect:oldImageView.frame
                                                                 toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        [self.imagesItem.imageViewArr addObject:newImageView];
    }];
}

@end
