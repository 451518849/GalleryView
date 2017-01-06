//
//  YWHomeTableViewCellBase.h
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWGalleryCellTitleView.h"
#import "YWBaseMiddleView.h"
#import "YWGalleryCellBottomView.h"
#import "YWContentLabel.h"

@interface YWGalleryBaseCell : UITableViewCell

@property (nonatomic, strong) YWGalleryCellTitleView      *titleView;
@property (nonatomic, strong) YWBaseMiddleView            *middleView;
@property (nonatomic, strong) YWGalleryCellBottomView     *bottemView;
@property (nonatomic, strong) YWContentLabel              *contentText;

/**
 *  添加子视图（需重写）
 */
- (void)createSubviews;

- (void)addSubviews;


/**
 *  加载图片（需重写）
 *
 *  @param imageArr  UIImageView 数组
 */
- (void)addImageViewByImageArr:(NSMutableArray *)imageArr;

@end
