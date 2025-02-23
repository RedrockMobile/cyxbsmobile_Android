//
/*
 *                                                     __----~~~~~~~~~~~------___
 *                                    .  .   ~~//====......          __--~ ~~
 *                    -.            \_|//     |||\\  ~~~~~~::::... /~
 *                 ___-==_       _-~o~  \/    |||  \\            _/~~-
 *         __---~~~.==~||\=_    -_--~/_-~|-   |\\   \\        _/~
 *     _-~~     .=~    |  \\-_    '-~7  /-   /  ||    \      /
 *   .~       .~       |   \\ -_    /  /-   /   ||      \   /
 *  /  ____  /         |     \\ ~-_/  /|- _/   .||       \ /
 *  |~~    ~~|--~~~~--_ \     ~==-/   | \~--===~~        .\
 *           '         ~-|      /|    |-~\~~       __--~~
 *                       |-~~-_/ |    |   ~\_   _-~            /\
 *                            /  \     \__   \/~                \__
 *                        _--~ _/ | .-~~____--~-/                  ~~==.
 *                       ((->/~   '.|||' -_|    ~~-/ ,              . _||
 *                                  -_     ~\      ~~---l__i__i__i--~~_/
 *                                  _-~-__   ~)  \--______________--~~
 *                                //.-~~~-~_--~- |-------~~~~~~~~
 *                                       //.-~~~--\
 *                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 *                               神兽保佑            永无BUG
 */
//  FoodVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/2/15.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodVC.h"
#import "FoodMainPageCollectionViewCell.h"
#import "FoodHeaderCollectionReusableView.h"
#import "FoodHomeModel.h"
#import "FoodRefreshModel.h"
#import "FoodResultModel.h"
#import "FoodDetailsModel.h"
#import "popUpInformationVC.h"
#import "popFoodResultVC.h"
#import "UDScrollAnimationView.h"
#import "MXObjCBackButton.h"
//需要使用swift的邮票任务管理类
#import "掌上重邮-Swift.h"

#define singleFoodDuration 0.18//单个食物滚动时间

@interface FoodVC ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

/// 头视图
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;

/// Home数据模型
@property (nonatomic, strong) FoodHomeModel *homeModel;
/// 美食结果模型
@property (nonatomic, strong) FoodResultModel *resultModel;

/// 返回条
@property (nonatomic, strong) UIView *goBackView;
@property (nonatomic, strong) UILabel *titleLabel;

/// 随机滚动视图
@property (nonatomic, strong) UDScrollAnimationView *resultView;
@property (nonatomic, strong) UIButton *getResultBtn;
@property (nonatomic, strong) UIButton *getInfoBtn;
@property (nonatomic, strong) UIButton *getOtherBtn;
@property (nonatomic, strong) NSMutableOrderedSet *foodNumSet;
@property (nonatomic, assign) NSInteger foodNum;

/// 选中标签
@property (nonatomic, copy) NSDictionary *selectLabelDictionary;
@end

@implementation FoodVC{
    NSMutableArray <NSArray *> *_homeMary;
}
#pragma mark - ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addGoBackView];
    //获取主页数据,成功加载主页 失败加载失败页
    [self loadHomeData];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self._getAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self._getAry[section].count;
}

