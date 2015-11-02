//
//  TableHeightView.m
//  Project3-CHIP
//
//  Created by imac on 15/9/28.
//  Copyright (c) 2015年 Tianyaxu. All rights reserved.
//

#import "TableHeightView.h"
#import "HomeModel.h"
#import "NewsViewController.h"
@implementation TableHeightView
{
    UIImageView *_leftImgView;
    UIImageView *_centerImgView;
    UIImageView *_rightImgView;
    
    NSInteger _currentIndex;//记录当前的图片索引
    
    NSTimer *_timer;
    BOOL _isMoved;
   
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    
    [self addImgView];
    //向滚动视图上添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNews)];
    [_scrollView addGestureRecognizer:tap];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _isMoved = NO;
}

//加载ImgView
- (void)addImgView{
    _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_leftImgView];
    
    _centerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_centerImgView];
    
    _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * kScreenWidth, 0, kScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_rightImgView];
}

//定时器调用的方法
- (void)timerAction{

    _isMoved = YES;
    [_scrollView setContentOffset:CGPointMake(2 * kScreenWidth, 0) animated:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];

}

- (void)showNews{

    HomeModel *model = _imgData[_currentIndex];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.urlStr = model.url;
    
    [self.viewController.navigationController pushViewController:newsVC animated:YES];
}

- (void)setImgData:(NSArray *)imgData{
    if (_imgData != imgData) {
        _imgData = imgData;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //添加定时器，让视图循环滚动
    
    UIPageControl *pageCtrl = (UIPageControl *)[_showView viewWithTag:201];
    pageCtrl.numberOfPages = _imgData.count;

    [_leftImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[_imgData.count - 1] img]]];
    [_centerImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[0] img]]];
    UILabel *label = (UILabel *)[_showView viewWithTag:200];
    label.text = [_imgData[0] title];
    [_rightImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[1] img]]];
    [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    pageCtrl.currentPage = 0;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self loadImg];
}

- (void)loadImg{
    CGPoint point = _scrollView.contentOffset;
    NSInteger leftIndex, rightIndex;
//    //向右滑动
//    if (point.x > kScreenWidth) {
//        _currentIndex = (_currentIndex + 1) % _imgData.count;
//    } else if (point.x < kScreenWidth){
//        //向左滑动
//        _currentIndex = (_currentIndex + _imgData.count - 1) % _imgData.count;
//    }
    if (_imgData.count > 0) {
        if (point.x == kScreenWidth * 2) {
            _currentIndex = (_currentIndex + 1) % _imgData.count;
        } else if (point.x == 0){
            _currentIndex = (_currentIndex + _imgData.count -1) %_imgData.count;
        } else{
            return;
        }
        
        //设置当前的图片
        [_centerImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[_currentIndex] img]]];
        UILabel *label = (UILabel *)[_showView viewWithTag:200];
        label.text = [_imgData[_currentIndex] title];
        leftIndex = (_currentIndex + _imgData.count - 1) % _imgData.count;
        rightIndex = (_currentIndex + 1) % _imgData.count;
        
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[leftIndex] img]]];
        [_rightImgView sd_setImageWithURL:[NSURL URLWithString:[_imgData[rightIndex] img]]];
        UIPageControl *pageCtrl = (UIPageControl *)[_showView viewWithTag:201];
        pageCtrl.currentPage = _currentIndex;
        
        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }
    
//    if (!_isMoved) {
//        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
//    }
//    _isMoved = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
