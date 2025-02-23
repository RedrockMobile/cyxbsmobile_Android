//
//  FeedBackVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/8/24.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackVC.h"
#import "TypeSelectView.h"
#import "FeedBackView.h"

#import <PhotosUI/PHPicker.h>
#import "TypeButton.h"
#import "NewQAHud.h"
#import "TZImagePickerController.h"

@interface FeedBackVC () <PHPickerViewControllerDelegate,TZImagePickerControllerDelegate>

///问题类型选择器
@property (nonatomic,strong) TypeSelectView * typeSelectView;
///反馈自定义View
@property (nonatomic,strong) FeedBackView *feedBackView;
///提交按钮
@property (nonatomic,strong) UIButton *submitBtn;
///选中的图片数组
@property (nonatomic,strong) NSMutableArray *photoAry;
///选中的按钮
@property (nonatomic,strong) TypeButton *correctBtn;
@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBar];
    [self.view addSubview:self.typeSelectView];
    [self.view addSubview:self.feedBackView];
    [self.view addSubview:self.submitBtn];
    self.photoAry = [[NSMutableArray alloc]initWithCapacity:4];
}


#pragma mark - getter
- (TypeSelectView *)typeSelectView{
    if (!_typeSelectView) {
        _typeSelectView = [[TypeSelectView alloc]initWithFrame:CGRectMake(0, Bar_H, SCREEN_WIDTH, 71)];
        __weak typeof(self) weakSelf = self;
        
        /*
         按钮选择说明
         weakSelf.correctBtn : 已选的 （可以为空）
         sender : 正要选的
         */
        
        [_typeSelectView setSelect:^(TypeButton * _Nonnull sender) {
            //若第一次选择
            if (!weakSelf.correctBtn) {
                //设置正要选的为选中
                sender.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E7E6FA" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2C5A" alpha:1]];
                [sender setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4E49E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#5D5BF7" alpha:1]] forState:UIControlStateNormal];
                sender.layer.borderColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4E49E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#5D5BF7" alpha:1]].CGColor;
                weakSelf.correctBtn = sender;
            }else{
                /*
                 如果之前选过了
                 那么先取消已选择的效果
                 再设置新的为已选择
                 */
                weakSelf.correctBtn.backgroundColor = [UIColor clearColor];
                [weakSelf.correctBtn setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#91A3BF" alpha:1] darkColor:[UIColor colorWithHexString:@"#7C7D7F" alpha:1]] forState:UIControlStateNormal];
                weakSelf.correctBtn.layer.borderColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#91A3BF" alpha:1] darkColor:[UIColor colorWithHexString:@"#7C7D7F" alpha:1]].CGColor;
                sender.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E7E6FA" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2C5A" alpha:1]];
                [sender setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4E49E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#5D5BF7" alpha:1]] forState:UIControlStateNormal];
                sender.layer.borderColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4E49E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#5D5BF7" alpha:1]].CGColor;
                weakSelf.correctBtn = sender;
            }
        }];
    }
    return _typeSelectView;
}

- (FeedBackView *)feedBackView{
    if (!_feedBackView) {
        __weak typeof(self) weakSelf = self;
        _feedBackView = [[FeedBackView alloc]initWithFrame:CGRectMake(16, Bar_H + 71, SCREEN_WIDTH - 32, 369)];
        [_feedBackView setSelectPhoto:^{
            //Newest iOS
            if (@available(iOS 14, *)) {

                PHPickerConfiguration *config = [[PHPickerConfiguration alloc]init];
                config.selectionLimit = 3;
                config.filter = [PHPickerFilter imagesFilter];
                PHPickerViewController *pVC = [[PHPickerViewController alloc]initWithConfiguration:config];
                pVC.delegate = weakSelf;
                [weakSelf presentViewController:pVC animated:YES completion:nil];

            } else {
                // iOS 13.7 or Lower (Above iOS 6.0)
                TZImagePickerController *picker = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:weakSelf];
                [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    weakSelf.photoAry = [photos mutableCopy];
                    [weakSelf refreshImage];
                }];
                
                [weakSelf presentViewController:picker animated:YES completion:nil];
            }
        }];
        
        [_feedBackView setDeletePhoto:^(NSInteger tag) {
            [weakSelf deleteImageWithTag:tag];
        }];
   
    }
    return _feedBackView;
}

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.size = CGSizeMake(117, 41);
        _submitBtn.centerX = self.view.centerX;
        if (IS_IPHONE8) {
            _submitBtn.y = self.view.height - 100;
        }else{
            _submitBtn.y = self.view.height - 150;
        }
       
        [_submitBtn setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}


#pragma mark - 私有方法
- (void)setupBar{
    self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.VCTitleStr = @"意见反馈";
    self.topBarView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.splitLineColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E4E4E9" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2B2E" alpha:1]];
    self.titlePosition = TopBarViewTitlePositionLeft;
    self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:21];
}

