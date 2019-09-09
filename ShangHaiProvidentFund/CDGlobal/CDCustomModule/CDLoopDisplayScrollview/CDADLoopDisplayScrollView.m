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
@property (nonatomic, strong) NSMutableArray *arrImageUrl;

@end

@implementation CDADLoopDisplayScrollView
@synthesize currentImageView = _currentImageView;

- (void)dealloc{
    [self p_invalidateTimer];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _placeHolderImage=@"ScrollViewDefault";
        _autoScrollTimeInterval=4.0f;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame=self.bounds;
    CGFloat imgWidth=_scrollView.frame.size.width;
    CGFloat imgHeight=_scrollView.frame.size.height;
    CGSize size=[_pageControl sizeForNumberOfPages:self.arrImageUrl.count];
    _pageControl.frame=CGRectMake(10, self.frame.size.height-size.height, size.width, size.height);
    
    UIImageView *firstSlideImage=[_scrollView viewWithTag:kFrontImageTag];
    firstSlideImage.frame = CGRectMake(0, 0, imgWidth, imgHeight);
    for (int i=0; i<self.arrImageUrl.count; i++) {
        UIImageView *scrollImg=[_scrollView viewWithTag:kMiddleImageTag+i];
        scrollImg.frame = CGRectMake(imgWidth * (i + 1), 0, imgWidth, imgHeight);
    }
    UIImageView *endSlideImage=[_scrollView viewWithTag:kBehindImageTag];
    endSlideImage.frame = CGRectMake((self.arrImageUrl.count + 1) * imgWidth, 0, imgWidth, imgHeight);
    
    [_scrollView setContentSize:CGSizeMake(imgWidth * (self.arrImageUrl.count + 2), imgHeight)];
    [_scrollView scrollRectToVisible:CGRectMake(imgWidth, 0, imgWidth, imgHeight) animated:NO];
}

#pragma mark - override
- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl=showPageControl;
    self.pageControl.hidden=!self.showPageControl;
}

- (void)setPageCtrlNormalColor:(UIColor *)pageCtrlNormalColor{
    _pageCtrlNormalColor=pageCtrlNormalColor;
    self.pageControl.pageIndicatorTintColor = self.pageCtrlNormalColor;
}

- (void)setPageCtrlSelectColor:(UIColor *)pageCtrlSelectColor{
    _pageCtrlSelectColor=pageCtrlSelectColor;
    self.pageControl.currentPageIndicatorTintColor = self.pageCtrlSelectColor;
}



- (UIImageView *)currentImageView {
    if (self.arrImgViewCachePool.count != 0) {
        _currentImageView = [self.arrImgViewCachePool cd_safeObjectAtIndex:self.pageControl.currentPage];
    }
    return _currentImageView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWith = self.scrollView.frame.size.width;
    self.pageControl.currentPage = floor((self.scrollView.contentOffset.x - pageWith/([self.arrImageUrl count]+2))/pageWith);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWith = self.scrollView.frame.size.width;
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - pageWith/ (self.arrImageUrl.count+2)) / pageWith) + 1;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.arrImageUrl.count, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }else if(currentPage == self.arrImageUrl.count + 1){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_tempPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * self.arrImageUrl.count, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }else if(_tempPage == self.arrImageUrl.count){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self p_invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startScroll];
}

#pragma mark - ACTIONS
- (void)ImageClick:(UITapGestureRecognizer *)recognizer{
    if (self.imageClickBlock) {
        self.imageClickBlock(recognizer.view.tag-kMiddleImageTag);
    }
}

#pragma mark - public
- (void)setupImageLinkArray:(NSArray *)imageLinkArray{
    if (!imageLinkArray || imageLinkArray.count==0) { return; }
    [self.arrImageUrl removeAllObjects];
    [self.arrImageUrl addObjectsFromArray:imageLinkArray];
    self.pageControl.numberOfPages=_arrImageUrl.count;
    self.pageControl.currentPage=0;
    self.scrollView.scrollEnabled =_arrImageUrl.count > 1;
    [self p_layoutScrollViewSubviews];
}

- (void)startScroll{
    if (self.isOpenAutoScroll) {
        [self p_startTimer];
    }
}

#pragma mark - private
- (void)p_scrollToNextPage{
    NSInteger page = self.pageControl.currentPage;
    _tempPage = ++page;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * (page + 1), 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
}

- (void)p_startTimer{
    [self p_invalidateTimer];
    _timer = [NSTimer timerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(p_scrollToNextPage)userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)p_invalidateTimer{
    [_timer invalidate];
    _timer=nil;
}

- (void)p_layoutScrollViewSubviews{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i=0; i<self.arrImageUrl.count+2; i++) {
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
        if (i==self.arrImageUrl.count) {
            scrollImg.tag=kFrontImageTag;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageUrl[self.arrImageUrl.count - 1]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }else if (i==self.arrImageUrl.count+1){
            scrollImg.tag=kBehindImageTag;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageUrl[0]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }else{
            scrollImg.tag = kMiddleImageTag + i;
            [scrollImg sd_setImageWithURL:[NSURL URLWithString:self.arrImageUrl[i]] placeholderImage:[UIImage imageNamed:self.placeHolderImage]];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)];
        [scrollImg addGestureRecognizer:tap];
        
        [self.scrollView addSubview:scrollImg];
    }
    [self setNeedsLayout];
}

#pragma mark - lazyload
- (NSMutableArray *)arrImageUrl{
    if (_arrImageUrl == nil) {
        _arrImageUrl = [NSMutableArray array];
    }
    return _arrImageUrl;
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

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidden=YES;
        _pageControl.hidesForSinglePage=YES;
    }
    return _pageControl;
}

@end