//具体数据
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodMainPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FoodMainPageCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    [cell.lab setText:[NSString stringWithFormat:@"%@", self._getAry[indexPath.section][indexPath.item]]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    // 区头
    if (kind == UICollectionElementKindSectionHeader) {
        FoodHeaderCollectionReusableView *headerView = (FoodHeaderCollectionReusableView *) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0:
                headerView.titleText = @"就餐区域";
                headerView.otherText = @"可多选";
                headerView.refreshBtn.hidden = YES;
                break;
            case 1:
                headerView.titleText = @"就餐人数";
                headerView.otherText = @"仅可选择一个";
                headerView.refreshBtn.hidden = YES;
                break;
            case 2:
                headerView.titleText = @"餐饮特征";
                headerView.otherText = @"可多选";
                headerView.refreshBtn.hidden = NO;
                [headerView.refreshBtn addTarget:self action: @selector(refresh) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        reusableView = headerView;
        return reusableView;
    }
    return nil;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //设置单选 - 只有section 1是单选 , 其余都是多选
    if (indexPath.section != 1) {
        return;
    }
    NSArray<NSIndexPath *> *selectedIndexes = collectionView.indexPathsForSelectedItems;
    for (int i = 0; i < selectedIndexes.count; i++) {
        NSIndexPath *currentIndex = selectedIndexes[i];
        if (![currentIndex isEqual:indexPath] && currentIndex.section == 1) {
            [collectionView deselectItemAtIndexPath:currentIndex animated:YES];
        }
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
// 设置每个cell的尺寸高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(74, 29);
    return size;
}

// 设置区头的尺寸高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake(SCREEN_WIDTH, 58);
    return size;
}

#pragma mark - Method
- (void)loadHomeData {
    [self.homeModel requestSuccess:^{
        //加载主页数据
        [self addHomePage];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"美食主页数据获取失败:%@",error);
    }];
}

- (void)addHomePage {
    //添加头视图
    [self addTopView];
    //添加主要数据
    [self.view addSubview:self.collectionView];
    //添加脚视图
    [self addFootView];
    //将返回条移至最前
    [self.view bringSubviewToFront:self.goBackView];
    [self layoutSubviews];
}

- (void)addTopView {
    //头视图
    self.collectionView.contentInset = UIEdgeInsetsMake(self.topView.frame.size.height, 0, 0, 0);
    CGRect originFrame = self.topView.frame;
    originFrame.origin.y = -self.topView.frame.size.height;
    self.topView.frame = originFrame;
    self.collectionView.alwaysBounceVertical = true;
    [self.collectionView addSubview:self.topView];
}

- (void)addFootView {
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.getResultBtn];
    [self.view addSubview:self.getInfoBtn];
    [self.view addSubview:self.getOtherBtn];
}

- (void)layoutSubviews {
    //设置为真实高度
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goBackView.mas_bottom).offset(24);
        make.height.equalTo(@(self.collectionView.collectionViewLayout.collectionViewContentSize.height + self.topView.frame.size.height));
        make.width.equalTo(self.view);
    }];
    
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        IS_IPHONEX ? make.top.equalTo(self.collectionView.mas_bottom).offset(51) : make.top.equalTo(self.collectionView.mas_bottom).offset(21);
        make.height.equalTo(@51);
        make.width.equalTo(@238);
    }];
    
    [self.getResultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultView.mas_bottom).offset(18);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@34);
        make.width.equalTo(@91);
    }];
    
    [self.getInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultView.mas_bottom).offset(18);
        make.right.equalTo(self.view.mas_centerX).offset(-6);
        make.height.equalTo(@34);
        make.width.equalTo(@91);
    }];
    
    [self.getOtherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultView.mas_bottom).offset(18);
        make.left.equalTo(self.view.mas_centerX).offset(6);
        make.height.equalTo(@34);
        make.width.equalTo(@91);
    }];
}

//获取选中标签
- (NSDictionary *)getSelection {
    FoodMainPageCollectionViewCell *cell = [[FoodMainPageCollectionViewCell alloc] init];
    NSMutableArray *areaMarry = [[NSMutableArray alloc] init];
    NSString *numStr = [[NSString alloc] init];
    NSMutableArray *propertyMarry = [[NSMutableArray alloc] init];
    for (NSIndexPath *item in self.collectionView.indexPathsForSelectedItems) {
        cell = (FoodMainPageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:item];
        switch (item.section) {
            case 0:
                NSLog(@"第一行选择了%@", cell.lab.text);
                [areaMarry addObject:cell.lab.text];
                break;
            case 1:
                NSLog(@"第二行选择了%@", cell.lab.text);
                numStr = cell.lab.text;
                break;
            case 2:
                NSLog(@"第三选择了%@", cell.lab.text);
                [propertyMarry addObject:cell.lab.text];
                break;
            default:
                break;
        }
    }
    NSDictionary *selection = @{
        @"area": areaMarry,
        @"num": numStr,
        @"property": propertyMarry
    };
    return selection;
}

