//
//  File.swift
//  
//
//  Created by lifei on 2021/9/3.
//

import Foundation

extension URL {
    public static func changProtocolURL(with urlString: String?) -> URL? {
        guard let urlStr = urlString, urlStr.isEmpty == false else { return nil }
        
        let lowerUrl = urlStr.lowercased()
        if lowerUrl.hasPrefix("https") {
            return URL(string: urlStr)
        }
        
        let whiteList = ["http://testlvp.iuoooo.com/H5MyLive/Index",
                         "http://lvp.iuoooo.com/H5MyLive/Index",
                         "http://open.ys7.com/openlive",
                         "http://www.iermu.com/thirdpart_shareid.php",
                         "http://d.pcs.baidu.com",
                         "lvp.iuoooo.com",
                         "iwp.e.iuoooo",
                         "bbs.iuoooo.com"]
        for whiteStr in whiteList {
            if urlStr.contains(whiteStr) == true {
                return URL(string: urlStr)
            }
        }
        
        if lowerUrl.hasPrefix("http") == false || lowerUrl.contains("iuoooo.com") == false {
            return URL(string: urlStr)
        }
        // 不包含 iuoooo.com
        var urlList:[String] = urlStr.components(separatedBy: "://")
        if urlList.count > 0 {
            urlList[0] = "https"
        }
        let joinedUrl = urlList.joined(separator: "://")
        return URL(string: joinedUrl)
    }
}
