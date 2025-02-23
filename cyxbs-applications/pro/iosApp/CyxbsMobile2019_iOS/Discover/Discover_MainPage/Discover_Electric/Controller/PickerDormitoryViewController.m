//
//  PickerDormitoryViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/4/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PickerDormitoryModel.h"
#import "PickerDormitoryViewController.h"

@interface PickerDormitoryViewController ()<
    UIPickerViewDelegate,
    UIPickerViewDataSource
    >

@property (nonatomic, strong) UIPickerView *pickerView;
/// 用来绑定宿舍的View
@property (nonatomic, strong) UIView *bindingView;
/// 选择宿舍时候的宿舍号label
@property (nonatomic, strong) UILabel *buildingNumberLabel;
/// 填写房间号的框框
@property (nonatomic, strong) UITextField *roomTextField;
/// PickerDormitory
@property (nonatomic, strong) PickerDormitoryModel *pickerDormitoryModel;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic) NSInteger selectedArrays;
@end

@implementation PickerDormitoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
    [self bindingBuildingAndRoom];
}

#pragma mark - Method
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//绑定宿舍房间号
- (void)bindingBuildingAndRoom {
    //添加灰色背景板
    UIButton *contentView = [[UIButton alloc] initWithFrame:self.view.frame];
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    contentView.alpha = 0;

    [UIView animateWithDuration:0.3 animations:^{
        contentView.alpha = 1;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
    }];
    [contentView addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];

    [contentView addSubview:self.bindingView];
    
    
    [self.bindingView addSubview:self.pickerView];
    
    UILabel *roomNumberLabel = [[UILabel alloc] init];
    roomNumberLabel.font = [UIFont fontWithName:PingFangSCSemibold size:24];
    roomNumberLabel.text = @"宿舍号：";

    roomNumberLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#5E5F64" alpha:1]];

    [self.bindingView addSubview:roomNumberLabel];
        
    [self.bindingView addSubview:self.roomTextField];
    
    NSString *building = [UserItemTool defaultItem].building;

    if (building) {//如果用户曾经选择过，那么就显示曾见选择的那个
        self.buildingNumberLabel.text = [NSString stringWithFormat:@"%@栋", building];
        NSArray<NSNumber *> *chooseIndex = [self.pickerDormitoryModel getBuildingNameIndexAndBuildingNumberIndexByNumberOfDormitory:building];
        [self.pickerView selectRow:chooseIndex.lastObject.intValue inComponent:1 animated:NO];
        [self.pickerView selectRow:chooseIndex.firstObject.intValue inComponent:0 animated:NO];
    }

    [self.bindingView addSubview:self.buildingNumberLabel];

    [self.bindingView addSubview:self.checkBtn];
            
    [self.bindingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@339);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bindingView).offset(97);
        make.left.right.equalTo(self.bindingView);
        make.height.equalTo(@152);
    }];
    [roomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bindingView).offset(14);
        make.top.equalTo(self.bindingView).offset(23);
    }];
    [self.roomTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomNumberLabel).offset(85);
        make.centerY.equalTo(roomNumberLabel);
        make.width.equalTo(@170);
    }];
    [self.buildingNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(roomNumberLabel);
        make.top.equalTo(roomNumberLabel.mas_bottom).offset(3);
    }];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bindingView);
        make.bottom.equalTo(self.bindingView).offset(-29);
        make.width.equalTo(@120);
        make.height.equalTo(@40);
    }];
   
}

- (void)textFieldDone {
    [self.view endEditing:YES];
}

- (void)bindingDormitory {
    if (self.buildingNumberLabel.text != nil) {
//        NSString *building = [NSString stringWithFormat:@"%d",self.buildingNumberLabel.text.intValue];//这里隐式的去掉了“栋”字
        NSString *building = [self.buildingNumberLabel.text stringByReplacingOccurrencesOfString:@"栋" withString:@""];
        [UserItemTool defaultItem].building = building;
    }

    NSLog(@"*%@*", self.roomTextField.text);

    if (self.roomTextField.text != nil && ![self.roomTextField.text isEqual:@""]) {
        [UserItemTool defaultItem].room = self.roomTextField.text;
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.bindingView animated:YES];
        [hud setMode:(MBProgressHUDModeText)];
        hud.labelText = @"请输入宿舍号～";
        [hud hide:YES afterDelay:1];
        return;
    }

    [self reloadElectricViewIfNeeded];
    [self cancel];
}

