//
//  BDServiceBean.m
//  SmartLife
//
//  Created by 甘明强 on 2017/6/8.
//
//

#import "BDServiceBean.h"

@implementation BDServiceBean
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.imageName = [dic safeObjectForKey:@"imageName"];
        self.titleName = [dic safeObjectForKey:@"titleName"];
    }
    return self;
}
@end
