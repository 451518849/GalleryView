//
//  YWAlertButton.h
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWAlertButtonProtocol;

@interface YWAlertButton : UIButton

@property (nonatomic, strong) NSMutableArray        *names;
@property (nonatomic, strong) UIAlertController     *alertView;
@property (nonatomic, assign) id<YWAlertButtonProtocol> delegate;

- (instancetype)initWithNames:(NSMutableArray *)names ;
@end

@protocol YWAlertButtonProtocol <NSObject>

- (void)seletedAlertView:(UIAlertController *)alertView
               onMoreBtn:(UIButton *)more
                 atIndex:(NSInteger)index;

@end
