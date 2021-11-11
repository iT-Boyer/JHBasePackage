//
//  JHBaseNetStatus.swift
//  SwiftDemo
//
//  Created by lifei on 2021/11/11.
//  网络状态监听工具类

import UIKit
import Alamofire

public let kJHBaseStatusNotiName = Notification.Name("kJHBaseNetStatusChanged")

public enum JHBaseNetStatus: String {
    case unavailable = "unavailable"
    case cellular    = "cellular"
    case wifi        = "wifi"
}

class JHBaseStatusManager: NSObject {
    public static let shared = JHBaseStatusManager()
    
    // MARK: - private
    private override init() {}
    private let alamoManager = NetworkReachabilityManager.default
    
    // MARK: - API
    public var currentStauts: JHBaseNetStatus = JHBaseNetStatus.cellular
    
    public var isReachable: Bool {
        return alamoManager?.isReachable ?? false
    }
    
    public var isWiFi: Bool {
        alamoManager?.isReachableOnEthernetOrWiFi ?? false
    }
    
    public var isCellular: Bool {
        alamoManager?.isReachableOnCellular ?? false
    }
    
    public func startListening() {
        alamoManager?.startListening(onUpdatePerforming: { [weak self] status in
            guard let strongSelf = self else { return }
            switch status {
            case .notReachable, .unknown:
                strongSelf.currentStauts = JHBaseNetStatus.unavailable
            case .reachable(.cellular):
                strongSelf.currentStauts = JHBaseNetStatus.cellular
            case .reachable(.ethernetOrWiFi):
                strongSelf.currentStauts = JHBaseNetStatus.wifi
            }
            NotificationCenter.default.post(name: kJHBaseStatusNotiName, object: strongSelf.currentStauts)
        })
    }
    
    public func stopListening() {
        alamoManager?.stopListening()
    }
}
