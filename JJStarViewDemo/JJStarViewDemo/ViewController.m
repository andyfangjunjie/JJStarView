//
//  ViewController.m
//  JJStarViewDemo
//
//  Created by 房俊杰 on 2017/7/28.
//  Copyright © 2017年 房俊杰. All rights reserved.
//

#import "ViewController.h"
#import "JJStarView.h"

@interface ViewController () <JJStarViewDelegate>

/**
 展示view
 */
@property (weak, nonatomic) IBOutlet JJStarView *showView;
/**
 选择view
 */
@property (weak, nonatomic) IBOutlet JJStarView *selectView;
/**
 星级label
 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.showView.starViewType = JJStarViewTypeShow;
    self.showView.starViewImageName = @"hy_goodsDetail_redStar";
    self.showView.starViewCount = 5;
    self.showView.starViewScore = 3.5;
    
    self.selectView.starViewType = JJStarViewTypeSelect;
    self.selectView.starViewImageName = @"hy_goodsDetail_redStar";
    self.selectView.starViewCount = 5;
    self.selectView.delegate = self;
}
#pragma mark - JJStarViewDelegate
- (void)starView:(JJStarView *)starView didSelectScore:(CGFloat)score {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.0f分",score];
}


@end












































