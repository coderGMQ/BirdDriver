//
//  BDHomeTopBean.m
//  BirdDriver
//
//  Created by 甘明强 on 2019/1/8.
//  Copyright © 2019年 com.zhihundaohe.BD. All rights reserved.
//

#import "BDHomeTopBean.h"

@implementation BDHomeTopBean
- (instancetype)initDataWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.title = [dic safeObjectForKey:@"title"];
        self.imageName = [dic safeObjectForKey:@"imageName"];
    }
    return self;
}
@end
