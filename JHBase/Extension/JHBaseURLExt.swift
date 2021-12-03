//
//  File.swift
//  
//
//  Created by lifei on 2021/9/3.
//

import Foundation

extension URL {
    public static func changProtocolURL(with urlString: String?) -> URL? {
        let httpStr = JHBaseDomain.changeProtocol(with: urlString)
        if httpStr.isEmpty == true { return nil }
        return URL(string: httpStr)
    }
}
