//
//  ViewController.m
//  YWGalleryView
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 wangxiaofa. All rights reserved.
//

#import "ViewController.h"

#import "YWGalleryCellOfOne.h"
#import "YWGalleryCellOfTwo.h"
#import "YWGalleryCellOfThree.h"
#import "YWGalleryCellOfFour.h"
#import "YWGalleryCellOfSix.h"
#import "YWGalleryCellOfNine.h"

#import "YWGalleryView.h"

#import "GalleryViewModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YWGalleryViewDelegate>

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSArray          *newsArr;

@property (nonatomic, strong) GalleryViewModel *viewModel;

@end

@implementation ViewController

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
        [_tableView registerClass:[YWGalleryCellOfOne class] forCellReuseIdentifier:@"one"];
        [_tableView registerClass:[YWGalleryCellOfTwo class] forCellReuseIdentifier:@"two"];
        [_tableView registerClass:[YWGalleryCellOfThree class] forCellReuseIdentifier:@"three"];
        [_tableView registerClass:[YWGalleryCellOfFour class] forCellReuseIdentifier:@"four"];
        [_tableView registerClass:[YWGalleryCellOfSix class] forCellReuseIdentifier:@"six"];
        [_tableView registerClass:[YWGalleryCellOfNine class] forCellReuseIdentifier:@"nine"];
        
        
    }
    
    
    
    return _tableView;
}

- (GalleryViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[GalleryViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testData];

    self.view.backgroundColor = [UIColor colorWithHexString:BACKGROUND_COLOR];
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testData {
    
    NewsEntity *news1 = [[NewsEntity alloc] init];
    NewsEntity *news2 = [[NewsEntity alloc] init];
    NewsEntity *news3 = [[NewsEntity alloc] init];

    news1.title = @"今日头条";
    news2.title = @"今日头条";
    news3.title = @"今日头条";

    news1.content = @"xxxxxxxxxxxxxxxx";
    news2.content = @"啦啦啦啦啦啦啦啦啦";
    news3.content = @"xxxxxxxxxxxxxxxx";

    news1.imageURLArr = @[
                          @"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",

                          ];
    news2.imageURLArr = @[
                          @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
                          @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",

                          ];
    news3.imageURLArr = @[
                          @"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                          @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                          @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                          @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                          @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                          @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                          ];
    
    self.newsArr = [NSArray arrayWithObjects:news1,news2,news3, nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArr.count;
}

- (YWGalleryBaseCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier   = [self.viewModel idForRowByEntity:self.newsArr[indexPath.row]];
    
    YWGalleryBaseCell *cell    = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                               forIndexPath:indexPath];
    
    [self.viewModel setupModelOfCell:cell
                              entity:self.newsArr[indexPath.row]];
    
    //回调block实现点击图片放大
    cell.middleView.imageTapBlock = ^(UIImageView *imageView, ImageViewItem *imagesItem) {
            
        YWGalleryView *galleryView          = [[YWGalleryView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        galleryView.backgroundColor = [UIColor blackColor];
        galleryView.delegate = self;
        
        [galleryView setImagesItem:imagesItem showAtIndex:imageView.tag-1];
        [self.view.window.rootViewController.view addSubview:galleryView];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [self.viewModel idForRowByEntity:self.newsArr[indexPath.row]];
    
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration:^(id cell) {
                                           
                                           [self.viewModel setupModelOfCell:cell
                                                                     entity:self.newsArr[indexPath.row]];
                                       }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
