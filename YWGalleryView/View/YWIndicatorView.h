//
//  YWIndicatorView.h
//  yingwo
//
//  Created by 王世杰 on 2016/10/24.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YWIndicatorViewModeLoopDiagram, // 环形
    YWIndicatorViewModePieDiagram // 饼型
} YWIndicatorViewMode;


@interface YWIndicatorView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) int viewMode;//显示模式

@end
