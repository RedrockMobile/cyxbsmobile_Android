//
//  DetailsTasksTableView.m
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsTasksTableView.h"
// views
#import "DetailsTaskTableViewCell.h"
// models

@interface DetailsTasksTableView ()
<UITableViewDataSource>

@end

@implementation DetailsTasksTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    self.rowHeight = 74;
    
    [self registerClass:[DetailsTaskTableViewCell class] forCellReuseIdentifier:(DetailsTaskTableViewCell.reuseIdentifier)];
}

#pragma mark - setter

- (void)setDataAry:(NSMutableArray *)dataAry {
    _dataAry = dataAry;
    [self reloadData];
}

#pragma mark - delegate
//MARK:table view delegate & data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsTaskTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DetailsTaskTableViewCell.reuseIdentifier];
    
//    cell.cellModel = self.dataAry[indexPath.row];
    
    return cell;
}

@end
