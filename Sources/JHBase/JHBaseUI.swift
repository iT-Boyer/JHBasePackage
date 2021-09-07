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
        guard let keyWin: UIWindow? = UIApplication.shared.delegate?.window else { return false }
        guard let safeBtm: CGFloat = keyWin?.safeAreaInsets.bottom else { return false }
        return (safeBtm > 0)
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