//刷新标签
- (void)refresh {
    NSDictionary *selection = [self getSelection];
    FoodRefreshModel *refreshModel = [[FoodRefreshModel alloc] init];
    [refreshModel getEat_area:selection[@"area"]
                   getEat_num:selection[@"num"]
               requestSuccess:^{
        [self._getAry removeLastObject];
        [self._getAry addObject:refreshModel.eat_propertyAry];
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        [self.collectionView reloadSections:indexSet];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"美食特征刷新失败");
    }];
}

//获取美食数据
- (void)getResult {
    NSLog(@"上传邮票任务进度");
    [TaskManager.shared uploadTaskProgressWithTitle:@"使用美食板块" stampCount:10 remindText:@"今日已使用美食咨询处1次，获得10张邮票"];
    NSLog(@"获取随机美食结果");
    NSDictionary *selection = [self getSelection];
    self.selectLabelDictionary = selection;
    [self.resultModel getEat_area:selection[@"area"]
                       getEat_num:selection[@"num"]
                  getEat_property:selection[@"property"]
                   requestSuccess:^{
        if (self.resultModel.status == 10100) {
            [self noFound];
        } else if (self.resultModel.status == 10000) {
            NSLog(@"一共有%lu个食物", (unsigned long)self.resultModel.dataArr.count);
            //根据个数确定滚动总时长
            self.resultView.duration = self.resultModel.dataArr.count * singleFoodDuration;
            NSMutableArray *textArr = [[NSMutableArray alloc] init];
            for (FoodDetailsModel *a in self.resultModel.dataArr) {
                [textArr addObject:a.name];
            }
            //滚动数组
            self.resultView.textArr = textArr;
            //随机数(不重复)
            NSInteger count = self.resultModel.dataArr.count;
            NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity:count];
            while (set.count < count) {
                NSInteger value = arc4random() % count;
                [set addObject:[NSNumber numberWithInteger:value]];
            }
            self.foodNumSet = set;
            [self getOther];
            self.getResultBtn.hidden = YES;
            self.getInfoBtn.hidden = NO;
            self.getOtherBtn.hidden = NO;
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"获取随机美食结果失败");
    }];
}

//"换一个"
- (void)getOther {
    NSDictionary *selection = [self getSelection];
    if ([self.selectLabelDictionary isEqualToDictionary:selection]) {
        if (self.foodNumSet.firstObject) {
            self.foodNum = [self.foodNumSet.firstObject intValue];
            self.resultView.finalText = self.resultModel.dataArr[self.foodNum].name;
            [self.resultView startAnimation];
            [self.foodNumSet removeObject:self.foodNumSet.firstObject];
        } else {
            [self foodOut];
        }
    }else {
        [self getResult];
    }
    
}

