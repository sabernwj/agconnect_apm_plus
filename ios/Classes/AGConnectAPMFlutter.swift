// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import Foundation

@objc(AGConnectAPMFlutter)

/// Provides methods to initialize APM Kit and implement analysis functions.
class AGConnectAPMFlutter: NSObject {
    private var viewModel: AGConnectAPMViewModel = AGConnectAPMViewModel()
    
    @objc func enableCollection(enable: Bool,_ resolve: @escaping FlutterResult) {
        viewModel.delegate = self
        viewModel.enableCollection(enable, completion: resolve)
    }
}
extension AGConnectAPMFlutter: ViewModelDelegate {
    func post(result: (Any?) -> Void) {
        result("Success")
    }
    
    func postError(error: Error?, result: FlutterResult) {
        let error = error as NSError?
        if error?.userInfo["PluginException"] != nil {
            result(FlutterError(
                    code: error?.userInfo["PluginException"] as? String ?? "" ,
                    message: error?.localizedDescription,
                    details: [
                        "exceptionType": "PluginException"
                    ]))
        } else {
            result(FlutterError(
                    code: error?.code.description ?? "",
                    message: error?.localizedDescription,
                    details: [
                        "exceptionType": "SDKException"
                    ]))
        }
    }
}
