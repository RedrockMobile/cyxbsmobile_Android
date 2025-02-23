//
//  IdsBinding.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/5/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IdsBinding : NSObject
@property (nonatomic, strong) NSString *idsNum;
@property (nonatomic, strong) NSString *idsPassword;


-(instancetype)initWithIdsNum:(NSString *)idsNum isPassword:(NSString *)idsPassword;
-(void)fetchData;


@end

NS_ASSUME_NONNULL_END
