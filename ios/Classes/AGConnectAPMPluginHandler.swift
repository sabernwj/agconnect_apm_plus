// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import Flutter
import UIKit
import AGConnectCore

public class AGConnectAPMPluginHandler: NSObject, FlutterPlugin {
    let agconnectAPM = AGConnectAPMFlutter.init()
    let method = Methods.init()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.huawei.agconnectapm/methodChannel/", binaryMessenger: registrar.messenger())
        let instance = AGConnectAPMPluginHandler()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            return
        }
        print(call.method)
        switch call.method {
        case method.ENABLE_COLLECTION:
            guard let enable = args["ENABLE"] as? Bool else { return  }
            agconnectAPM.enableCollection(enable: enable, { (response) in
                result(response)
            })
        default:
            result(FlutterError(
                    code: "platformError" ,
                    message: "Not supported on iOS platform",
                    details: [
                        "exceptionType": "PluginException"
                    ]))
        }
    }
    
    struct Methods {
        let ENABLE_COLLECTION = "ENABLE_COLLECTION"
    }
}
