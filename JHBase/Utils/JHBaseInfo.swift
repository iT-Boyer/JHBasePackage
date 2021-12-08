//  Created by lifei on 2021/12/8.
//  读取应用基础信息

import UIKit
import GRDB

// MARK: - API
public class JHBaseInfo: NSObject {
    
    public static let shared = JHBaseInfo()
    private override init() {}
    
    private static let emptyID = "00000000-0000-0000-0000-000000000000"
    private static let kJHBaseAnonymousLoginNotiName = "kJHBaseAnonymousLoginNotiName"
    
    // MARK: - API
    //public static let appID = ""
    public static let bundleID = ""
    public static let appVersion = ""
    
    public static var orgID: String {
        let infoOrgID = Bundle.main.infoDictionary?["ORGID"] as? String
        return infoOrgID ?? ""
    }
    
    public static var appID: String {
        let defaultsAppID = UserDefaults.standard.string(forKey: "ProjectAppIDKey20160922")
        if let defaultsAppID = defaultsAppID, defaultsAppID.isEmpty == false {
            return defaultsAppID
        }
        let infoAppID = Bundle.main.infoDictionary?["APPID"] as? String
        return infoAppID ?? ""
    }
    
    public static var userID: String {
        let officialName = shared.userInfoDict["LOGINUSERID"] as? String
        let anonymousName = shared.userInfoDict["ANONYMOUSUSERNAME"] as? String
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
    
    public static var userAccount: String {
        if isOfficialLogined == true {
            let officialName = shared.userInfoDict["USERNAME"] as? String
            return officialName ?? ""
        }
        let anonymousName = shared.userInfoDict["ANONYMOUSUSERACCOUNT"] as? String
        return anonymousName ?? ""
    }
    
    public static var isLogined: Bool {
        let officialStatus = shared.userInfoDict["LOGINSTATUS"] as? String
        let anonymousStatus = shared.userInfoDict["ANONYMOUSLOGINSTATUS"] as? String
        if let status = officialStatus, status == "YES" {
            return true
        }
        if let status = anonymousStatus, status == "YES" {
            return true
        }
        return false
    }
    
    public static var isOfficialLogined: Bool {
        let officialStatus = shared.userInfoDict["LOGINSTATUS"] as? String
        if let status = officialStatus, status == "YES" {
            return true
        }
        return false
    }
    
    public static var userName: String {
        return userMsgModel.userName ?? ""
    }
    
    public static var userIcon: String {
        return userMsgModel.userHeadurl ?? ""
    }
    
    public static var userMsgDict: [String: Any] {
        return userMsgModel.toDict()
    }
    
    fileprivate static var userMsgModel: UserMessage {
        let emptyModel = UserMessage()
        let dbPath = shared.databasePath
        if dbPath.isEmpty == true { return emptyModel }
        guard let dbQueue = try? DatabaseQueue(path: dbPath) else { return emptyModel }
        let players: [UserMessage]? = try? dbQueue.read { db in
            try UserMessage.fetchAll(db)
        }
        guard let userMsg = players?.last else { return emptyModel }
        return userMsg
    }
    
    // MARK: - Lazy Load
    private lazy var userInfoDict: [String: Any] = {
        guard let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return [:] }
        let filePath = documentDir.appendingPathComponent("userinfo.plist")
        let fileURL = URL(fileURLWithPath: filePath)
        let fileDict = try? NSDictionary(contentsOf: fileURL, error: ())
        if let fileDict = fileDict as? [String: Any] {
            return fileDict
        }
        return [:]
    }()
    
    lazy var databasePath: String = {
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        guard let cacheDir = cacheDir else { return "" }
        let sqlitePath = cacheDir.appendingPathComponent("JHBase.db")
        return sqlitePath
    }()
}

/// 数据库 JHBase.db 中保存的 UserMessage
fileprivate struct UserMessage: Codable, FetchableRecord, PersistableRecord {
    var userid: String?
    var userName: String?
    var missHome: String?
    var homeTown: String?
    var persionalized: String?
    var error: String?
    var liveCity: String?
    var userHeadurl: String?
    var phoneNumber: String?
    var hometownCode: String?
    var sexNum: Int?
    var birthday: String?
    
    func toDict() -> [String: Any] {
        let tmpDict: [String: Any] = ["userid": userid ?? "",
                                      "userName": userName ?? "",
                                      "missHome": missHome ?? "",
                                      "homeTown": homeTown ?? "",
                                      "persionalized": persionalized ?? "",
                                      "error": error ?? "",
                                      "liveCity": liveCity ?? "",
                                      "userHeadurl": userHeadurl ?? "",
                                      "phoneNumber":phoneNumber ?? "",
                                      "hometownCode": hometownCode ?? "",
                                      "sexNum": sexNum ?? 0,
                                      "birthday": birthday ?? ""]
        
        return tmpDict
    }
}
