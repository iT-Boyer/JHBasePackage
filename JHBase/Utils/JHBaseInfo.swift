//  Created by lifei on 2021/12/8.
//  读取应用基础信息

import UIKit

// MARK: - API
public class JHBaseInfo: NSObject {
    public static let shared = JHBaseInfo()
    private override init() {}
    
    // MARK: - API
    public static var orgID: String { shared.orgID }
    public static var appID: String { shared.appID }
    public static var appName: String { shared.appName }
    public static var appVersion: String { shared.appVersion }
    
    public static var userID: String { shared.userID }
    public static var userAccount: String { shared.userAccount }
    
    public static var isLogined: Bool { shared.isLogined }
    public static var isOfficialLogined: Bool { shared.isOfficialLogined }
    
    // MARK: - Private
    private let emptyID = "00000000-0000-0000-0000-000000000000"
    private let kJHBaseAnonymousLoginNotiName = "kJHBaseAnonymousLoginNotiName"
    
    private var appID: String {
        let defaultsAppID = UserDefaults.standard.string(forKey: "ProjectAppIDKey20160922")
        if let defaultsAppID = defaultsAppID, defaultsAppID.isEmpty == false {
            return defaultsAppID
        }
        let infoAppID = Bundle.main.infoDictionary?["APPID"] as? String
        return infoAppID ?? ""
    }
    
    private var userID: String {
        let officialName = JHBaseInfo.shared.userInfoDict["LOGINUSERID"] as? String
        let anonymousName = JHBaseInfo.shared.userInfoDict["ANONYMOUSUSERNAME"] as? String
        if let oName = officialName, oName.isEmpty == false, isOfficialLogined == true {
            return oName
        }
        if let aName = anonymousName, aName.isEmpty == false, isOfficialLogined == false {
            return aName
        }
        // 通知大组件(jinheruniversal)匿名登录
        let notiName = Notification.Name(kJHBaseAnonymousLoginNotiName)
        NotificationCenter.default.post(name: notiName, object: nil)
        
        return emptyID
    }
    
    private var userAccount: String {
        if isOfficialLogined == true {
            let officialName = JHBaseInfo.shared.userInfoDict["USERNAME"] as? String
            return officialName ?? ""
        }
        let anonymousName = JHBaseInfo.shared.userInfoDict["ANONYMOUSUSERACCOUNT"] as? String
        return anonymousName ?? ""
    }
    
    private var isLogined: Bool {
        let officialStatus = JHBaseInfo.shared.userInfoDict["LOGINSTATUS"] as? String
        let anonymousStatus = JHBaseInfo.shared.userInfoDict["ANONYMOUSLOGINSTATUS"] as? String
        if let status = officialStatus, status == "YES" {
            return true
        }
        if let status = anonymousStatus, status == "YES" {
            return true
        }
        return false
    }
    
    private var isOfficialLogined: Bool {
        let officialStatus = JHBaseInfo.shared.userInfoDict["LOGINSTATUS"] as? String
        if let status = officialStatus, status == "YES" {
            return true
        }
        return false
    }
    
    private var userInfoDict: [String: Any] {
        guard let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return [:] }
        let filePath = documentDir.appendingPathComponent("userinfo.plist")
        let fileURL = URL(fileURLWithPath: filePath)
        let fileDict = try? NSDictionary(contentsOf: fileURL, error: ())
        if let fileDict = fileDict as? [String: Any] {
            return fileDict
        }
        return [:]
    }
    
    // MARK: - Lazy Load
    private lazy var orgID: String = {
        let infoOrgID = Bundle.main.infoDictionary?["ORGID"] as? String
        return infoOrgID ?? ""
    }()
    
    private lazy var appName: String = {
        let infoAppName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        return infoAppName ?? ""
    }()
    
    private lazy var appVersion: String = {
        let infoAppName = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return infoAppName ?? ""
    }()
}

// MARK: - JHBase暂不依赖数据库，暂不读取用户名和用户图标
//public static var userName: String { shared.userName }
//public static var userIcon: String { shared.userIcon }
//public static var userMsgDict: [String: Any] { shared.userMsgDict }
//private var userName: String {
//    return userMsgModel.userName ?? ""
//}
//
//private var userIcon: String {
//    return userMsgModel.userHeadurl ?? ""
//}
//
//private var userMsgDict: [String: Any] {
//    return userMsgModel.toDict()
//}
//
//fileprivate var userMsgModel: UserMessage {
//    let emptyModel = UserMessage()
//    let dbPath = JHBaseInfo.shared.databasePath
//    if dbPath.isEmpty == true { return emptyModel }
//    guard let dbQueue = try? DatabaseQueue(path: dbPath) else { return emptyModel }
//    let players: [UserMessage]? = try? dbQueue.read { db in
//        try UserMessage.fetchAll(db)
//    }
//    guard let userMsg = players?.last else { return emptyModel }
//    return userMsg
//}

//private lazy var databasePath: String = {
//    let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
//    guard let cacheDir = cacheDir else { return "" }
//    let sqlitePath = cacheDir.appendingPathComponent("JHBase.db")
//    return sqlitePath
//}()

/// 数据库 JHBase.db 中保存的 UserMessage
//fileprivate struct UserMessage: Codable, FetchableRecord, PersistableRecord {
//    var userid: String?
//    var userName: String?
//    var missHome: String?
//    var homeTown: String?
//    var persionalized: String?
//    var error: String?
//    var liveCity: String?
//    var userHeadurl: String?
//    var phoneNumber: String?
//    var hometownCode: String?
//    var sexNum: Int?
//    var birthday: String?
//
//    func toDict() -> [String: Any] {
//        let tmpDict: [String: Any] = ["userid": userid ?? "",
//                                      "userName": userName ?? "",
//                                      "missHome": missHome ?? "",
//                                      "homeTown": homeTown ?? "",
//                                      "persionalized": persionalized ?? "",
//                                      "error": error ?? "",
//                                      "liveCity": liveCity ?? "",
//                                      "userHeadurl": userHeadurl ?? "",
//                                      "phoneNumber":phoneNumber ?? "",
//                                      "hometownCode": hometownCode ?? "",
//                                      "sexNum": sexNum ?? 0,
//                                      "birthday": birthday ?? ""]
//
//        return tmpDict
//    }
//}
