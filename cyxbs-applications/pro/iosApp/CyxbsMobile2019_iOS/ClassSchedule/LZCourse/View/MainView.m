//
//  MainView.m
//  Demo
//
//  Created by 李展 on 2016/10/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "MainView.h"
#import "DayLabel.h"
#import "LessonButton.h"
#import "LessonNumLabel.h"
@interface MainView()
@property (nonatomic, copy) NSArray *weekDay;
@property (nonatomic, strong) DayLabel *monthLabel;
@property (nonatomic, strong) NSMutableArray<DayLabel *> *dayLabels;
@property (nonatomic, strong) NSMutableArray<LessonNumLabel *> *lessonsLabel;
@end

@implementation MainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.weekDay = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",@"周日"];
        [self initDayLb];
        [self initMainScrollView];
        [self initLessonLb];
//        [self initLeesonBtn];
    }
    return self;
}


- (void)initDayLb{
    self.monthLabel = [[DayLabel alloc]initWithFrame:CGRectMake(0, 0, MWIDTH, MHEIGHT)];
    self.monthLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
    [self addSubview:self.monthLabel];
    
    CGFloat dayLbHeight = MHEIGHT;
    CGFloat dayLbWidth = floor(self.frame.size.width-MWIDTH)/DAY;
    self.dayLabels = [NSMutableArray arrayWithCapacity:DAY];
    for (int i = 0; i < DAY; i++) {
        self.dayLabels[i] = [[DayLabel alloc]initWithFrame:CGRectMake(MWIDTH+i*dayLbWidth, 0,dayLbWidth, dayLbHeight)];
        self.dayLabels[i].text = self.weekDay[i];
        [self addSubview:self.dayLabels[i]];
    }
    [self loadDayLbTimeWithWeek:0 nowWeek:0];
}

- (void)loadDayLbTimeWithWeek:(NSInteger)week nowWeek:(NSInteger)nowWeek{
    if (week == 0) {
        [self removeDayLbTime];
        return;
    }
    
    NSDate *now = [NSDate date];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    [monthFormatter setDateFormat:@"MM"];
    [dayFormatter setDateFormat:@"dd"];

    
    NSTimeInterval  oneDay = 24*60*60;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:now];
    for (int i = 0; i < DAY; i++) {
        NSTimeInterval timeInterval = ((week-nowWeek)*7+(i-(components.weekday+5)%7))*oneDay;
        NSDate *date = [NSDate dateWithTimeInterval:timeInterval sinceDate:now];
        if (i == 0) {
            self.monthLabel.text = [[monthFormatter stringFromDate:date] stringByAppendingString:@"月"];
        }
        NSString *day = [dayFormatter stringFromDate:date];
        if (i != 0 && [day isEqualToString:@"01"]) {
            day = [[monthFormatter stringFromDate:date] stringByAppendingString:@"月"];
        }
        self.dayLabels[i].text = [NSString stringWithFormat:@"%@\n%@",self.weekDay[i],day];
        if (i == (components.weekday+5)%7) {
            if (nowWeek == week) {
                self.dayLabels[i].textColor = [UIColor colorWithHexString:@"#7097FA"];
            }
            else{
                self.dayLabels[i].textColor = [UIColor colorWithHexString:@"#8395A4"];
            }
//            [UserDefaultTool saveValue:[NSString stringWithFormat:@"%d",i] forKey:@"weekDayNum"];
        }
    }
}


- (void)removeDayLbTime{
    self.monthLabel.text = @" ";
    for (int i = 0; i < DAY; i++) {
        self.dayLabels[i].text = self.weekDay[i];
//        self.dayLabels[i].textColor = [UIColor blackColor];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    CGSize size = CGSizeZero;
    for (UIView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[UIView class]]) {
            size = view.frame.size;
            break;
        }
    }
    self.scrollView.frame = CGRectMake(0, MHEIGHT, self.frame.size.width, self.frame.size.height-MHEIGHT);
    for (UIView *view in self.scrollView.subviews){
        if ([view isMemberOfClass:[UIView class]]) {
            CGRect frame = view.frame;
            frame.size = size;
            view.frame = frame;
        }
    }
    // 改变scrollView的frame后 view的frame会变化  为了保持frame不变化
}

- (void)initMainScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MHEIGHT, self.frame.size.width, self.frame.size.height-MHEIGHT)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, LESSONBTNSIDE*LESSON);
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
}

- (void)initLessonLb{
    for (int i = 1; i <= LESSON; i++) {
        LessonNumLabel *lessonLb = [[LessonNumLabel alloc]initWithFrame:CGRectMake(0, floor(LESSONBTNSIDE)*(i-1), MWIDTH, floor(LESSONBTNSIDE))];
        lessonLb.text = [NSString stringWithFormat:@"%d",i];
        [self.scrollView addSubview:lessonLb];
    }
}


//- (void)initLeesonBtn{
//    self.lessonBtns = [NSMutableArray array];
//    for (int i = 0; i<DAY; i++) {
//        for (int j = 0; j<LESSON/2; j++) {
//            LessonButton *lessonBtn = [[LessonButton alloc]initWithFrame:CGRectMake(MWIDTH+i*LESSONBTNSIDE+i*SEGMENT, j*LESSONBTNSIDE*2+j*SEGMENT, LESSONBTNSIDE, LESSONBTNSIDE*2)];
////            lessonBtn.backgroundColor = [UIColor whiteColor];
//            [self.scrollView addSubview:lessonBtn];
//            [self.lessonBtns addObject:lessonBtn];
//        }
//    }
//}


@end