#pragma mark - PHPicker Delegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results API_AVAILABLE(ios(14)){
    //picker消失时的操作
    [picker dismissViewControllerAnimated:YES completion:nil];
    //遍历
    for (PHPickerResult *result in results) {
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
            //如果结果的类型是UIImage
            if (object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.photoAry addObject:object];
                    //刷新控件
                    [self refreshImage];
                });
            }
        }];
    }
}

#pragma mark - 上传
- (void)submit{

    if (self.feedBackView.heading.text.length == 0) {
        [NewQAHud showHudWith:@"请输入完整的反馈信息哦！" AddView:self.view];
        return;
    }
    
    if (self.feedBackView.feedBackMain.text.length == 0) {
        [NewQAHud showHudWith:@"请输入完整的反馈信息哦！" AddView:self.view];
        return;
    }
    
    //问题类型字段
    NSString *type = [[NSString alloc]init];
    
    switch (self.correctBtn.tag) {
        case 0:
            type = @"意见建议";
            break;
        case 1:
            type = @"系统问题";
            break;
        case 2:
            type = @"账号问题";
        default:
            type = @"其他";
            break;
    }
 
    //问题的标题
    NSString *title = self.feedBackView.heading.text;
    //问题的内容
    NSString *content = self.feedBackView.feedBackMain.text;
    //标识
    NSString *cyxbs_id = @"1";
    
    //如果选择了类型
    if (self.correctBtn) {

        [HttpTool.shareTool
         form:Mine_POST_submit_API
         type:HttpToolRequestTypePost
         parameters:nil
         bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
            
            //字段转二进制
            NSData *data1 = [type dataUsingEncoding:NSUTF8StringEncoding];
            NSData *data2 = [title dataUsingEncoding:NSUTF8StringEncoding];
            NSData *data3 = [content dataUsingEncoding:NSUTF8StringEncoding];
            NSData *data4 = [cyxbs_id dataUsingEncoding:NSUTF8StringEncoding];

            //图片转二进制
            if (self.photoAry.count == 1) {
                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            }
            if (self.photoAry.count == 2) {
                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                NSData *imageData2 = UIImageJPEGRepresentation(self.photoAry[1], 0.6);
                NSString *fileName2 = [NSString stringWithFormat:@"%ld2.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData2 name:@"file" fileName:fileName2 mimeType:@"image/jpeg"];
            }
            if (self.photoAry.count == 3) {
                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                NSData *imageData2 = UIImageJPEGRepresentation(self.photoAry[1], 0.6);
                NSString *fileName2 = [NSString stringWithFormat:@"%ld2.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData2 name:@"file" fileName:fileName2 mimeType:@"image/jpeg"];
                NSData *imageData3 = UIImageJPEGRepresentation(self.photoAry[2], 0.6);
                NSString *fileName3 = [NSString stringWithFormat:@"%ld3.jpeg", [NSDate nowTimestamp]];
                [body appendPartWithFileData:imageData3 name:@"file" fileName:fileName3 mimeType:@"image/jpeg"];
            }
                [NewQAHud showHudWith:@"正在上传，请稍候" AddView:self.view AndToDo:^{
                    self.view.userInteractionEnabled = NO;
                }];

            [body appendPartWithFormData:data1 name:@"type"];
            [body appendPartWithFormData:data2 name:@"title"];
            [body appendPartWithFormData:data3 name:@"content"];
            [body appendPartWithFormData:data4 name:@"product_id"];
            
        }
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            [NewQAHud showHudWith:@"提交成功，我们会在十四个工作日内回复~" AddView:self.view AndToDo:^{
                [self.navigationController popViewControllerAnimated:YES];
                self.view.userInteractionEnabled = YES;
            }];
            
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NewQAHud showHudWith:@"提交失败 网络异常" AddView:self.view AndToDo:^{
                    [self.navigationController popViewControllerAnimated:YES];
                    self.view.userInteractionEnabled = YES;
                }];
        }];
        
//        HttpClient *client = [HttpClient defaultClient];
//
//        [client.httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserItem defaultItem].token]  forHTTPHeaderField:@"authorization"];
//
//        [client.httpSessionManager POST:Mine_POST_submit_API parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//            //字段转二进制
//            NSData *data1 = [type dataUsingEncoding:NSUTF8StringEncoding];
//            NSData *data2 = [title dataUsingEncoding:NSUTF8StringEncoding];
//            NSData *data3 = [content dataUsingEncoding:NSUTF8StringEncoding];
//            NSData *data4 = [cyxbs_id dataUsingEncoding:NSUTF8StringEncoding];
//
//            //图片转二进制
//            if (self.photoAry.count == 1) {
//                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
//                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//            }
//            if (self.photoAry.count == 2) {
//                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
//                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//                NSData *imageData2 = UIImageJPEGRepresentation(self.photoAry[1], 0.6);
//                NSString *fileName2 = [NSString stringWithFormat:@"%ld2.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData2 name:@"file" fileName:fileName2 mimeType:@"image/jpeg"];
//            }
//            if (self.photoAry.count == 3) {
//                NSData *imageData = UIImageJPEGRepresentation(self.photoAry[0], 0.6);
//                NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//                NSData *imageData2 = UIImageJPEGRepresentation(self.photoAry[1], 0.6);
//                NSString *fileName2 = [NSString stringWithFormat:@"%ld2.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData2 name:@"file" fileName:fileName2 mimeType:@"image/jpeg"];
//                NSData *imageData3 = UIImageJPEGRepresentation(self.photoAry[2], 0.6);
//                NSString *fileName3 = [NSString stringWithFormat:@"%ld3.jpeg", [NSDate nowTimestamp]];
//                [formData appendPartWithFileData:imageData3 name:@"file" fileName:fileName3 mimeType:@"image/jpeg"];
//            }
//                [NewQAHud showHudWith:@"正在上传，请稍候" AddView:self.view AndToDo:^{
//                    self.view.userInteractionEnabled = NO;
//                }];
//
//            [formData appendPartWithFormData:data1 name:@"type"];
//            [formData appendPartWithFormData:data2 name:@"title"];
//            [formData appendPartWithFormData:data3 name:@"content"];
//            [formData appendPartWithFormData:data4 name:@"product_id"];
//
//        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [NewQAHud showHudWith:@"提交成功，我们会在十四个工作日内回复~" AddView:self.view AndToDo:^{
//                [self.navigationController popViewControllerAnimated:YES];
//                self.view.userInteractionEnabled = YES;
//            }];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [NewQAHud showHudWith:@"提交失败 网络异常" AddView:self.view AndToDo:^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                    self.view.userInteractionEnabled = YES;
//                }];
//            }];
                }else{//没有选择问题类型
                    [NewQAHud showHudWith:@"请选择问题类型" AddView:self.view];
                }
        }


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.feedBackView endEditing:YES];
}

