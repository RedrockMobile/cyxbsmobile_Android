//
//  BaseNavigationController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIFont+AdaptiveFont.h"
@interface BaseNavigationController ()<UINavigationBarDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIImage *bgImage = [UIImage imageNamed:@"all_image_background"];
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navbar_image_back"]];
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"navbar_image_back"]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]}]; 
    // Do any additional setup after loading the view.
}

@end
