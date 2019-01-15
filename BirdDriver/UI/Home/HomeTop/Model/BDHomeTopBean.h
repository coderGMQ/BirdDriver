//
//  BDHomeTopBean.h
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDHomeTopBean : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
- (instancetype)initDataWithDic:(NSDictionary *)dic;
@end

