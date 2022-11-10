// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import Foundation
import AGConnectAPM

public protocol ViewModelDelegate: AnyObject {
    func post(result: FlutterResult)
    func postError(error: Error?, result: FlutterResult)
}

public class AGConnectAPMViewModel: NSObject {
    weak var delegate: ViewModelDelegate?
    private var agcAPM: AGCAPM?
    
    private let agcAPMNullError = NSError.init(domain: "AgcAPM is null", code: 10, userInfo: ["PluginException": "AgcAPM_NOT_FOUND"])
    
    func enableCollection(_ enable: Bool,completion: @escaping FlutterResult) {
        AGCAPM.sharedInstance().enableCrashCollection(enable: enable)
        self.delegate?.post(result: completion)
    }
}

