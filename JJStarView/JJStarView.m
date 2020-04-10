//
//  JJStarView.m
//  JJStarViewDemo
//
//  Created by 房俊杰 on 2017/7/28.
//  Copyright © 2017年 房俊杰. All rights reserved.
//

#import "JJStarView.h"

@interface JJStarView ()
/** 中间view */
@property (nonatomic,strong) UIView *midView;

@end

@implementation JJStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.starViewCount == 0) return;
    
    if (self.subviews.count < self.starViewCount) return;
    
    CGFloat margin = (CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) * self.starViewCount) / (self.starViewCount - 1);
    
    if (self.starViewType == JJStarViewTypeShow) {
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIImageView *imageView = (UIImageView *)self.subviews[i];
            imageView.image = [UIImage imageNamed:self.starViewImageName];
            imageView.frame = CGRectMake((CGRectGetHeight(self.frame) + margin) * i, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        }
        self.midView.frame = self.bounds;
        
        CGFloat width = 0;
        if (self.starViewScore <= 1) {
            width = CGRectGetHeight(self.frame) * self.starViewScore;
        } else {
            width = CGRectGetHeight(self.frame) * self.starViewScore + floorf(self.starViewScore) * margin;
        }
        
        CGRect frame = self.midView.frame;
        frame.size.width = width;
        self.midView.frame = frame;
        
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIImageView *imageView = (UIImageView *)self.midView.subviews[i];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",self.starViewImageName]];
            imageView.frame = CGRectMake((CGRectGetHeight(self.frame) + margin) * i, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        }
    } else {
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIButton *button = (UIButton *)self.subviews[i];
            button.frame = CGRectMake((CGRectGetHeight(self.frame) + margin) * i, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
            [button setImage:[UIImage imageNamed:self.starViewImageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",self.starViewImageName]] forState:UIControlStateSelected];
            if (i < self.starViewScore) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
}
#pragma mark - 初始化
- (void)setup {
    _starViewCount = 5;
    [self layout];
}
- (void)layout {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.starViewCount == 0) return;
    
    if (self.starViewType == JJStarViewTypeShow) {
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
        }
        
        [self addSubview:self.midView];
        
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.midView addSubview:imageView];
        }
    } else {
        for (NSInteger i = 0;i < self.starViewCount;i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)buttonClick:(UIButton *)sender {
    NSInteger score = [self.subviews indexOfObject:sender] + 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(starView:didSelectScore:)]) {
        [self.delegate starView:self didSelectScore:score];
    }
    _starViewScore = score;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark - 懒加载
/** 中间view */
- (UIView *)midView
{
    if(!_midView){
        _midView = [[UIView alloc] init];
        _midView.backgroundColor = [UIColor clearColor];
        _midView.clipsToBounds = YES;
    }
    return _midView;
}
#pragma mark - setter
- (void)setStarViewType:(JJStarViewType)starViewType {
    _starViewType = starViewType;
    [self layout];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setStarViewCount:(NSInteger)starViewCount {
    _starViewCount = starViewCount;
    if (starViewCount != 5) {
        [self layout];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setStarViewScore:(CGFloat)starViewScore {
    _starViewScore = starViewScore;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setStarViewImageName:(NSString *)starViewImageName {
    _starViewImageName = starViewImageName;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
