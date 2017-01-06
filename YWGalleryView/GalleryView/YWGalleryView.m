
#import "YWGalleryView.h"
#import "YWIndicatorView.h"

#define OriginZoomTag 200

@interface YWGalleryView ()

@property (nonatomic, strong) UIScrollView        *scrollView;
@property (assign, nonatomic) NSInteger           currentPage;
@property (atomic,    assign) CGFloat             imageLoadProgress;
@property (nonatomic, assign) CGFloat             totalProgress;
@end


@implementation YWGalleryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    self.scrollView                                = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate                       = self;
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.userInteractionEnabled         = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView.clipsToBounds                  = YES;
    [self addSubview:self.scrollView];
    
    self.maximumZoomScale = 3;
    self.minimumZoomScale = 1;
    
    [self addSubview:self.pageLabel];
}

- (UILabel *)pageLabel {
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _pageLabel.center = CGPointMake(self.center.x, 40);
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.textColor = [UIColor whiteColor];
    }
    return _pageLabel;
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale
{
    _maximumZoomScale = maximumZoomScale;
    
    for (int i = 0; i < self.imagesItem.URLArr.count; i++)
    {
        YWZoomScrollView *zoomScrollView = [[YWZoomScrollView alloc]init];
        [zoomScrollView setMaximumZoomScale:maximumZoomScale];
    }
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale
{
    _minimumZoomScale = minimumZoomScale;
    
    for (int i = 0; i < self.imagesItem.URLArr.count; i++)
    {
        YWZoomScrollView *zoomScrollView = [[YWZoomScrollView alloc]init];
        [zoomScrollView setMinimumZoomScale:minimumZoomScale];
    }
}

- (void)setImagesItem:(ImageViewItem *)imagesItem showAtIndex:(NSInteger)index {

    _imagesItem = imagesItem;
        
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width * imagesItem.URLArr.count,
                                               self.scrollView.bounds.size.height)];
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*index, 0);
    
    
    for (int i = 0; i < self.imagesItem.URLArr.count; i++)
    {
        CGRect rect = CGRectMake(self.scrollView.frame.size.width * i,
                                 0,
                                 self.scrollView.frame.size.width,
                                 self.scrollView.frame.size.height);
        
        YWZoomScrollView *zoomScrollView = [[YWZoomScrollView alloc] initWithFrame:rect
                                                                  andImageView:[imagesItem.imageViewArr objectAtIndex:i]
                                                                       atIndex:i];
        
        //给一个tag，因为图片总是要下载前后三张，方便找到位置
        zoomScrollView.tag = OriginZoomTag+i;
        
        [self.scrollView addSubview:zoomScrollView];

        zoomScrollView.singleTapBlock = ^(UITapGestureRecognizer *recognizer) {
          
            [self removeImageView];
            
        };
        
    }
    
    [self loadImageWithCurrentPage:index];

    
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",(int)(index+1),(int)self.imagesItem.URLArr.count];
    //currentPage 从0开始计算
    self.currentPage = index;
}

