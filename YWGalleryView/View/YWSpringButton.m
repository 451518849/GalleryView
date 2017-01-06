//
//  YWSpringButton.m
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWSpringButton.h"

//按钮缩放倍数
static CGFloat scaleXY = 1.3;

@implementation YWSpringButton


- (instancetype)initWithSelectedImage:(UIImage *)seletedImage andCancelImage:(UIImage *)cancelImage {
    
    self = [super init];
    
    if (self) {
        
        self.seletedImage = seletedImage;
        self.cancelImage  = cancelImage;
        [self setBackgroundImage:cancelImage forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)select {
    if (self.tag == 1) {
        if (self.isSpring == NO) {
            [self selectedScale];
        }else {
            [self cancelScale];;
        }
    }else if(self.tag == 2){
        if (self.isSpringReply == NO) {
            [self selectedScale];
        }else {
            [self cancelScale];
        }
    }
    

}

/**
 *  选择放大，当用户确定为选择时的状态
 */
- (void)selectedScale {
    
    
    [self setBackgroundImage:self.seletedImage forState:UIControlStateNormal];
        
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue             = [NSValue valueWithCGPoint:CGPointMake(scaleXY, scaleXY)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
        
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished){
       
        if (self.tag == 1) {
            self.isSpring = YES;
            if ([self.delegate respondsToSelector:@selector(didSelectSpringButtonOnView:postId:model:)]) {
                [self.delegate didSelectSpringButtonOnView:self.superview postId:self.post_id model:YES];
            }
        }else if (self.tag == 2) {
            self.isSpringReply = YES;
            if ([self.delegate respondsToSelector:@selector(didSelectReplySpringButtonOnView:replyId:model:)]) {
                [self.delegate didSelectReplySpringButtonOnView:self.superview replyId:self.reply_id model:YES];
            }
        }
        
        [self revivificationFavour];
    };
}


/**
 *  取消放大，当用户为取消状态的放大
 */
- (void)cancelScale {
    
    [self setBackgroundImage:self.cancelImage forState:UIControlStateNormal];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(scaleXY, scaleXY)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished){
        
        if (self.tag == 1) {
            self.isSpring = NO;
            if ([self.delegate respondsToSelector:@selector(didSelectSpringButtonOnView:postId:model:)]) {
                [self.delegate didSelectSpringButtonOnView:self.superview postId:self.post_id model:NO];
            }
        }else if (self.tag == 2) {
            self.isSpringReply = NO;
            if ([self.delegate respondsToSelector:@selector(didSelectReplySpringButtonOnView:replyId:model:)]) {
                [self.delegate didSelectReplySpringButtonOnView:self.superview replyId:self.reply_id model:NO];
            }
        }
        
        [self revivificationFavour];
    };
}

/**
 *  还原图片大小
 */
- (void)revivificationFavour {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
    
}

@end
