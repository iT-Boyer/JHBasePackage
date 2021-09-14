//
//  File.swift
//  
//
//  Created by lifei on 2021/9/7.
//

import UIKit

extension UIViewController {
    
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
}
