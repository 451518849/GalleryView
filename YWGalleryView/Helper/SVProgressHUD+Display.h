//
//  SVProgressHUD+Display.h
//  yingwo
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

@interface SVProgressHUD (Display)

+ (void)showSuccessStatus:(NSString *)string afterDelay:(NSInteger)delay;

+ (void)showErrorStatus:(NSString *)string afterDelay:(NSInteger)delay;

+ (void)showInfoStatus:(NSString *)string afterDelay:(NSInteger)delay;

+ (void)showLoadingStatusWith:(NSString *) string;

+ (void)showLoadingWithNoMask;

+ (void)showLoadProgress:(CGFloat)progress;

@end