- (void)refreshImage{
    if (self.photoAry.count == 1) {
        self.feedBackView.plusView.hidden = NO;
        self.feedBackView.plusView.frame = self.feedBackView.imageView2.frame;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = YES;
        self.feedBackView.imageView3.hidden = YES;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = YES;
        self.feedBackView.delete3.hidden = YES;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.photoCountLbl.text = @"1/3";
    }
    if (self.photoAry.count == 2) {
        self.feedBackView.plusView.hidden = NO;
        self.feedBackView.plusView.frame = self.feedBackView.imageView3.frame;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = NO;
        self.feedBackView.imageView3.hidden = YES;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = NO;
        self.feedBackView.delete3.hidden = YES;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.imageView2.image = self.photoAry[1];
        self.feedBackView.photoCountLbl.text = @"2/3";
    }
    if (self.photoAry.count == 3) {
        self.feedBackView.plusView.hidden = YES;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = NO;
        self.feedBackView.imageView3.hidden = NO;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = NO;
        self.feedBackView.delete3.hidden = NO;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.imageView2.image = self.photoAry[1];
        self.feedBackView.imageView3.image = self.photoAry[2];
        self.feedBackView.photoCountLbl.text = @"3/3";
    }
}


- (void)deleteImageWithTag:(NSInteger)tag {
    
    if (self.photoAry.count != 0) {
        [self.photoAry removeObjectAtIndex:tag];
    }
    if (self.photoAry.count == 0) {
        self.feedBackView.plusView.hidden = NO;
        self.feedBackView.plusView.frame = self.feedBackView.imageView1.frame;
        self.feedBackView.imageView1.hidden = YES;
        self.feedBackView.imageView2.hidden = YES;
        self.feedBackView.imageView3.hidden = YES;
        self.feedBackView.delete1.hidden = YES;
        self.feedBackView.delete2.hidden = YES;
        self.feedBackView.delete3.hidden = YES;
        self.feedBackView.photoCountLbl.text = @"0/3";
    }
    if (self.photoAry.count == 1) {
        self.feedBackView.plusView.hidden = NO;
        self.feedBackView.plusView.frame = self.feedBackView.imageView2.frame;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = YES;
        self.feedBackView.imageView3.hidden = YES;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = YES;
        self.feedBackView.delete3.hidden = YES;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.photoCountLbl.text = @"1/3";
    }
    if (self.photoAry.count == 2) {
        self.feedBackView.plusView.hidden = NO;
        self.feedBackView.plusView.frame = self.feedBackView.imageView3.frame;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = NO;
        self.feedBackView.imageView3.hidden = YES;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = NO;
        self.feedBackView.delete3.hidden = YES;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.imageView2.image = self.photoAry[1];
        self.feedBackView.photoCountLbl.text = @"2/3";
    }
    if (self.photoAry.count == 3) {
        self.feedBackView.plusView.hidden = YES;
        self.feedBackView.imageView1.hidden = NO;
        self.feedBackView.imageView2.hidden = NO;
        self.feedBackView.imageView3.hidden = NO;
        self.feedBackView.delete1.hidden = NO;
        self.feedBackView.delete2.hidden = NO;
        self.feedBackView.delete3.hidden = NO;
        self.feedBackView.imageView1.image = self.photoAry[0];
        self.feedBackView.imageView2.image = self.photoAry[1];
        self.feedBackView.imageView3.image = self.photoAry[2];
        self.feedBackView.photoCountLbl.text = @"3/3";
    }
}
@end
