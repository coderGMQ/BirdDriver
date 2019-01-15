//
//  EmoreTool.m
//  SmartLife
//
//  Created by 甘明强 on 2017/5/25.
//
//

#import "EmoreTool.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation EmoreTool
+ (void)callTelWithTelStr:(NSString *)telStr {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
        }];
    } else {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"%@", telStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

//+ (void)checkShakeWhenOperateDevice {
//    if (__shakeWhenOperateDevice) {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    }
//}

//转换成json对象
+ (id)jsonValue:(NSString *)string
{
    if (string && [string isKindOfClass:[NSString class]]) {
        id object = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        return object;
    }else
    {
        return nil;
    }
}

//转成string对象
+ (NSString *)jsonFragmentValue:(id)object
{
    NSString * jsonString = nil;
    if (object && [object isKindOfClass:[NSString class]]) {
        jsonString = object;
    }else
    {
        if ([NSJSONSerialization isValidJSONObject:object]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                               options:0
                                                                 error:&error];
            if (jsonData) {
                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
    }//容错，服务器不是string类型对象
    return jsonString;
}

@end
