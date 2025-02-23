//
//  CQUPTMapMoreImageViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/18.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapMoreImageViewController.h"
#import "CQUPTMapImageLayout.h"
#import "CQUPTMapAllImageCollectionViewCell.h"
#import "CQUPTMapPlaceDetailItem.h"
#import <TZImagePickerController.h>
#import "GKPhotoBrowser.h"

@interface CQUPTMapMoreImageViewController () <UICollectionViewDataSource, UICollectionViewDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) CQUPTMapPlaceDetailItem *detailItem;

@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *shareImageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UICollectionView *imageCollectionView;
@property (nonatomic, weak) UILabel *noMoreImageLabel;

@end

@implementation CQUPTMapMoreImageViewController

- (instancetype)initWithPlaceDetailItem:(CQUPTMapPlaceDetailItem *)detailItem {
    if (self = [super init]) {
        self.detailItem = detailItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    self.backButton = backButton;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"所有图片";
    titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:23];
    if (@available(iOS 11.0, *)) {
        titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15305C" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        titleLabel.textColor = [UIColor colorWithHexString:@"15305B"];
    }
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *shareImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Map_Share_MoreImage"]];
    [self.view addSubview:shareImageView];
    self.shareImageView = shareImageView;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:13];
    [shareButton setTitle:@"与大家分享你拍摄的此地点" forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        [shareButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#01CAF0" alpha:1] darkColor:[UIColor colorWithHexString:@"#47DAFA" alpha:1]] forState:UIControlStateNormal];
    } else {
        [shareButton setTitleColor:[UIColor colorWithHexString:@"01CAF0"] forState:UIControlStateNormal];
    }
    [shareButton addTarget:self action:@selector(shareImageButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    self.shareButton = shareButton;
    
    UICollectionView *imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[CQUPTMapImageLayout alloc] init]];
    [imageCollectionView registerClass:[CQUPTMapAllImageCollectionViewCell class] forCellWithReuseIdentifier:@"CQUPTMapAllImageCollectionViewCell"];
    imageCollectionView.backgroundColor = [UIColor clearColor];
    imageCollectionView.dataSource = self;
    imageCollectionView.delegate = self;
    [self.view addSubview:imageCollectionView];
    self.imageCollectionView = imageCollectionView;
    
    UILabel *noMoreImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_W - 75 - 15, 0, 75, 12)];
    noMoreImageLabel.text = @"暂无更多图片";
    noMoreImageLabel.font = [UIFont fontWithName:PingFangSCMedium size:12];
    if (@available(iOS 11.0, *)) {
        noMoreImageLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#ABBCD8" alpha:1] darkColor:[UIColor colorWithHexString:@"#979797" alpha:1]];
    } else {
        noMoreImageLabel.textColor = [UIColor colorWithHexString:@"ABBCD8"];
    }
}

- (void)viewDidLayoutSubviews {
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(STATUSBARHEIGHT + 15);
        make.width.equalTo(@9);
        make.height.equalTo(@19);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backButton);
        make.top.equalTo(self.backButton.mas_bottom).offset(34);
    }];
    
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.shareButton.mas_leading).offset(-5);
        make.width.height.equalTo(@16);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.view).offset(-15);
    }];
    
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(19.5);
        make.bottom.equalTo(self.view).offset(-45);
    }];
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailItem.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQUPTMapAllImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CQUPTMapAllImageCollectionViewCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.detailItem.imagesArray[indexPath.item]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *photos = [NSMutableArray array];
    
    for (int i = 0; i < self.detailItem.imagesArray.count; i++) {
        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForItem:i inSection:indexPath.section];
        
        UIImage *img = ((CQUPTMapAllImageCollectionViewCell *)([collectionView cellForItemAtIndexPath:tmpIndexPath])).imageView.image;
        
        GKPhoto *photo = [GKPhoto new];
        photo.image = img;
        [photos addObject:photo];
    }
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.item];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:self];
}


- (void)shareImageButtonTapped {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"共享照片" message:@"在这里，与邮子们共同分享你们所拍的校园风景。上传你的照片，优质照片有机会在此展示。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 delegate:self];
        [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"不能发布视频呢";
            [hud hide:YES afterDelay:1.2];
        }];
        
        [imagePickerVc setDidFinishPickingGifImageHandle:^(UIImage *coverImage, PHAsset *asset) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"不能发布GIF呢";
            [hud hide:YES afterDelay:1.2];
        }];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [self dismissViewControllerAnimated:YES completion:^{
                
                UIAlertController *uploadAlertController = [UIAlertController alertControllerWithTitle:@"确认上传" message:@"确认后您选择的图片将被上传，审核通过后就可以展示啦。" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *uploadCancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                
                UIAlertAction *uploadCertainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    // 上传图片
                    
                    NSDictionary *params = @{
                        @"place_id": self.detailItem.placeID
                    };
                    
                    NSMutableArray *names = [@[] mutableCopy];
                    for (int i = 0; i < photos.count; i++) {
                        [names addObject:@"file"];
                    }
                    
                    [HttpTool.shareTool
                     form:Discover_POST_cquptMapUploadMage_API
                     type:HttpToolRequestTypePost
                     parameters:params
                     bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
                        for (int i = 0; i < photos.count; i++) {
                            UIImage *image = photos[i];
                            UIImage *image1 = [image cropEqualScaleImageToSize:image.size isScale:YES];
                            NSData *data = UIImageJPEGRepresentation(image1, 0.8);
                            NSString *fileName = [NSString stringWithFormat:@"%ld.png", [NSDate nowTimestamp]];
                            [body appendPartWithFileData:data name:names[i] fileName:fileName mimeType:@"image/png"];
                        }
                    }
                     progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
                        NSLog(@"图片上传成功");
                    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        NSLog(@"图片上传失败，错误信息：\n %@", error);
                    }];
                }];
                
                [uploadAlertController addAction:uploadCancelAction];
                [uploadAlertController addAction:uploadCertainAction];
                
                [self presentViewController:uploadAlertController animated:YES completion:nil];
            }];
            
        }];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:certainAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
