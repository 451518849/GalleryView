//
//  YWAlertButton.m
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWAlertButton.h"

NSInteger cancelCode = -1;

@implementation YWAlertButton

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"more_gray"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(showAlertViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithNames:(NSMutableArray *)names {
    self = [super init];
    if (self) {
        _names = names;
        [self setBackgroundImage:[UIImage imageNamed:@"more_gray"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(showAlertViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
   
- (void)showAlertViewController {
    _alertView = [UIAlertController alertControllerWithTitle:@"操作"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"操作"];
    [title addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, 2)];
    
    //改变title的字体大小
    [_alertView setValue:title forKey:@"attributedTitle"];
    for (int i = 0; i < _names.count; i ++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:_names[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {

                                                           if ([self.delegate respondsToSelector:@selector(seletedAlertView:onMoreBtn:atIndex:)]) {
                                                               
                                                               [self.delegate seletedAlertView: _alertView
                                                                                     onMoreBtn:self
                                                                                       atIndex:i];
                                                               
                                                           }
        }];
         //此方法为iOS8.3后才出现的方法
//        [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        
        [_alertView addAction:action];
    }
    
    //将取消样式改为UIAlertActionStyleCancel，点击背景则取消弹窗状态，颜色替换为黑色
    UIAlertAction *action =[UIAlertAction actionWithTitle:@"取消"
                                                    style:UIAlertActionStyleCancel
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      
                                                  }];
//    [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [_alertView addAction:action];
    _alertView.view.tintColor = [UIColor blackColor];
    
    /**
     *  其他弹出框
     *  这里需要注意应该用 self.view.window.rootViewController 作为弹出视图的第一响应者
     *  不能使用self，因为HomeViewController是被 MainTabbarController添加上去de （addSubview）子 view，
     *  因此不能再作为第一响应者，如果使用会报错
     *
     */
    [self.window.rootViewController presentViewController:_alertView animated:YES completion:^{
    }];
}



@end
