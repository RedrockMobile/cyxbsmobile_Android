//
//  SSRTextCycleView.m
//  SSRSwipe
//
//  Created by SSR on 2022/4/11.
//

#import "SSRTextCycleView.h"

#pragma mark - TextCycleViewDelegateFlags

typedef struct {
    
    /// textCycleView:setCellStyle:forIndex:
    BOOL cellForIndex;
    
} TextCycleViewDelegateFlags;

#pragma mark - TextCycleView ()

@interface SSRTextCycleView ()

/// 计时器控件
@property (nonatomic, weak) NSTimer *timer;

/// delegateFlags
@property (nonatomic) TextCycleViewDelegateFlags delegateFlags;

/// 当前第几个
@property (nonatomic) NSInteger page;

@end

#pragma mark - TextCycleView

@implementation SSRTextCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.page = 0;
        self.autoTimeInterval = 2;
    }
    return self;
}

#pragma mark - Method

// rewrite

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self endTimer];
    }
}

// private

- (void)startTimer {
    [self endTimer];
    
    NSTimer *timer =
    [NSTimer
     scheduledTimerWithTimeInterval:self.autoTimeInterval
     target:self
     selector:@selector(textCycleView_autoScroll)
     userInfo:nil
     repeats:YES];
    
    _timer = timer;
}

- (void)endTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)textCycleView_autoScroll {
    if (self.page >= self.textAry.count) {
        self.page = 0;
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.page + 1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    self.page = self.page + 1;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.textCycleView_delegate) {
        [self.textCycleView_delegate textCycleView:self didSelectedAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 无数据，不循环，1个始终
    if (self.textAry == nil || self.textAry.count <= 1) {
        [self endTimer];
        return 1;
    }else {
    // 如果有数据，那就开循环
        [self startTimer];
        return self.textAry.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 有代理则代理确定，无代理则默认
    if (self.textCycleView_delegate
        && self.delegateFlags.cellForIndex) {

        SSRTextCycleCell *cell = [self.textCycleView_delegate
                textCycleView:self
                cellForIndex:indexPath.row];
        if (self.textAry.count != 0) {
            cell.ssrTextLab.text = self.textAry[indexPath.row % self.textAry.count];
        }
        return cell;
    }
    
    SSRTextCycleCell *cell = [self dequeueReusableCellWithIdentifier:SSRTextCycleCellReuseIdentifier];
    if (cell == nil) {
        cell = [[SSRTextCycleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SSRTextCycleCellReuseIdentifier];
    }
    cell.ssrTextLab.text = self.textAry[indexPath.row % self.textAry.count];
    return cell;
}

#pragma mark - Setter

- (void)setTextCycleView_delegate:
    (id<TextCycleViewDelegate>)textCycleView_delegate {
    _textCycleView_delegate = textCycleView_delegate;
    
    if ([_textCycleView_delegate respondsToSelector:@selector(textCycleView:cellForIndex:)]) {
        self->_delegateFlags.cellForIndex = YES;
    }
}

- (void)setTextAry:(NSArray<NSString *> *)textAry {
    _textAry = textAry.copy;
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    [self reloadData];
}


@end
