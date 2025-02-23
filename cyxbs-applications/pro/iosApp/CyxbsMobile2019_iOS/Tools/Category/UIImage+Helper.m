//
//  UIImage+Helper.m
//  Image-master
//
//  Created by YiTie on 16/3/22.
//  Copyright © 2016年 武文杰. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)


+(UIImage *)imageWithBgColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIImage *)fixOrientationWithImage:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+ (UIImage *)mixImageWithImageArray:(NSArray *)imageArray andImageOffsetArray:(NSArray *)offsetArray andBackImageViewSize:(CGSize)size
{
    if (imageArray.count == 0) {
        return nil;
    }
    if (imageArray.count == 1) {
        return imageArray[0];
    }
    if (!(imageArray.count == offsetArray.count)) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(size);
    for (int i =  0; i < imageArray.count; i++) {
        UIImage *image = imageArray[i];
        NSValue *value = offsetArray[i];
        CGRect rect = [value CGRectValue];
        [image drawInRect:rect];
    }
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets image:(UIImage *)image
{
    UIImage *newImage = [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    return newImage;
}


+ (UIImage *)cutImage:(UIImage*)image scale:(CGFloat)scale
{
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    UIImageOrientation imageOrientation;
    if (image.size.width > image.size.height) {
        imageOrientation = UIImageOrientationUp;
        if ((image.size.width / image.size.height) < scale) {
            newSize.width = image.size.width;
            newSize.height = image.size.width * scale;
            
            imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
            
        } else {
            newSize.height = image.size.height;
            newSize.width = image.size.height / scale;
            
            imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        }
    } else {
        imageOrientation = UIImageOrientationUp;
        if ((image.size.width / image.size.height) < scale) {
            newSize.width = image.size.width;
            newSize.height = image.size.width / scale;
            
            imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
            
        } else {
            newSize.height = image.size.height;
            newSize.width = image.size.height * scale;
            
            imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        }
    }
    return [UIImage imageWithCGImage:imageRef scale:1.0 orientation:imageOrientation];
}




- (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color
{
    //开启图片大小一样的上下文
    CGSize size = CGSizeMake(self.size.width + 2 *borderW, self.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size,NO,0);
    //添加一个填充区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    //添加一个裁剪区域
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, self.size.width, self.size.height)];
    [path addClip];
    //添加图片到裁剪区域
    [self drawAtPoint:CGPointMake(borderW, borderW)];
    //得到新图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文.
    UIGraphicsEndImageContext();
    return clipImage;
}


+ (UIImage *)captureWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 4.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)waterImageWith:(UIImage *)image logo:(UIImage *)logoImage
{
    // 上下文 : 基于位图(bitmap) ,  所有的东西需要绘制到一张新的图片上去
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    // size : 新图片的尺寸
    // opaque : YES : 不透明,  NO : 透明
    // 这行代码过后.就相当于创建一张新的bitmap,也就是新的UIImage对象
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    // 画背景
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 画右下角的水印
    CGFloat scale = 0.2;
    CGFloat logoW = logoImage.size.width * scale;
    CGFloat logoH = logoImage.size.height * scale;
    CGFloat margin = 5;
    CGFloat logoX = image.size.width - logoW - margin;
    CGFloat logoY = image.size.height - logoH - margin;
    CGRect rect = CGRectMake(logoX, logoY, logoW, logoH);
    [logoImage drawInRect:rect];
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (UIImage *)cropEqualScaleImageToSize:(CGSize)size isScale:(BOOL)isScale
{
    if (!isScale) {
        CGFloat scale =  [UIScreen mainScreen].scale;
        
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    CGFloat scale =  [UIScreen mainScreen].scale;
    
    // 这一行至关重要
    // 不要直接使用UIGraphicsBeginImageContext(size);方法
    // 因为控件的frame与像素是有倍数关系的
    // 比如@1x、@2x、@3x图，因此我们必须要指定scale，否则黄色去不了
    // 因为在5以上，scale为2，6plus scale为3，所生成的图是要合苹果的
    // 规格才能正常
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGSize aspectFitSize = CGSizeZero;
    if (self.size.width != 0 && self.size.height != 0) {
        CGFloat rateWidth = size.width / self.size.width;
        CGFloat rateHeight = size.height / self.size.height;
        
        CGFloat rate = MIN(rateHeight, rateWidth);
        aspectFitSize = CGSizeMake(self.size.width * rate, self.size.height * rate);
    }
    
    [self drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//



@end
