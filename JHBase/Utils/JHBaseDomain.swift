//  Created by lifei on 2021/11/29.
//  域名统一调用工具

import Foundation

public class JHBaseDomain: NSObject {
    public static let shared = JHBaseDomain()
    private override init() {}
    
    // MARK: - API
    public static let netProtocol: String = shared.netProtocol
    public static let environment: String = shared.environment
    public static let uploadURL: String = shared.uploadBaseURL
    public static let downloadURL: String = shared.downloadBaseURL
    
    public static func domain(for key: String?) -> String {
        //TODO: - 待增加私有化逻辑
        guard let domainKey = key, domainKey.isEmpty == false else { return "" }
        let domain = shared.ipFileDict[domainKey.lowercased()] ?? ""
        return domain
    }
    
    public static func fullURL(with key: String?, path: String?) -> String {
        let domainKey = key ?? ""
        let domainURL = domain(for: domainKey)
        let domainPath = path ?? ""
        return "\(netProtocol)\(environment)\(domainURL)\(domainPath)"
    }
    
    public static func changeProtocol(with url: String?) -> String {
        guard let urlStr = url, urlStr.isEmpty == false else { return "" }
        
        let lowerUrl = urlStr.lowercased()
        if lowerUrl.hasPrefix("https") {
            return urlStr
        }
        let isWhite = shared.whiteList.contains { urlStr.contains($0) }
        if isWhite == true { return urlStr }
        
        if lowerUrl.hasPrefix("http") == false || lowerUrl.contains("iuoooo.com") == false {
            return urlStr
        }
        var urlList: [String] = urlStr.components(separatedBy: "://")
        if urlList.isEmpty == false {
            urlList[0] = "https"
        }
        
        let joinedUrl = urlList.joined(separator: "://")
        return joinedUrl
    }
    
    // MARK: - Lazy Load
    private lazy var ipFileDict: [String: String] = {
        let fileURL = Bundle.main.url(forResource: "ipFile", withExtension: "plist")
        guard let tmpFileURL = fileURL else { return [:] }
        let fileDict = try? NSDictionary(contentsOf: tmpFileURL, error: ())
        guard let fileDict = fileDict as? [String: String] else { return [:] }
        return fileDict
    }()
    
    private lazy var environment: String = {
        return JHBaseDomain.domain(for: "api_environment")
    }()
    
    private lazy var netProtocol: String = {
        let urlProtocol = JHBaseDomain.domain(for: "api_header")
        if urlProtocol.isEmpty == true { return "https://" }
        return urlProtocol
    }()
    
    private lazy var uploadBaseURL: String = {
        let domainTest = JHBaseDomain.domain(for: "api_host_upload")
        let domainProduct = JHBaseDomain.domain(for: "api_host_upload_up")
        if environment.isEmpty == false {
            return "\(netProtocol)\(environment)\(domainTest)"
        }
        return "\(netProtocol)\(environment)\(domainProduct)"
    }()
    
    private lazy var downloadBaseURL: String = {
        let domain = JHBaseDomain.domain(for: "api_host_upload")
        return "\(netProtocol)\(environment)\(domain)"
    }()
    
    private lazy var whiteList: [String] = {
        let whiteList = ["http://testlvp.iuoooo.com/H5MyLive/Index",
                         "http://lvp.iuoooo.com/H5MyLive/Index",
                         "http://open.ys7.com/openlive",
                         "http://www.iermu.com/thirdpart_shareid.php",
                         "http://d.pcs.baidu.com",
                         "lvp.iuoooo.com",
                         "iwp.e.iuoooo",
                         "bbs.iuoooo.com"]
        return whiteList
    }()
}
