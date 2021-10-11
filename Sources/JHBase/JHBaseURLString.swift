//
//  File.swift
//  
//
//  Created by lifei on 2021/10/11.
//

import Foundation

public var kNetProtocol: String {
    let filepath = Bundle.main.path(forResource: "ipServiceFile", ofType: "plist")
    let ipDict = NSDictionary(contentsOfFile: filepath ?? "")
    guard let ipDict = ipDict, let apiHeader = ipDict["api_header"] as? String else {
        return "https://"
    }
    if apiHeader.isEmpty == true {
        return "https://"
    }
    return apiHeader
}

public var kNetEnvironment: String {
    let filepath = Bundle.main.path(forResource: "ipFile", ofType: "plist")
    let ipDict = NSDictionary(contentsOfFile: filepath ?? "")
    guard let ipDict = ipDict, let netEnv = ipDict["api_environment"] as? String else {
        return ""
    }
    return netEnv
}

// MARK: - 拼接全URL
extension String {
    public var fullURL: String {
        return "\(kNetProtocol)\(kNetEnvironment)\(self)"
    }
}
