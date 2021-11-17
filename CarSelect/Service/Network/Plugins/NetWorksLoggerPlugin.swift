//
//  NetWorksLoggerPlugin.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Moya

/// NetWorksLoggerPlugin
public final class NetWorksLoggerPlugin: PluginType {

    public func willSend(_ request: RequestType,
                         target: TargetType) {
        #if DEBUG
        printDebug(request.request?.url ?? "request error")
        printDebug(request.request?.allHTTPHeaderFields ?? String.emptyString)
        #endif
    }

    public func didReceive(_ result: Result<Response, MoyaError>,
                           target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let response):
            let printString = response.request?.url?.absoluteString ?? "unknown url"
            printDebug("success: " + printString)
        case .failure(let error):
            printDebug("error: " + error.errorMoyaDescription)
        }
        #endif
    }
}
