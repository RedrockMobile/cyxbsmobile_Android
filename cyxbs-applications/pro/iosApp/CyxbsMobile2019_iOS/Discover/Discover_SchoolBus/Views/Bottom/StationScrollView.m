//
//  StationScrollView.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/15.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "StationScrollView.h"

@interface StationScrollView ()

@end

@implementation StationScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setStationData:(StationData *)stationData {
    _stationData = stationData;
    [self removeAllSubviews];
    [self addStationViews];
}
- (void)addStationViews {
//    if (_stationsViewArray == nil) {
        NSMutableArray <StationView *> *MAry = NSMutableArray.array;
        StationData *data = self.stationData;
        NSUInteger count = data.stations.count;
        self.contentSize = CGSizeMake(count * 46, 163);
        for (NSUInteger i = 0; i < count; i++) {
            StationView *view = [[StationView alloc]initWithFrame:CGRectMake(i * 46, 0, 46, 163)];
            view.stationBtn.text = data.stations[i][@"name"];
            view.stationBtn.tag = i;
            
            view.stationBtn.height = [view.stationBtn.text heightForFont:view.stationBtn.font width:view.stationBtn.width];
            
            if (i == 0) {
                view.frontImageView.alpha = 1;
                view.frontImageView.image = [UIImage imageNamed:@"originstation"];
                view.backImageView.frame = CGRectMake(27, 8, 19, 6);
                view.backImageView.image = [UIImage imageNamed:@"busline"];
            }else if (i == count-1) {
                view.frontImageView.alpha = 1;
                view.frontImageView.image = [UIImage imageNamed:@"terminalstation"];
                view.backImageView.frame = CGRectMake(0, 8, 25, 6);
                view.backImageView.image = [UIImage imageNamed:@"busline"];
            }
            [self addSubview:view];
            [MAry addObject:view];
        }
        _stationsViewArray = MAry;
//    }
    return;
}



@end
