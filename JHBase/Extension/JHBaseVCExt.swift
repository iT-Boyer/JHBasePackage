//
//  File.swift
//  
//
//  Created by lifei on 2021/9/7.
//

import UIKit

extension UIViewController {
    
    public static var topVC: UIViewController? {
        return seekTopVC()
    }
    
    public static var topMostVC: UIViewController? {
        var topVC = kWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
    
    public static var getRootPresentedVC: UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if ((rootVC?.presentedViewController) != nil) {
            return rootVC?.presentedViewController
        }
        return rootVC
    }
    
    public static var getRootNaviTopVC: UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if let navVC = rootVC as? UINavigationController {
            return navVC.topViewController
        }
        return rootVC
    }
    
    // MARK: - Private
    private static func seekTopVC(base: UIViewController? = kWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return seekTopVC(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let sel = tab.selectedViewController {
            return seekTopVC(base: sel)
        } else if let presented = base?.presentedViewController {
            return seekTopVC(base: presented)
        }
        return base
    }
}
