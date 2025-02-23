//
//  LessonViewForAWeek.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "LessonViewForAWeek.h"
#import "ClassDetailViewShower.h"
#import "DLReminderViewController.h"

@interface LessonViewForAWeek()<LessonViewAddNoteDelegate>
//@property (nonatomic,strong)UIScrollView *scrollView;

/// 用这个类来显示课详情，懒加载
@property(nonatomic,strong)ClassDetailViewShower *detailViewShower;
@property(nonatomic,assign)BOOL isNoCourse;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *nothingLabel;
@end


@implementation LessonViewForAWeek

- (instancetype)initWithDataArray:(NSArray*)weekDataArray{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, 0.90315*MAIN_SCREEN_W, 1.79926*MAIN_SCREEN_W);
        
        self.weekDataArray = weekDataArray;
        
        self.lessonViewsArray = [NSMutableArray array];
        self.isNoCourse = YES;
        self.notedLessonViewArray = [NSMutableArray array];
        [self addBackgroundView];
    }
    return self;
}

/// 添加一个背景图片和一片寂静的label
- (void)addBackgroundView{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"寂静"]];
    self.imgView = imgView;
    [self addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-0.2294*MAIN_SCREEN_W);
        make.top.equalTo(self).offset(MAIN_SCREEN_W*0.45);
        make.width.mas_equalTo(MAIN_SCREEN_W*0.53867);
        make.height.mas_equalTo(MAIN_SCREEN_W*0.34667);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    self.nothingLabel = label;
    [self addSubview:label];
    label.text = @"一片寂静";
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#112C53" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCLight size: 12];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgView);
        make.top.equalTo(imgView.mas_bottom).offset(0.04267*MAIN_SCREEN_W);
    }];
  
}

/// 把所有按钮的参数都配置好，并加入superView,外界调用，调用前确保self.week、self.schType已赋值
- (void)setUpUI{
    for (int i=0; i<7; i++) {
        
        NSMutableArray <LessonView*> *dayLessonViewsArray = [NSMutableArray array];
        for (int j=0; j<6; j++){
            
            NSArray *lessonDateArray = self.weekDataArray[i][j];
            
            LessonView *lessonView = [[LessonView alloc] init];
            lessonView.schType = self.schType;
            if([dayLessonViewsArray lastObject].period>2){
                lessonView.noteShowerDelegate = [dayLessonViewsArray lastObject];
            }
            if(lessonDateArray.count!=0){//非空课
                lessonView.isEmptyLesson = NO;
                lessonView.courseDataDictArray = self.weekDataArray[i][j];
                self.isNoCourse = NO;
            }else{//空课
                lessonView.isEmptyLesson = YES;
                lessonView.emptyClassDate = @{
                    @"hash_day":[NSNumber numberWithInt:i],
                    @"hash_lesson":[NSNumber numberWithInt:j],
                    @"period":[NSNumber numberWithInt:2],
                    @"week":[NSString stringWithFormat:@"%d",self.week],
                };
            }
            lessonView.delegate = self.detailViewShower;
            lessonView.addNoteDelegate = self;
            [lessonView setUpData];
            [self addSubview:lessonView];
            [dayLessonViewsArray addObject:lessonView];
        }
        [self.lessonViewsArray addObject:dayLessonViewsArray];
    }
    
    [self judgeIfShowEmptyImg];
}
//emptyLessonData 结构：
//@"hash_day":[NSNumber numberWithInt:i],
//@"hash_lesson":[NSNumber numberWithInt:j],
//@"period":[NSNumber numberWithInt:2],
//@"week":[NSString stringWithFormat:@"%d",self.week],
- (void)addNoteWithEmptyLessonData:(NSDictionary *)emptyLessonData{
    DLReminderViewController *reminderVC = [[DLReminderViewController alloc] init];
    reminderVC.remind = emptyLessonData;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:reminderVC];
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [nav setModalPresentationStyle:(UIModalPresentationCustom)];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}

-(ClassDetailViewShower *)detailViewShower{
    if(_detailViewShower==nil){
        _detailViewShower = [[ClassDetailViewShower alloc] init];
        [_detailViewShower setFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H)];
    }
    return _detailViewShower;
}

//self.lessonViewsArray[i][j]代表(星期i+1)的(第j+1节大课)的LessonView控件
/// 由课表控制器调用，调用后根据model的信息在本周课表view的相应位置加备忘
/// @param model 数据model
- (void)addNoteLabelWithNoteDataModel:(NoteDataModel*)model{
    NSNumber *weekNum,*lessonNum;
    LessonView *lv;
    for (NSDictionary *timeDict in model.timeDictArray) {
        weekNum = timeDict[@"weekNum"];//星期weekNum
        lessonNum = timeDict[@"lessonNum"];//第lessonNum节大课
        
        //lv是周（weekNum+1），第（lessonNum+1）节大课的LessonView
        lv = self.lessonViewsArray[weekNum.intValue][lessonNum.intValue];
        
        if (![self.notedLessonViewArray containsObject:lv]) {
            [self.notedLessonViewArray addObject:lv];
        }
        
        //配置数据
        [lv.noteDataModelArray addObject:model];
        
        //根据数据设置UI
        [lv setUpData];
    }
    [self judgeIfShowEmptyImg];
}

/// 判断是否显示"一片寂静图片"
- (void)judgeIfShowEmptyImg{
    if(self.isNoCourse==YES&&(self.notedLessonViewArray.count==0)){
        self.nothingLabel.hidden =
        self.imgView.hidden = NO;
    }else{
        self.nothingLabel.hidden =
        self.imgView.hidden = YES;
    }
}
//NoteDataModel.timeDictArray的结构：
/// @[
///     @{@"weekNum":@0,  @"lessonNum":@2},
///     @{@"weekNum":@1,  @"lessonNum":@0}
/// ]
///代表某周的周一 第3节大课和周二的第一节大课的备忘


- (void)deleteNoteWithNoteDataModel:(NoteDataModel*)model {
    NSNumber *weekNum,*lessonNum;
    LessonView *lv;
    for (NSDictionary *timeDict in model.timeDictArray) {
        weekNum = timeDict[@"weekNum"];//星期weekNum
        lessonNum = timeDict[@"lessonNum"];//第lessonNum节大课
        
        //lv是周（weekNum+1），第（lessonNum+1）节大课的LessonView
        lv = self.lessonViewsArray[weekNum.intValue][lessonNum.intValue];
        
        //配置数据
        [lv.noteDataModelArray removeObject:model];
        if (lv.isNoted==NO) {
            [self.notedLessonViewArray removeObject:lv];
        }
        //根据数据设置UI
        [lv setUpData];
    }
    [self judgeIfShowEmptyImg];
}

- (void)eidtNoteLabelWithNoteDataModelDict:(NSDictionary*)modelDict {
    NoteDataModel *new = modelDict[@"new"];
    NoteDataModel *old = modelDict[@"new"];
    [self deleteNoteWithNoteDataModel:old];
    [self addNoteLabelWithNoteDataModel:new];
}
@end
