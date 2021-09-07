//
//  File.swift
//  
//
//  Created by lifei on 2021/9/7.
//

import UIKit

extension UIViewController {
    
    public static var getTopMostVC: UIViewController? {
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        while ((rootVC?.presentationController) != nil) {
            rootVC = rootVC?.presentedViewController
        }
        return rootVC
    }
    
    public static var getPresentedVC: UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if ((rootVC?.presentationController) != nil) {
            return rootVC?.presentedViewController
        }
        return rootVC
    }
    
    public static var getRootVC: UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if let navVC = rootVC as? UINavigationController {
            return navVC.topViewController
        }
        return rootVC
    }
}
