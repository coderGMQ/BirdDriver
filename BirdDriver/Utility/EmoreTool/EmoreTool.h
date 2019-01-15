//
//  EmoreTool.h
//  SmartLife
//
//  Created by 甘明强 on 2017/5/25.
//
//

#import <Foundation/Foundation.h>

@interface EmoreTool : NSObject
+ (void)callTelWithTelStr:(NSString *)telStr;
//+ (void)checkShakeWhenOperateDevice;   // 核对是否振动(根据设置判断是否振动)
//转换成json对象
+ (id)jsonValue:(NSString *)string;

//转成string对象
+ (NSString *)jsonFragmentValue:(id)object;
@end
