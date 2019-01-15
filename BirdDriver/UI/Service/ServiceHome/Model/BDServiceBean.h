//
//  BDServiceBean.h
//  SmartLife
//
//  Created by 甘明强 on 2017/6/8.
//
//

#import <Foundation/Foundation.h>

@interface BDServiceBean : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *titleName;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
