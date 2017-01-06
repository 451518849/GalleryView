

#import "YWZoomScrollView.h"

@interface YWZoomScrollView ()

@property (nonatomic, strong) UIAlertController      *alertView;
@property (nonatomic, assign) BOOL                         doubleTapped;

@property (nonatomic, strong) UITapGestureRecognizer       *doubleTapGesture;
@property (nonatomic, strong) UITapGestureRecognizer       *singleTapGreture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation YWZoomScrollView

- (UITapGestureRecognizer *)doubleTapGesture
{
    if (!_doubleTapGesture) {
        _doubleTapGesture                         = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleDoubleTap:)];
        _doubleTapGesture.numberOfTapsRequired    = 2;
        _doubleTapGesture.numberOfTouchesRequired = 1;
    }
    return _doubleTapGesture;
}

- (UITapGestureRecognizer *)singleTapGreture {
    
    if (!_singleTapGreture) {
        _singleTapGreture                         = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleSingleTap:)];
        _singleTapGreture.numberOfTapsRequired    = 1;
        _singleTapGreture.numberOfTouchesRequired = 1;
        //只能有一个手势存在
        [_singleTapGreture requireGestureRecognizerToFail:self.doubleTapGesture];
        

    }
    
    return _singleTapGreture;
}

- (UILongPressGestureRecognizer *)longPress {
    
    if (_longPress == nil) {
        //长按事件
         _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleLongPress:)];
        _longPress.minimumPressDuration          = 0.5f;

    }
    return _longPress;
}

- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.index = index;
        
        //初始化scrollerView
        [self initZoomScrollView];
        
        //实现点击放大
        [self adjustScaleForImageView:imageView];
        
        //添加单击、双击、长按事件
        [self addGrestureForImageView:self.imageView];
        

        
    }
    return self;
}

- (void)initZoomScrollView {
    
    [self setMinimumZoomScale:1];
    [self setMaximumZoomScale:3];
    [self setZoomScale:1];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setDelegate:self];
    
}

- (void)adjustScaleForImageView:(UIImageView *)imageView {
    
    self.imageView       = [[UIImageView alloc] initWithFrame:imageView.frame];
    self.imageView.image = imageView.image;
    self.imageView.tag   = imageView.tag;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.imageView setUserInteractionEnabled:YES];

    [self addAnimationForImageViewScaleWithSize:self.imageView.frame.size];

    [self addSubview:self.imageView];

}

- (void)addGrestureForImageView:(UIImageView *)imageView {
    
    [self addGestureRecognizer:self.singleTapGreture];
    [imageView addGestureRecognizer:self.doubleTapGesture];
    [imageView addGestureRecognizer:self.longPress];
    
}

/**
 *  添加放大动画
 *
 *  @param size 新的UIImage的大小
 */
- (void)addAnimationForImageViewScaleWithSize:(CGSize)size {
    
    CGFloat height       = self.frame.size.width / size.width * size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (height < SCREEN_HEIGHT) {
            [self.imageView setFrame:CGRectMake(0,
                                                (self.frame.size.height - height) / 2,
                                                self.frame.size.width,
                                                height)];
        }else {
            [self.imageView setFrame:CGRectMake(0,
                                                0,
                                                self.frame.size.width,
                                                height)];
            
        }
        
    }];
    
    //设置contentSize 增加对长图的支持
    self.contentOffset = CGPointZero;
    self.contentSize   = CGSizeMake(self.imageView.width, self.imageView.height);
    
}

- (void)resizeImageViewWithImage:(UIImage *)newImage {
    
    self.imageView.image = newImage;
    
    [self addAnimationForImageViewScaleWithSize:self.imageView.image.size];
    
}


#pragma mark method for photos saved to local album
/**
 *  将图片保存至相册
 *
 */
- (void)saveImageToAlbum:(UIImage *)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorStatus:@"保存失败" afterDelay:HUD_DELAY];
    }
    else
    {
        [SVProgressHUD showSuccessStatus:@"保存成功" afterDelay:HUD_DELAY];
    }
}


#pragma mark Gesture handle 

- (void)handleSingleTap:(UITapGestureRecognizer *)gesture {
    
    self.singleTapBlock(gesture);
    
}

//双击事件
- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture
{
    
    float newScale = 1;
    
    if (self.doubleTapped)
    {
        newScale = self.zoomScale * 3;
        self.doubleTapped = NO;
    }
    else
    {
        newScale = 1;
        self.doubleTapped = YES;
    }
    
    CGPoint center  = [gesture locationInView:gesture.view];
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:center];

    [self zoomToRect:zoomRect animated:YES];
}

//长按事件
- (void)handleLongPress:(UILongPressGestureRecognizer *)press {
    
    
    if (_alertView == nil) {
        _alertView = [UIAlertController alertControllerWithTitle:@"提示"
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
        [_alertView addAction:[UIAlertAction actionWithTitle:@"保存图片"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         [SVProgressHUD showLoadingStatusWith:@""];
                                                         UIImageView *pressImageView = (UIImageView *)[press view];
                                                         
                                                         [self saveImageToAlbum:pressImageView.image];
                                                         
                                                         _alertView = nil;
                                                         
                                                     }]];
        
        [_alertView addAction:[UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         _alertView = nil;
                                                     }]];
        
        [self.window.rootViewController presentViewController:_alertView animated:YES completion:nil];
        
    }
    
}


#pragma mark - Zoom methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)relayoutImageView
{
    CGPoint imageCenter = CGPointZero;
    if (self.contentSize.height <= self.frame.size.height)
        imageCenter = CGPointMake(self.contentSize.width/2, self.frame.size.height/2);
    else
        imageCenter = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);
    
    [self.imageView setCenter:imageCenter];
}



#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
    
    [self relayoutImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self relayoutImageView];
}


@end
