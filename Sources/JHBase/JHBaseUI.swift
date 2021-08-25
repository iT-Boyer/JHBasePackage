//
//  Common-Constant.swift
//  SPLib
//
//  Created by lifei on 2021/8/16.
//

import UIKit

public let kScreenBounds: CGRect = UIScreen.main.bounds
public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let kScreenScale: CGFloat = UIScreen.main.scale

public var kPhoneXSeries: Bool {
    if #available(iOS 11.0, *) {
        guard let appDelegate = UIApplication.shared.delegate else { return false }
        guard let appWindow = appDelegate.window else { return false }
        let safeBottom: CGFloat = appWindow?.safeAreaInsets.bottom ?? 0
        return (safeBottom > 0)
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

public var kEmptyBottomHeight: CGFloat {
    return kPhoneXSeries ? 34.0 : 0
}

public var kTabbarHeight: CGFloat {
    return kPhoneXSeries ? 83.0 : 49.0
}

public var kNaviBarHeight: CGFloat {
    return 44.0
}

public var kNaviBarMaxY: CGFloat {
    return kNaviBarHeight + kStatusBarHeight;
}
