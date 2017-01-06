//
//  YWHomeTableViewCellBase.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWGalleryBaseCell.h"

@implementation YWGalleryBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCommonView];
        [self createSubviews];
        [self addSubviews];

        [self layoutSubviews];
        
    }
    return self;
}

- (void)createCommonView {
    
    self.backgroundView = [[UIView alloc] init];
    self.titleView      = [[YWGalleryCellTitleView alloc] init];
    self.contentText    = [[YWContentLabel alloc] initWithFrame:CGRectZero];
    self.bottemView     = [[YWGalleryCellBottomView alloc] init];
    
    self.backgroundColor                    = [UIColor clearColor];
    self.backgroundView.backgroundColor     = [UIColor whiteColor];
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.layer.cornerRadius  = 10;
    self.backgroundView.frame = CGRectMake(0, 0, self.width - self.width * 0.05, 0);
    

}

- (void)createSubviews {
    
}

- (void)addSubviews {
    
    [self.contentView    addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.titleView];
    [self.backgroundView addSubview:self.contentText];
    [self.backgroundView addSubview:self.middleView];
    [self.backgroundView addSubview:self.bottemView];
    
    
}


- (void)addImageViewByImageArr:(NSMutableArray *)imageArr {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