- (void)removeImageView{
    
    //获取被放大的小图
    UIImageView *currentSmallView    = [self.imagesItem.imageViewArr objectAtIndex:self.currentPage];
    //获取放大后的图
    UIImageView *currentBigImageView = [self viewWithTag:self.currentPage+1];
    
    //获取被点击的图片的zoomScrollView，如果图片放大了，需要设置zoom为1
    YWZoomScrollView *zoomScrollView = (YWZoomScrollView *)currentBigImageView.superview;
    
    //先去除背景色
    self.backgroundColor             = [UIColor clearColor];
    self.pageLabel.textColor         = [UIColor clearColor];

    [UIView animateWithDuration:0.3
                     animations:^{
        
                         [zoomScrollView setZoomScale:1];
                         currentBigImageView.frame = currentSmallView.frame;
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat   pageWidth   = scrollView.frame.size.width;
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (currentPage != self.currentPage)
    {
        [self loadImageWithCurrentPage:self.currentPage];

    }
    self.currentPage = currentPage;
    
    if ([self.delegate respondsToSelector:@selector(galleryView:didShowPageAtIndex:)])
    {
        [self.delegate galleryView:self didShowPageAtIndex:currentPage];
    }
    
    
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",(int)(currentPage+1),(int)self.imagesItem.URLArr.count];
    
}


//预先加载前后两张图片
- (void)loadImageWithCurrentPage:(NSInteger)currentPage {

    //左边和右边都有图片，并且两张都加载
    if (currentPage+1 < self.imagesItem.URLArr.count && currentPage >0) {
        
        self.totalProgress = 3.0;
        
        //滑动到当前展示的图片
        YWZoomScrollView *centerZoomScrollView = [self.scrollView viewWithTag:OriginZoomTag+currentPage];
        //展示左边的图片
        YWZoomScrollView *leftZoomScrollView   = [self.scrollView viewWithTag:OriginZoomTag+currentPage-1];
        //展示右边的图片
        YWZoomScrollView *rightZoomScrollView  = [self.scrollView viewWithTag:OriginZoomTag+currentPage+1];
        
        [self resizeImageViewByzoomScrollView:centerZoomScrollView atIndex:currentPage];
        [self resizeImageViewByzoomScrollView:leftZoomScrollView atIndex:currentPage-1];
        [self resizeImageViewByzoomScrollView:rightZoomScrollView atIndex:currentPage+1];
        
    }
    //滑动到第一张图片，只加载第一张和第二张
    else if (currentPage == 0 && self.imagesItem.URLArr.count > 1)
    {
        
        self.totalProgress = 2.0;

        //滑动到当前展示的图片
        YWZoomScrollView *centerZoomScrollView = [self.scrollView viewWithTag:OriginZoomTag+currentPage];
        //展示右边的图片
        YWZoomScrollView *rightZoomScrollView  = [self.scrollView viewWithTag:OriginZoomTag+currentPage+1];
        
        [self resizeImageViewByzoomScrollView:centerZoomScrollView atIndex:currentPage];
        [self resizeImageViewByzoomScrollView:rightZoomScrollView atIndex:currentPage+1];
        
    }
    //滑动到最后一张图片，只加载最后一张和最后第二张图片
    else if (currentPage +1 == self.imagesItem.URLArr.count && currentPage != 0)
    {
        self.totalProgress = 2.0;

        //滑动到当前展示的图片
        YWZoomScrollView *centerZoomScrollView = [self.scrollView viewWithTag:OriginZoomTag+currentPage];
        //展示左边的图片
        YWZoomScrollView *leftZoomScrollView   = [self.scrollView viewWithTag:OriginZoomTag+currentPage-1];
        
        [self resizeImageViewByzoomScrollView:centerZoomScrollView atIndex:currentPage];
        [self resizeImageViewByzoomScrollView:leftZoomScrollView atIndex:currentPage-1];
    }
    //只有一张图片
    else if (self.imagesItem.URLArr.count == 1)
    {
        self.totalProgress = 1.0;
        
        //滑动到当前展示的图片
        YWZoomScrollView *centerZoomScrollView = [self.scrollView viewWithTag:OriginZoomTag+currentPage];
        
        [self resizeImageViewByzoomScrollView:centerZoomScrollView atIndex:currentPage];
    }
    
}

- (void)resizeImageViewByzoomScrollView:(YWZoomScrollView *)zoomScrollView atIndex:(NSInteger)index{
  
    
    NSString *imageURL = [self.imagesItem.URLArr objectAtIndex:index];
    
    [zoomScrollView.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil
                                         options:SDWebImageRetryFailed
                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                
                                            [SVProgressHUD showLoadingWithNoMask];
    }
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           
                                           [SVProgressHUD dismiss];
                                           [zoomScrollView resizeImageViewWithImage:image];
                                           
                                           if (zoomScrollView.zoomScale != 1) {
                                               [zoomScrollView setZoomScale:1.0];
                                           }

    }];
    
    
}



@end
