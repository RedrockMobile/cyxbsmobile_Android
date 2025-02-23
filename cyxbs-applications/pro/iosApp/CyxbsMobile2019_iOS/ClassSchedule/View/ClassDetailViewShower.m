//
//  ClassDetailViewShower.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//完成显示备忘弹窗、某课详情弹窗操作的类

#import "ClassDetailViewShower.h"
#import "ClassDetailView.h"
#import "NoteDetailView.h"

@interface ClassDetailViewShower()<NoteDetailViewDelegate,UIScrollViewDelegate>

/// scrollView的背景view，弹窗
@property(nonatomic,strong)UIView *backViewOfScrollView;

@property(nonatomic,strong)UIScrollView *scrollView;

/// 分页控制器
@property(nonatomic,strong)UIPageControl *PC;

/// 定时器
@property(nonatomic,strong)NSTimer *timer;

/// 当有timer在时，全屏大小的一个view，点击它后会invalid timer
@property(nonatomic,strong)UIView *backViewToStopTimer;

@end
@implementation ClassDetailViewShower

//MARK:-重写的方法
- (instancetype)init{
    self = [super init];
    if(self){
        //添加scrollView的背景view
        [self addBackViewOfScrollView];
        
        //添加scrollView
        [self addScrollView];
        
        //添加分页控制器
        [self addPC];
        
        //添加一个点击后就移除self的方法，backViewOfScrollView会加一个空的点击手势，
        //避免点击弹窗后弹窗被移除
        UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetail)];
        [self addGestureRecognizer:TGR];
    }
    return self;
}


//MARK:-添加子控件的方法
/// 添加scrollView的背景view
- (void)addBackViewOfScrollView{
    UIView *view = [[UIView alloc] init];
    self.backViewOfScrollView = view;
    [self addSubview:view];
    
    view.layer.shadowOffset = CGSizeMake(0,2.5);
    view.layer.shadowRadius = 15;
    view.layer.shadowOpacity = 0.3;
    view.layer.cornerRadius = 16;
    [view setFrame:CGRectMake(0, MAIN_SCREEN_H, MAIN_SCREEN_W, DETAILVIEW_H)];
    
    //加一个空手势，避免点击弹窗后弹窗被移除
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender){ }]];
    
    if (@available(iOS 11.0, *)) {
        view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
}

/// 添加scrollView
- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    [self.backViewOfScrollView addSubview:scrollView];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.layer.cornerRadius = 16;
    scrollView.layer.masksToBounds = YES;
    [self.scrollView setFrame:CGRectMake(0, 0, MAIN_SCREEN_W, DETAILVIEW_H)];
}

/// 添加分页控制器
- (void)addPC{
    UIPageControl *PC = [[UIPageControl alloc] init];
    self.PC = PC;
    [self.backViewOfScrollView addSubview:PC];
    PC.currentPage = 0;
    PC.numberOfPages = self.courseDataDictArray.count+self.noteDataModelArray.count;
    PC.hidesForSinglePage = YES;
//    PC.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#5599FF"];
    
    if (@available(iOS 11.0, *)) {
        PC.currentPageIndicatorTintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#92A9EC" alpha:1] darkColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1]];
    } else {
        PC.currentPageIndicatorTintColor = [UIColor colorWithRed:184/255.0 green:82/255.0 blue:255/255.0 alpha:1];
    }
    PC.pageIndicatorTintColor = [UIColor colorWithHexString:@"#969696"];
    PC.hidden = NO;
    
    [PC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backViewOfScrollView);
        make.top.equalTo(self.backViewOfScrollView).offset(DETAILVIEW_H*0.82);
    }];
}


