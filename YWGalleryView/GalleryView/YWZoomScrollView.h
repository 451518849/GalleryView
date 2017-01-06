

#import <UIKit/UIKit.h>

/*
 *  此类用于图片点击放大的UIScrollView，用来放大图片和限制图片放大倍数
 */
@interface YWZoomScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView                  *imageView;
@property (nonatomic, assign) NSInteger                     index;

@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);

/**
 *  添加图片
 *

 */
- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView atIndex:(NSInteger)index;

/**
 *  重新下载图片
 *
 *  @param newImage 新的图片
 */
- (void)resizeImageViewWithImage:(UIImage *)newImage;



@end
