//
//  YWHomeCellMiddleViewBase.h
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewItem.h"

typedef void(^AvatarImageTapBlock)(UIImageView *imageView,ImageViewItem *imagesItem);

@interface YWBaseMiddleView : UIView

//点击图片的时候使用
@property (nonatomic, strong) ImageViewItem       *imagesItem;

//布局的时候使用
@property (nonatomic, strong) NSMutableArray      *imagesArr;
@property (nonatomic, assign) double              YWOneImageHeight;
@property (nonatomic, assign) double              margin;

@property (nonatomic, strong) AvatarImageTapBlock imageTapBlock;

- (instancetype)initWithImagesNumber:(NSInteger)num;
/**
 *  添加图片
 *
 *  @param num 图片数量
 */
- (void)createSubviewByImagesNumber:(NSInteger)num;

/**
 *  添加图片约束（子View需重写）
 */
- (void)addImageViewsFrameToView;

/**
 *  图片加载
 *
 *  @param imageArr 图片数组
 */
- (void)addImageViewByImageArr:(NSMutableArray *)imageArr;

/**
 *  获取图片高度
 *
 *  @param divide 一排几个图片
 */
- (void)setImageHeightByDivide:(double) divide;

@end
