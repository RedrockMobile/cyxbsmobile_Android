//
//  CQUPTMapBeforeSearch.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/12.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapSearchView.h"
#import "CQUPTMapBeforeSearchCell.h"
#import "CQUPTMapSearchResultCell.h"
#import "CQUPTMapDataItem.h"
#import "CQUPTMapPlaceItem.h"
#import "CQUPTMapSearchItem.h"
#import "CQUPTMapContentView.h"
#import "UserDefaultTool.h"

@interface CQUPTMapSearchView () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, weak) UILabel *historyLabel;
@property (nonatomic, weak) UIButton *clearAllButton;
//@property (nonatomic, weak) UITableView *historyTableView;    // 声明在头文件中

//@property (nonatomic, weak) UITableView *resultTableView;     // 声明在头文件中

@property (nonatomic, copy) NSArray *historyArray;
@property (nonatomic, copy) NSArray<CQUPTMapPlaceItem *> *resultArray;

@end



@implementation CQUPTMapSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.historyArray = [[UserDefaultTool valueWithKey:Discover_cquptMapHistoryKey_String] copy];
        
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        
        UILabel *historyLabel = [[UILabel alloc] init];
        historyLabel.text = @"历史记录";
        historyLabel.font = [UIFont fontWithName:PingFangSCMedium size:15];
        [self addSubview:historyLabel];
        self.historyLabel = historyLabel;
        
        
        UIButton *clearAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [clearAllButton setTitle:@"清除全部" forState:UIControlStateNormal];
        clearAllButton.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:11];
        [clearAllButton addTarget:self action:@selector(clearAllHistory) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearAllButton];
        self.clearAllButton = clearAllButton;
        
        
        UITableView *historyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        historyTableView.rowHeight = 37;
        historyTableView.dataSource = self;
        historyTableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            historyTableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
        } else {
            historyTableView.backgroundColor = [UIColor whiteColor];
        }
        historyTableView.tableFooterView = [[UIView alloc] init];
        historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:historyTableView];
        self.historyTableView = historyTableView;
        
        
        if (@available(iOS 11.0, *)) {
            historyLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#234780" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]];
            [clearAllButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#ABBCD8" alpha:1] darkColor:[UIColor colorWithHexString:@"#979797" alpha:1]] forState:UIControlStateNormal];
        } else {
            historyLabel.textColor = [UIColor colorWithHexString:@"#778AA9"];
            [clearAllButton setTitleColor:[UIColor colorWithHexString:@"#ABBCD8"] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(34);
    }];
    
    [self.clearAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.historyLabel);
        make.trailing.equalTo(self).offset(-15);
        make.width.equalTo(@45);
        make.height.equalTo(@11);
    }];
    
    [self.historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.historyLabel.mas_bottom).offset(11);
    }];
}


#pragma mark - tableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.historyTableView) {
        return self.historyArray.count;
    } else {
        return self.resultArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.historyTableView) {
        CQUPTMapBeforeSearchCell *cell = [[CQUPTMapBeforeSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[@(indexPath.row) stringValue]];
        cell.titleLabel.text = self.historyArray[indexPath.row];
        [cell.deleteButton addTarget:self action:@selector(deleteAHistory:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        CQUPTMapSearchResultCell *cell = [[CQUPTMapSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[@(indexPath.row) stringValue]];
        cell.titleLabel.text = self.resultArray[indexPath.row].placeName;
        return cell;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.viewController.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.historyTableView) {
        CQUPTMapBeforeSearchCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ((CQUPTMapContentView *)(self.superview)).searchBar.text = cell.titleLabel.text;
        if ([((CQUPTMapContentView *)(self.superview)).delegate respondsToSelector:@selector(searchPlaceWithString:)]) {
            [((CQUPTMapContentView *)(self.superview)).delegate searchPlaceWithString:cell.titleLabel.text];
        }
    } else {
        if ([((CQUPTMapContentView *)(self.superview)).delegate respondsToSelector:@selector(requestPlaceDataWithPlaceID:)]) {
            [((CQUPTMapContentView *)(self.superview)).delegate requestPlaceDataWithPlaceID:self.resultArray[indexPath.row].placeId];
        }
        [((CQUPTMapContentView *)(self.superview)) selectedAPlace:self.resultArray[indexPath.row]];
        [((CQUPTMapContentView *)(self.superview)) cancelSearch];
        [((CQUPTMapContentView *)(self.superview)) endEditing:YES];
    }
}


- (void)searchPlaceSuccess:(NSArray<CQUPTMapSearchItem *> *)placeIDArray {
    NSError *error = nil;
    NSData *archiveData = [NSData dataWithContentsOfFile:[CQUPTMapDataItem archivePath]];
    CQUPTMapDataItem *mapData = [NSKeyedUnarchiver unarchivedObjectOfClass:[CQUPTMapDataItem class] fromData:archiveData error:&error];
    if (error) {
        // 处理错误情况
        NSLog(@"Unarchive Error: %@", error);
    }
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSString *placeID in placeIDArray) {
        for (CQUPTMapPlaceItem *place in mapData.placeList) {
            if (placeID.intValue == [place.placeId intValue]) {
                [tmpArray addObject:place];
            }
        }
    }
    self.resultArray = [tmpArray copy];
    
    if (!self.resultTableView) {
        UITableView *resultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        resultTableView.rowHeight = 37;
        resultTableView.dataSource = self;
        resultTableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            resultTableView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
        } else {
            resultTableView.backgroundColor = [UIColor whiteColor];
        }
        resultTableView.tableFooterView = [[UIView alloc] init];
        resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        resultTableView.alpha = 0;
        [self addSubview:resultTableView];
        self.resultTableView = resultTableView;
        
        
        [resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.top.equalTo(self).offset(34);
        }];
    }
    [self.resultTableView reloadData];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.historyTableView.alpha = 0;
        self.resultTableView.alpha = 1;
    } completion:^(BOOL finished) {
        self.historyArray = [[UserDefaultTool valueWithKey:Discover_cquptMapHistoryKey_String] copy];
        [self.historyTableView reloadData];
    }];
}


#pragma mark - 删除记录
- (void)clearAllHistory {
    [UserDefaultTool saveValue:@[] forKey:Discover_cquptMapHistoryKey_String];
    self.historyArray = @[];
    [self.historyTableView reloadData];
}

- (void)deleteAHistory:(UIButton *)sender {
    NSString *removeData = ((CQUPTMapBeforeSearchCell *)(sender.superview.superview)).titleLabel.text;
    
    NSMutableArray *historys = [[UserDefaultTool valueWithKey:Discover_cquptMapHistoryKey_String] mutableCopy];
    [historys removeObject:removeData];
    
    [UserDefaultTool saveValue:historys forKey:Discover_cquptMapHistoryKey_String];
    
    self.historyArray = historys;
    
    [self.historyTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationFade];
}

@end
