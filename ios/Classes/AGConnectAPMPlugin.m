// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

#import "AGConnectAPMPlugin.h"
#import "AGConnectCore/AGConnectCore.h"
#if __has_include(<agconnect_apm/agconnect_apm-Swift.h>)
#import <agconnect_apm/agconnect_apm-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "agconnect_apm-Swift.h"
#endif

@implementation AGConnectAPMPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      [AGCInstance startUp];
    });
    [AGConnectAPMPluginHandler registerWithRegistrar:registrar];
}
@end
