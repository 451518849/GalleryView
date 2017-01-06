//
//  SVProgressHUD+Display.m
//  yingwo
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "SVProgressHUD+Display.h"

@implementation SVProgressHUD (Display)

+ (void)showSuccessStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showSuccessWithStatus:string];

}

+ (void)showErrorStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showInfoStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showInfoWithStatus:string];
}

+ (void)showLoadingStatusWith:(NSString *) string{
    [SVProgressHUD setCustomDefaultStyle];
    [SVProgressHUD showWithStatus:string];
}

+ (void)showLoadingWithNoMask{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:@""];

}

+ (void)showLoadProgress:(CGFloat)progress {
    [SVProgressHUD setCustomDefaultStyle];
    [SVProgressHUD showProgress:progress];
}


#pragma private method

+ (void)setCustomDefaultStyleWithDelay:(NSInteger) delay{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:delay];
}

+ (void)setCustomDefaultStyle{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

@end
