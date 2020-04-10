//
//  JJStarView.h
//  JJStarViewDemo
//
//  Created by 房俊杰 on 2017/7/28.
//  Copyright © 2017年 房俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 类型

 - JJStarViewTypeShow: 展示
 - JJStarViewTypeSelect: 评价
 */
typedef NS_ENUM(NSInteger, JJStarViewType) {
    JJStarViewTypeShow,
    JJStarViewTypeSelect
};
@class JJStarView;
@protocol JJStarViewDelegate <NSObject>

@optional
/**
 代理选中星级

 @param starView starView
 @param score 选中评分
 */
- (void)starView:(JJStarView *)starView didSelectScore:(CGFloat)score;

@end

@interface JJStarView : UIView
/** 代理 */
@property (nonatomic,weak) __weak id<JJStarViewDelegate>delegate;
/** 类型,默认展示 */
@property (nonatomic,assign) JJStarViewType starViewType;
/** 星星图片normal,选中后加"_highlighted" */
@property (nonatomic,strong) NSString *starViewImageName;
/** 星星个数 */
@property (nonatomic,assign) NSInteger starViewCount;
/** 评分(0 - count分) */
@property (nonatomic,assign) CGFloat starViewScore;

@end













