//获取美食详情
- (void)getInfo {
    popFoodResultVC *vc = [[popFoodResultVC alloc] init];
    vc.praiseBlock = ^(NSInteger praiseNum, BOOL isPraise) {
        self.resultModel.dataArr[self.foodNum].praise_num = praiseNum;
        self.resultModel.dataArr[self.foodNum].praise_is = isPraise;
    };
    vc.foodNameText = self.resultModel.dataArr[self.foodNum].name;
    vc.contentText = self.resultModel.dataArr[self.foodNum].introduce;
    vc.ImgURL = self.resultModel.dataArr[self.foodNum].pictureURL;
    vc.praiseNum = self.resultModel.dataArr[self.foodNum].praise_num;
    vc.isPraise = self.resultModel.dataArr[self.foodNum].praise_is;
    
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //填充全屏(原视图不会消失)
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

//没有找到
- (void)noFound {
    popUpInformationVC *vc = [[popUpInformationVC alloc] init];
    vc.contentText = @"你选择的标签卷卷这里暂时还未收\n录哦！";
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //填充全屏(原视图不会消失)
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

//美食刷新完了
- (void)foodOut {
    popUpInformationVC *vc = [[popUpInformationVC alloc] init];
    vc.contentText = @"如果还没找到你喜欢的美食，可以\n尝试多选一些关键词哦！";
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //填充全屏(原视图不会消失)
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (CAGradientLayer *)blendColorsWithbounds:(CGRect)bounds {
    //背景渐变色
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = bounds;
    //起点和终点表示的坐标系位置，（0，0)表示左上角，（1，1）表示右下角
    gl.startPoint = CGPointMake(0, 1);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[
        (__bridge id)[UIColor colorWithHexString:@"#4841E2"].CGColor,
        (__bridge id)[UIColor colorWithHexString:@"#5D5DF7"].CGColor
    ];
    gl.locations = @[@(0), @(1.0f)];
    return gl;
}

#pragma mark - 自定义返回条
//自定义的Tabbar
- (void)addGoBackView {
    self.goBackView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    //设置阴影
    UIView *tempView = [[UIView alloc] initWithFrame:self.goBackView.bounds];
    tempView.backgroundColor = self.goBackView.backgroundColor;
    self.goBackView.backgroundColor = UIColor.clearColor;
    self.goBackView.layer.shadowRadius = 8;
    self.goBackView.layer.shadowColor = [UIColor Light:UIColor.lightGrayColor Dark:UIColor.darkGrayColor].CGColor;
    self.goBackView.layer.shadowOpacity = 0.3;
    
    //只切下面的圆角(利用贝塞尔曲线)
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.goBackView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = tempView.bounds;
    shapeLayer.path = maskPath.CGPath;
    tempView.layer.mask = shapeLayer;
    [self.goBackView insertSubview:tempView atIndex:0];
    
    [self.view addSubview:self.goBackView];
    
    //addTitleView
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"美食咨询处";
    titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:20];
    titleLabel.textColor = [UIColor colorWithHexString:@"#112C53"];
    self.titleLabel = titleLabel;
    [self.goBackView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(37);
        make.top.equalTo(self.goBackView).offset(IS_IPHONEX ? TOTAL_TOP_HEIGHT / 1.75 : TOTAL_TOP_HEIGHT / 2);
    }];
    titleLabel.textColor = [UIColor colorWithHexString:@"#15315B" alpha:1];
    
    //添加返回按钮
    [self addBackButton];
    
    //添加说明按钮
    [self addLearnMoreButton];
}

//添加退出的按钮
- (void)addBackButton {
    UIButton *backButton = [[MXObjCBackButton alloc] initWithFrame:CGRectZero isAutoHotspotExpand:YES];
    [self.goBackView addSubview:backButton];
    [backButton setImage:[UIImage imageNamed:@"空教室返回"] forState:UIControlStateNormal];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(@9);
        make.height.equalTo(@19);
    }];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

//返回的方法
- (void)back {
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentingViewController != nil) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

//添加查看更多的按钮
- (void)addLearnMoreButton {
    UIButton *learnMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goBackView addSubview:learnMoreButton];
    [learnMoreButton setImage:[UIImage imageNamed:@"美食提醒"] forState:UIControlStateNormal];
    [learnMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(@20);
        make.height.equalTo(@21);
    }];
    [learnMoreButton addTarget:self action:@selector(learnAbout) forControlEvents:UIControlEventTouchUpInside];
}

//查看更多的方法
- (void)learnAbout {
    popUpInformationVC *vc = [[popUpInformationVC alloc] init];
    vc.contentText = @"美食咨询处的设置，一是为了帮助\n各位选择综合症的邮子们更好的选\n择自己的需要的美食，对选择综合\n症说拜拜！二是为了各位初来学校\n的新生学子更好的体验学校各处的\n美食！按照要求通过标签进行选\n择，卷卷会帮助你选择最符合要求\n的美食哦！";
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //填充全屏(原视图不会消失)
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Lazy
- (NSMutableArray <NSArray *> *)_getAry {
    if (!_homeMary) {
        _homeMary = [[NSMutableArray alloc] initWithArray:@[
            self.homeModel.eat_areaAry,
            self.homeModel.eat_numAry,
            self.homeModel.eat_propertyAry
        ]];
    }
    return _homeMary;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //最小列间距
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 34);
        //最小行间距
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.allowsMultipleSelection = YES;
        
        [_collectionView registerClass:FoodMainPageCollectionViewCell.class forCellWithReuseIdentifier:FoodMainPageCollectionViewCellReuseIdentifier];
        // 注册区头
        [_collectionView registerClass:[FoodHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 45, (SCREEN_WIDTH - 45) * 0.2789)];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:_topView.bounds];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.homeModel.pictureURL]];
        [_topView addSubview:imgView];
    }
    return _topView;
}

