//
//  Common-Constant.swift
//  SPLib
//
//  Created by lifei on 2021/8/16.
//  UI 适配全局常量

import UIKit

public let kScreenBounds: CGRect  = UIScreen.main.bounds
public let kScreenWidth: CGFloat  = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let kScreenScale: CGFloat  = UIScreen.main.scale

public let kEmptyBottomHeight: CGFloat = kPhoneXSeries ? 34.0 : 0
public let kTabbarHeight: CGFloat      = kPhoneXSeries ? 83.0 : 49.0
public let kNaviBarHeight: CGFloat     = 44.0
public let kNaviBarMaxY: CGFloat       = kNaviBarHeight + kStatusBarHeight

public var kPhoneXSeries: Bool {
    if #available(iOS 11.0, *) {
        guard let keyWin = kWindow else { return false }
        return (keyWin.safeAreaInsets.bottom > 0)
    }
    return false
}

public var kStatusBarHeight: CGFloat {
    var statusBarH: CGFloat = 0;
    if #available(iOS 13.0, *) {
        guard let appWindow: UIWindow = UIApplication.shared.windows.first else { return 20 }
        statusBarH = appWindow.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 20
    } else {
        statusBarH = UIApplication.shared.statusBarFrame.size.height
    }
    return statusBarH
}

public func kWidth(width: CGFloat) -> CGFloat{
    let wth = (kScreenWidth/320)*(width)
    return wth
}

public func kHeight(height: CGFloat) -> CGFloat{
    let hgt = (kScreenWidth/320)*(height)
    return hgt
}

public var kWindow: UIWindow? {
    var resultWindow: UIWindow? = nil
    if #available(iOS 13.0, *) {
        let scenesSet = UIApplication.shared.connectedScenes
        for scene in scenesSet {
            guard let winScene = scene as? UIWindowScene else { continue }
            if let keyWin = winScene.windows.first(where: { $0.isKeyWindow }) {
                resultWindow = keyWin
            }
        }
        if let scene = scenesSet.first as? UIWindowScene, resultWindow == nil {
            resultWindow = scene.windows.first
        }
        return resultWindow
    }
    return UIApplication.shared.delegate?.window ?? resultWindow
}
