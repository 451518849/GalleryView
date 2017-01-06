
#import <UIKit/UIKit.h>
#import "YWZoomScrollView.h"
#import "ImageViewItem.h"

@protocol YWGalleryViewDelegate;

@interface YWGalleryView : UIView <UIScrollViewDelegate>
@property (nonatomic, assign) id <YWGalleryViewDelegate>    delegate;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong          ) UILabel      *pageLabel;

@property (assign, nonatomic, readonly) NSInteger    currentPage;

@property (assign, nonatomic          ) CGFloat      maximumZoomScale;//默认为3
@property (assign, nonatomic          ) CGFloat      minimumZoomScale;//默认为1

@property (strong, nonatomic          ) ImageViewItem      *imagesItem;

/**
 *  设置需要展示的UIImage，并且确定展示第index个
 *
 *  @param imagesItem   需要展示的UIImageView数组
 *  @param index        但前点击需要展示的索引
 */
- (void)setImagesItem:(ImageViewItem *)imagesItem showAtIndex:(NSInteger)index;

/**
 *  点击消除
 *
 */
- (void)removeImageView;

@end



@protocol YWGalleryViewDelegate <NSObject>

@optional

//滑动时，切换到某一页时调用
- (void)galleryView:(YWGalleryView *)galleryView didShowPageAtIndex:(NSInteger)pageIndex;

//点击某一页时调用
- (void)galleryView:(YWGalleryView *)galleryView didSelectPageAtIndex:(NSInteger)pageIndex;

/**
 *  移除所有的展现的视图
 *
 */
- (void)galleryView:(YWGalleryView *)galleryView removePageAtIndex:(NSInteger)pageIndex;

@end
