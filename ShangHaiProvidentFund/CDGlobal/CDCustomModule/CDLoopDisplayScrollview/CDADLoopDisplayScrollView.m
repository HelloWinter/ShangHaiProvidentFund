//
//  CDADLoopDisplayScrollView.m
//  CDADLoopDisplayScrollView
//
//  Created by cdd on 15/9/14.
//  Copyright (c) 2015年 cd. All rights reserved.
//

#import "CDADLoopDisplayScrollView.h"
#import "UIImageView+WebCache.h"

static const NSInteger kFrontImageTag = 300;
static const NSInteger kMiddleImageTag = 400;
static const NSInteger kBehindImageTag = 500;

@interface CDADLoopDisplayScrollView ()<UIScrollViewDelegate>{
    NSInteger _tempPage;
    NSTimer *_timer;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *arrImgViewCachePool;

@end

@implementation CDADLoopDisplayScrollView
@synthesize currentImageView = _currentImageView;

- (void)dealloc{
    [self invalidateTimer];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _placeHolderImage=@"ScrollViewDefault";
        self.autoScrollTimeInterval=4.0f;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (NSMutableArray *)arrImgViewCachePool{
    if (_arrImgViewCachePool==nil) {
        _arrImgViewCachePool=[[NSMutableArray alloc]init];
    }
    return _arrImgViewCachePool;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl=showPageControl;
    self.pageControl.hidden=!self.showPageControl;
}

- (void)setPageCtrlSelectColor:(UIColor *)pageCtrlSelectColor{
    _pageCtrlSelectColor=pageCtrlSelectColor;
    self.pageControl.currentPageIndicatorTintColor = self.pageCtrlSelectColor;
}

- (void)setPageCtrlNormalColor:(UIColor *)pageCtrlNormalColor{
    _pageCtrlNormalColor=pageCtrlNormalColor;
    self.pageControl.pageIndicatorTintColor = self.pageCtrlNormalColor;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidden=YES;
        _pageControl.hidesForSinglePage=YES;
    }
    return _pageControl;
}

- (UIImageView *)currentImageView {
    if (self.arrImgViewCachePool.count != 0) {
        _currentImageView = [self.arrImgViewCachePool cd_safeObjectAtIndex:self.pageControl.currentPage];
    }
    return _currentImageView;
}

- (void)setArrImageLink:(NSArray *)arrImageLink{
    if (_arrImageLink) {
        _arrImageLink=nil;
    }
    _arrImageLink=[arrImageLink copy];
    if (!_arrImageLink || _arrImageLink.count==0) { return; }
    self.pageControl.numberOfPages=_arrImageLink.count;
    self.pageControl.currentPage=0;
    self.scrollView.scrollEnabled = (_arrImageLink.count==1) ? NO : YES;
    [self layoutScrollViewSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame=self.bounds;
    CGFloat imgWidth=self.scrollView.frame.size.width;
    CGFloat imgHeight=self.scrollView.frame.size.height;
    CGSize size=[self.pageControl sizeForNumberOfPages:self.arrImageLink.count];
    self.pageControl.frame=CGRectMake(10, self.frame.size.height-size.height, size.width, size.height);
    
    UIImageView *firstSlideImage=[self.scrollView viewWithTag:kFrontImageTag];
    firstSlideImage.frame = CGRectMake(0, 0, imgWidth, imgHeight);
    for (int i=0; i<self.arrImageLink.count; i++) {
        UIImageView *scrollImg=[self.scrollView viewWithTag:kMiddleImageTag+i];
        scrollImg.frame = CGRectMake(imgWidth * (i + 1), 0, imgWidth, imgHeight);
    }
    UIImageView *endSlideImage=[self.scrollView viewWithTag:kBehindImageTag];
    endSlideImage.frame = CGRectMake((_arrImageLink.count + 1) * imgWidth, 0, imgWidth, imgHeight);
    
    [self.scrollView setContentSize:CGSizeMake(imgWidth * (self.arrImageLink.count + 2), imgHeight)];
    [self.scrollView scrollRectToVisible:CGRectMake(imgWidth, 0, imgWidth, imgHeight) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWith = self.scrollView.frame.size.width;
    self.pageControl.currentPage = floor((self.scrollView.contentOffset.x - pageWith/([self.arrImageLink count]+2))/pageWith);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ (self.arrImageLink.count+2)) / pageWith) + 1;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.arrImageLink.count, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }else if(currentPage == self.arrImageLink.count + 1){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_tempPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.arrImageLink.count, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }else if(_tempPage == self.arrImageLink.count){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startScroll];
}

#pragma mark - public
- (void)startScroll{
    if (self.isOpenAutoScroll) {
        [self startTimer];
    }
}

#pragma mark - private
- (void)scrollToNextPage{
    NSInteger page = self.pageControl.currentPage;
    _tempPage = ++page;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * (page + 1), 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
}

- (void)ImageClick:(UITapGestureRecognizer *)recognizer{
    if (self.imageClickBlock) {
        self.imageClickBlock(recognizer.view.tag-kMiddleImageTag);
    }
}

- (void)startTimer{
    [self invalidateTimer];
    _timer = [NSTimer timerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(scrollToNextPage)userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)invalidateTimer{
    [_timer invalidate];
    _timer=nil;
}

- (void)layoutScrollViewSubviews{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<self.arrImageLink.count+2; i++) {
        UIImageView *scrollImg=[self.arrImgViewCachePool cd_safeObjectAtIndex:i];
        if (!scrollImg) {
            scrollImg=[[UIImageView alloc]init];
            scrollImg.userInteractionEnabled=YES;
            [self.arrImgViewCachePool addObject:scrollImg];
        }else{
            scrollImg.image=nil;
            for (UIGestureRecognizer *recognizer in scrollImg.gestureRecognizers) {
                if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                    [scrollImg removeGestureRecognizer:recognizer];
                }
            }
        }
        if (i==self.arrImageLink.count) {
            scrollImg.tag=kFrontImageTag;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageLink[self.arrImageLink.count - 1]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }else if (i==self.arrImageLink.count+1){
            scrollImg.tag=kBehindImageTag;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageLink[0]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }else{
            scrollImg.tag = kMiddleImageTag + i;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageLink[i]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)];
        [scrollImg addGestureRecognizer:tap];
        
        [self.scrollView addSubview:scrollImg];
    }
    [self setNeedsLayout];
}

@end