//MARK:-代理方法
/// LessonViewDelegate要求的代理方法，点击某一节有备忘或者有课的课后调用，作用：弹出弹窗
- (void)showDetail{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    int i,j,count;
    count = (int)self.courseDataDictArray.count;
    self.PC.numberOfPages = 0;
    self.PC.numberOfPages+=count;
    
    for (i=0; i<count; i++) {
        NSDictionary *dataDict = self.courseDataDictArray[i];
        ClassDetailView *detailView = [[ClassDetailView alloc] init];
        //已经重写了ClassDetailView的setDataDict方法，对dataDict赋值，自动完成对内部label文字的设置
        detailView.dataDict = dataDict;
        [detailView setFrame:CGRectMake(i*MAIN_SCREEN_W, 0, MAIN_SCREEN_W, DETAILVIEW_H)];
        [self.scrollView addSubview:detailView];
        
    }
    
    count = (int)self.noteDataModelArray.count;
    self.PC.numberOfPages+=count;
    for (j=0; j<count; j++) {
        
        NoteDataModel *model = self.noteDataModelArray[j];
        NoteDetailView *detailView = [[NoteDetailView alloc] init];
        detailView.hideDetailDelegate = self;
        [detailView setFrame:CGRectMake((i+j)*MAIN_SCREEN_W, 0, MAIN_SCREEN_W, DETAILVIEW_H)];
        //已经重写了NoteDetailView的setDataModel方法，对dataModel赋值，
        //自动完成对内部label文字的设置
        detailView.dataModel = model;
        [self.scrollView addSubview:detailView];
    }
    
    self.scrollView.contentSize = CGSizeMake((i+j)*MAIN_SCREEN_W, 0);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.backViewOfScrollView setFrame:CGRectMake(0, MAIN_SCREEN_H-DETAILVIEW_H+10, MAIN_SCREEN_W, DETAILVIEW_H+40)];
    } completion:^(BOOL is){
        //判断是否已经展示过功能，不为空，则展示过。
        if([NSUserDefaults.standardUserDefaults stringForKey:@"isClassDetailViewShower_Displayed"]!=nil)return;
        if(self.PC.numberOfPages!=1){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self displayOnce];
                [NSUserDefaults.standardUserDefaults setValue:@"YES" forKey:@"isClassDetailViewShower_Displayed"];
            });
        }
    }];
    
}

/// NoteDetailViewDelegate要求的代理方法，点击后面的空白处、点击删除或者修改按钮后调用，作用：移除弹窗
- (void)hideDetail{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.backViewOfScrollView setFrame:CGRectMake(0, MAIN_SCREEN_H, MAIN_SCREEN_W, DETAILVIEW_H)];
    }completion:^(BOOL finished) {
        self.scrollView.contentOffset = CGPointZero;
        [self.scrollView removeAllSubviews];
        [self removeFromSuperview];
    }];
    
}

//scrollView的代理方法，用来刷新分页控制器的页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.PC.currentPage = (NSInteger)self.scrollView.contentOffset.x/MAIN_SCREEN_W;
}

/// 在showDetail方法里，判断用户是第一次安装掌邮后，会调用这个方法展示课详情的滑动功能
- (void)displayOnce{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(self.scrollView.contentOffset.x+self.scrollView.frame.size.width<self.scrollView.contentSize.width){
            [UIView animateWithDuration:0.6 animations:^{
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x+self.scrollView.frame.size.width, 0);
            }];
            self.PC.currentPage++;
        }else{
            if(self.timer!=nil){
                [self.timer invalidate];
                self.timer = nil;
                [self.backViewToStopTimer removeFromSuperview];
                self.backViewToStopTimer = nil;
            }
        }
    }];
    [self.timer fire];
    
    //______________下面是创建一个全屏的背景view，点击它会invalid timer______________
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
    self.backViewToStopTimer = view;
    [self addSubview:view];
    
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(self.timer!=nil){
            [self.timer invalidate];
            self.timer = nil;
            [self.backViewToStopTimer removeFromSuperview];
            self.backViewToStopTimer = nil;
        }
    }];
    [view addGestureRecognizer:TGR];
}
@end



