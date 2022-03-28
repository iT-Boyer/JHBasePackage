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

public class JHBaseStatusManager: NSObject {
    // MARK: - API
    public static var currentStauts: JHBaseNetStatus { shared.currentStauts }
    public static var isReachable: Bool { shared.isReachable }
    public static var isWiFi: Bool { shared.isWiFi }
    public static var isCellular: Bool { shared.isCellular }
    public static func startListening() { shared.startListening() }
    public static func stopListening() { shared.stopListening() }
    
    // MARK: - Private
    private static let shared = JHBaseStatusManager()
    private override init() {
        super.init()
        startListening()
    }
    private let alamoManager = NetworkReachabilityManager.default
    private var currentStauts: JHBaseNetStatus = JHBaseNetStatus.cellular
    
    private var isReachable: Bool {
        return alamoManager?.isReachable ?? true
    }
    
    private var isWiFi: Bool {
        alamoManager?.isReachableOnEthernetOrWiFi ?? false
    }
    
    private var isCellular: Bool {
        alamoManager?.isReachableOnCellular ?? false
    }
    
    private func startListening() {
        alamoManager?.startListening(onUpdatePerforming: { [weak self] status in
            guard let strongSelf = self else { return }
            switch status {
            case .reachable(.cellular):
                strongSelf.currentStauts = JHBaseNetStatus.cellular
            case .reachable(.ethernetOrWiFi):
                strongSelf.currentStauts = JHBaseNetStatus.wifi
            case .notReachable, .unknown:
                strongSelf.currentStauts = JHBaseNetStatus.unavailable
            default:
                strongSelf.currentStauts = JHBaseNetStatus.unavailable
            }
            DispatchQueue.main.async {
                let notiObj = strongSelf.currentStauts.rawValue
                NotificationCenter.default.post(name: kJHBaseStatusNotiName, object: notiObj)
            }
        })
    }
    
    private func stopListening() {
        alamoManager?.stopListening()
    }
}
