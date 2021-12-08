//
//  File.swift
//  
//
//  Created by lifei on 2021/10/11.
//

import Foundation

extension String {
    // 拼接全URL
    public var fullURL: String {
        return "\(JHBaseDomain.netProtocol)\(JHBaseDomain.environment)\(self)"
    }
}