- (void)reloadElectricViewIfNeeded {
    self.block();
}

#pragma mark - Lazy

- (UITextField *)roomTextField {
    if (!_roomTextField) {
        _roomTextField = [[UITextField alloc] init];
        _roomTextField.keyboardType = UIKeyboardTypeNumberPad;
        _roomTextField.returnKeyType = UIReturnKeyDone;
        _roomTextField.placeholder = @"例如\"403\"";
        if ([UserItemTool defaultItem].room) {
            _roomTextField.text = [UserItemTool defaultItem].room;
        }
        _roomTextField.inputAccessoryView = [self addToolbar];
        _roomTextField.font = [UIFont fontWithName:PingFangSCSemibold size:24];
        _roomTextField.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#5E5F64" alpha:1]];
    }
    return _roomTextField;
}

- (UILabel *)buildingNumberLabel {
    if (!_buildingNumberLabel) {
        _buildingNumberLabel = [[UILabel alloc] init];
        _buildingNumberLabel.text = @"01栋";
        _buildingNumberLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.59] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:0.59]];
        _buildingNumberLabel.font = [UIFont fontWithName:PingFangSCRegular size:15];
    }
    return _buildingNumberLabel;
}

- (UIView *)bindingView {
    if (!_bindingView) {
        _bindingView = [[UIView alloc]init];
        _bindingView.layer.cornerRadius = 8;
        _bindingView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    }
    return _bindingView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc] init];
        _checkBtn.backgroundColor = [UIColor colorWithHexString:@"#4841E2"];
        [_checkBtn setTitle:@"确定" forState:normal];
        _checkBtn.layer.cornerRadius = 20;
        [_checkBtn addTarget:self action:@selector(bindingDormitory) forControlEvents:UIControlEventTouchUpInside];

    }
    return _checkBtn;
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];

    toolbar.tintColor = [UIColor blueColor];
//    toolbar.backgroundColor = [UIColor sy_grayColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (PickerDormitoryModel *)pickerDormitoryModel {
    if (!_pickerDormitoryModel) {
        _pickerDormitoryModel = [[PickerDormitoryModel alloc] init];
    }
    return _pickerDormitoryModel;
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2; // 返回2表明该控件只包含2列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  {
    if (component == 0) {
        return self.pickerDormitoryModel.allArray.count;
    } else {
        return [self.pickerDormitoryModel.allArray objectAtIndex:self.selectedArrays].count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.pickerDormitoryModel.placeArray[row];
    } else {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        NSArray *arr = [self.pickerDormitoryModel.allArray objectAtIndex:selectedRow];

        if (row < arr.count) {
            return [arr objectAtIndex:row];
        } else {
            return [arr objectAtIndex:0];
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        //如果滑动的是第 0 列, 刷新第 1 列
        //在执行完这句代码之后, 会重新计算第 1 列的行数, 重新加载第 1 列的标题内容
        [pickerView reloadComponent:1];//重新加载指定列的数据
        self.selectedArrays = row;
        [pickerView selectRow:0 inComponent:1 animated:YES];
        //
        //重新加载数据
        [pickerView reloadAllComponents];
    } else {
        //如果滑动的是右侧列，刷新上方label

//           [PickerDormitoryModel getNumberOfDormitoryWith:self.pickerModel.placeArray[row] andPlace:self.pickerModel.allArray[row][row]];
    }

    NSInteger row0 = [pickerView selectedRowInComponent:0];
    NSInteger row1 = [pickerView selectedRowInComponent:1];

    if (row0 >= 0 && row0 < self.pickerDormitoryModel.placeArray.count && row1 >= 0 && row1 < self.pickerDormitoryModel.allArray[row0].count) {
        self.buildingNumberLabel.text = [self.pickerDormitoryModel getNumberOfDormitoryWith:self.pickerDormitoryModel.placeArray[row0] andPlace:self.pickerDormitoryModel.allArray[row0][row1]];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 100;
    } else {
        return 100;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if (component == 0) {
        return 45;
    } else {
        return 45;
    }
}

@end
