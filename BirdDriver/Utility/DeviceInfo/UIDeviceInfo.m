//
//  UIDeviceInfo.m
//  SmartLife
//
//  Created by Potter on 2017/2/15.
//  Copyright © 2017年 Potter. All rights reserved.
//

#import "UIDeviceInfo.h"
#if iPhone
    #import <AdSupport/ASIdentifierManager.h>
    #import "KeychainHelper.h"
    #import "sys/utsname.h"
#elif iPad
    #import <AdSupport/ASIdentifierManager.h>
    #import "KeychainHelper.h"
    #import "sys/utsname.h"
#endif

@implementation UIDeviceInfo

#pragma mark - private method
+ (NSString*)deviceType:(NSString *)platform {
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5 inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5 inch (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

#pragma mark - public method

+(NSString *)UDID{
#if iPhone
    NSString * idfaString = [[NSUserDefaults standardUserDefaults] objectForKey:@"TieBaDeviceUUID"];
    if (!idfaString || idfaString.length == 0 || [idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        idfaString = [KeychainHelper load:@"TieBaDeviceUUID"];
        if (!idfaString || idfaString.length == 0 || [idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
            idfaString = [self appleIFA];
            if ([idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                idfaString = [self appleIFV];
                if (!idfaString) {
                    idfaString = [self randomUUID];
                }
                
            }
            [[NSUserDefaults standardUserDefaults] setObject:idfaString forKey:@"TieBaDeviceUUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [KeychainHelper save:@"TieBaDeviceUUID" data:idfaString];
        }
    }
    return idfaString;
#elif iPad
    NSString * idfaString = [[NSUserDefaults standardUserDefaults] objectForKey:@"TieBaDeviceUUID"];
    if (!idfaString || idfaString.length == 0 || [idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        idfaString = [KeychainHelper load:@"TieBaDeviceUUID"];
        if (!idfaString || idfaString.length == 0 || [idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
            idfaString = [self appleIFA];
            if ([idfaString isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                idfaString = [self appleIFV];
                if (!idfaString) {
                    idfaString = [self randomUUID];
                }
                
            }
            [[NSUserDefaults standardUserDefaults] setObject:idfaString forKey:@"TieBaDeviceUUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [KeychainHelper save:@"TieBaDeviceUUID" data:idfaString];
        }
    }
    return idfaString;
#else
    return @"";
#endif
}


+ (NSString *)appleIFA {
    NSString *ifa = nil;
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    if (ASIdentifierManagerClass) { // a dynamic way of checking if AdSupport.framework is available
        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
        NSUUID *advertisingIdentifier = ((NSUUID* (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
        ifa = [advertisingIdentifier UUIDString];
    }
    return ifa;
}

+ (NSString *)appleIFV {
#if iPhone
    if(NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        // only available in iOS >= 6.0
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
#elif iPad
    if(NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        // only available in iOS >= 6.0
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
#else
    return @"";
#endif
}

+ (NSString *)randomUUID {
    if(NSClassFromString(@"NSUUID")) { // only available in iOS >= 6.0
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    return uuid;
}

+ (BOOL)isiPhoneX {
#if iPhone
    if (UIScreen.mainScreen.bounds.size.height == 812) {
        return YES;
    } else {
        return NO;
    }
#else
    return NO;
#endif
}

+ (NSString *)deviceModel
{
#if iPhone
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if (!deviceString) {
        deviceString = @"";
    }
    return deviceString;
#elif iPad
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if (!deviceString) {
        deviceString = @"";
    }
    return deviceString;
#else
    return @"";
#endif
}

+ (NSString *)deviceModelDesc {
    NSString *deviceModel = [self deviceModel];
    if (deviceModel.length>0) {
        return [self deviceType:deviceModel];
    } else {
        return @"";
    }
}

+ (NSString *)systemVersion {
#if iPhone
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
#elif iPad
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
#else
    return @"";
#endif
}

+ (NSString *)appVersion {
    NSString *appVersionStr = @"";
#if iPhone
    NSDictionary *infoPlist = [[NSBundle mainBundle]infoDictionary];
    appVersionStr = [infoPlist objectForKey:@"CFBundleShortVersionString"];
#elif iPad
    NSDictionary *infoPlist = [[NSBundle mainBundle]infoDictionary];
    appVersionStr = [infoPlist objectForKey:@"CFBundleShortVersionString"];
#endif
    return appVersionStr;
}

// 应用ID
+ (NSString *)boundleID {
    NSString *boundleIDStr = @"";
#if iPhone
    boundleIDStr = [[NSBundle mainBundle] bundleIdentifier];
#elif iPad
    boundleIDStr = [[NSBundle mainBundle] bundleIdentifier];
#endif
    return boundleIDStr;
    
}
@end