- (UIView *)goBackView {
    if (!_goBackView) {
        _goBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBARHEIGHT + 48)];
    }
    return _goBackView;
}

- (FoodHomeModel *)homeModel {
    if (!_homeModel) {
        _homeModel = [[FoodHomeModel alloc] init];
    }
    return _homeModel;
}

- (FoodResultModel *)resultModel {
    if (!_resultModel) {
        _resultModel = [[FoodResultModel alloc] init];
    }
    return _resultModel;
}

- (UDScrollAnimationView *)resultView {
    if (!_resultView) {
        _resultView = [[UDScrollAnimationView alloc] initWithFrame:CGRectMake(0, 0, 238, 51)TextArry:[[NSArray alloc] initWithObjects:@"", nil] FinalText:@""];
        _resultView.layer.cornerRadius = 8;
        _resultView.layer.masksToBounds = YES;
        _resultView.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _resultView.textColor = [UIColor colorWithHexString:@"#2F5085"];
        _resultView.backgroundColor = [UIColor colorWithHexString:@"#EFF4FF"];
    }
    return _resultView;
}

- (UIButton *)getResultBtn {
    if (!_getResultBtn) {
        _getResultBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 91, 34)];
        [_getResultBtn.layer addSublayer:[self blendColorsWithbounds:_getResultBtn.bounds]];
        //给控件加圆角
        _getResultBtn.layer.cornerRadius = 16;
        _getResultBtn.layer.masksToBounds = YES;
        [_getResultBtn addTarget:self action:@selector(getResult) forControlEvents:UIControlEventTouchUpInside];
        [_getResultBtn setTitle:@"随机生成" forState:UIControlStateNormal];
        _getResultBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:14];
    }
    return _getResultBtn;
}

- (UIButton *)getInfoBtn {
    if (!_getInfoBtn) {
        _getInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 91, 34)];
        [_getInfoBtn.layer addSublayer:[self blendColorsWithbounds:_getInfoBtn.bounds]];
        //给控件加圆角
        _getInfoBtn.layer.cornerRadius = 16;
        _getInfoBtn.layer.masksToBounds = YES;
        [_getInfoBtn addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
        [_getInfoBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_getInfoBtn.titleLabel setFont:[UIFont fontWithName:PingFangSCMedium size:14]];
        _getInfoBtn.hidden = YES;
    }
    return _getInfoBtn;
}

- (UIButton *)getOtherBtn {
    if (!_getOtherBtn) {
        _getOtherBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 91, 34)];
        //给控件加边框
        _getOtherBtn.layer.borderWidth = 1;
        _getOtherBtn.layer.borderColor = [UIColor colorWithHexString:@"#5D5DF7"].CGColor;
        
        //给控件加圆角
        _getOtherBtn.layer.cornerRadius = 16;
        _getOtherBtn.layer.masksToBounds = YES;
        [_getOtherBtn addTarget:self action:@selector(getOther) forControlEvents:UIControlEventTouchUpInside];
        [_getOtherBtn setTitle:@"换一个" forState:UIControlStateNormal];
        [_getOtherBtn.titleLabel setFont:[UIFont fontWithName:PingFangSCMedium size:14]];
        [_getOtherBtn setTitleColor:[UIColor colorWithHexString:@"#5C5CF6"] forState:UIControlStateNormal];
        _getOtherBtn.hidden = YES;
    }
    return _getOtherBtn;
}
@end
