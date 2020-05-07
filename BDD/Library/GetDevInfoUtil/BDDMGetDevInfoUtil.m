//
//  BDDMGetDevInfoUtil.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/29.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDMGetDevInfoUtil.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <dlfcn.h>
#import <sys/socket.h>
#import <net/if_dl.h>
#import <net/if.h>
#include <sys/sysctl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


#define    CTL_NET            4        /* network, see socket.h */
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation BDDMGetDevInfoUtil

///<MEID/>  移动终端设备标识码UUID//重装后会发生变化
+ (NSString *)getUUIDCode{
    NSString *ieidString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

    return ieidString;
}
///<CORPORATION/>   生产厂商/品牌商（即供应商）
+ (NSString *)getCorporation{
    return @"苹果公司";
}
///<MOBILE_TYPE/>   设备类型
+ (NSString *)getDeviceName
{
    return [[UIDevice currentDevice] model];
}
///<MODEL/>     移动终端型号
+ (NSString *)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";

    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";

    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";

    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";

    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7-inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7-inch)";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad6,11"])     return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad6,12"])     return @"iPad 5";

    if ([deviceString isEqualToString:@"iPad7,1"])      return @"iPad Pro 2 (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad7,2"])      return @"iPad Pro 2 (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad7,3"])      return @"iPad Pro (10.5-inch)";
    if ([deviceString isEqualToString:@"iPad7,4"])      return @"iPad Pro (10.5-inch)";
    if ([deviceString isEqualToString:@"iPad7,5"])      return @"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,6"])      return @"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,11"])     return @"iPad 7";
    if ([deviceString isEqualToString:@"iPad7,12"])     return @"iPad 7";

    if ([deviceString isEqualToString:@"iPad8,1"])      return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,2"])      return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,3"])      return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,4"])      return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,5"])      return @"iPad Pro 3 (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,6"])      return @"iPad Pro 3 (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,7"])      return @"iPad Pro 3 (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,8"])      return @"iPad Pro 3 (12.9-inch)";
    
    if ([deviceString isEqualToString:@"iPad11,1"])     return @"iPad mini 5";
    if ([deviceString isEqualToString:@"iPad11,2"])     return @"iPad mini 5";
    if ([deviceString isEqualToString:@"iPad11,3"])     return @"iPad Air 3";
    if ([deviceString isEqualToString:@"iPad11,4"])     return @"iPad Air 3";

    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";

    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";

    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";

    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";

    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";

    //https://www.theiphonewiki.com/wiki/List_of_iPhones#iPhone_X
//    https://www.theiphonewiki.com/wiki/List_of_iPads
//    https://www.theiphonewiki.com/wiki/List_of_iPad_Airs
//    https://www.theiphonewiki.com/wiki/List_of_iPad_minis
//    https://www.theiphonewiki.com/wiki/List_of_iPad_Pros
    
    NSString *unKnownDeviceStr = [NSString stringWithFormat:@"UnKnownDevice:%@",deviceString];
    return unKnownDeviceStr;
}
///<OS/>       操作系统
+ (NSString *)getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
/// APP版本号
+ (NSString*)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

///<MAC/> 获取MAC码
//苹果已经不允许获取用户的Mac地址了，ios7以后获取到的mac码都为02:00:00:00:00:00
//ios7之前可以获取的到：例如FC:25:3F:33:25:75
+ (NSString *)getMacCode

{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

#pragma mark - 获取设备当前网络IP地址(外网ip）
+ (NSString *)getNetworkIPAddress {
    //方式一：淘宝api
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *ipStr = nil;
    if (ipDic && [ipDic[@"code"] integerValue] == 0) {
        //获取成功
        ipStr = ipDic[@"data"][@"ip"];
    }
    return (ipStr ? ipStr : @"0.0.0.0");
    
    //方式二：新浪api
//    NSError *error;
//    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
//
//    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
//    //判断返回字符串是否为所需数据
//    if ([ip hasPrefix:@"var returnCitySN = "]) {
//        //对字符串进行处理，然后进行json解析
//        //删除字符串多余字符串
//        NSRange range = NSMakeRange(0, 19);
//        [ip deleteCharactersInRange:range];
//        NSString * nowIp =[ip substringToIndex:ip.length-1];
//        //将字符串转换成二进制进行Json解析
//        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dict);
//        return dict[@"cip"] ? dict[@"cip"] : @"0.0.0.0";
//    }
//    return @"0.0.0.0";
}

#pragma mark - 获取设备当前本地IP地址（内网ip）
+ (NSString *)getLocalIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

///<IMSI/>      IMSI码  私有api appstore申请上线会被拒
/// ！！不要放开注释！！
//+(NSString *)getIMSICode{
//    const char *imsiPath = NULL;
//
//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//
//    if (version < 5.0) {
//
//        imsiPath = "/System/Library/PrivateFrameworks/CoreTelephony.framework/CoreTelephony";
//
//    } else {
//
//        imsiPath = "/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony";
//
////        imsiPath = "/Applications/Xcode5.1.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony";
//
//    }
//
//    void *kit = dlopen(imsiPath,RTLD_LAZY);
//
//    int (*CTSIMSupportCopyMobileSubscriberIdentity)(void) = dlsym(kit, "CTSIMSupportCopyMobileSubscriberIdentity");
//
//    NSString* imsiString = [NSString stringWithFormat:@"%d",CTSIMSupportCopyMobileSubscriberIdentity()];
//
//    dlclose(kit);
//
//    return imsiString;
//}


@end
