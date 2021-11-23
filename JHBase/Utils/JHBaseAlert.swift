//  Created by lifei on 2021/11/23.
//  基础系统弹窗

import UIKit

public class JHBaseAlert: NSObject {
    // MARK: - API
    public static func showSheet(title: String? = nil, msg: String? = nil,
                                 btns:[String]? = nil, types:[UIAlertAction.Style]? = nil,
                                 handler: ((Int) -> Void)? = nil)
    {
        showAlertOrSheet(style: .actionSheet, title: title, msg: msg,
                         btns: btns, types: types, handler: handler)
    }
    
    public static func showAlert(title: String? = nil, msg: String? = nil,
                                 btns:[String]? = nil, types:[UIAlertAction.Style]? = nil,
                                 handler: ((Int) -> Void)? = nil)
    {
        showAlertOrSheet(style: .alert, title: title, msg: msg,
                         btns: btns, types: types, handler: handler)
    }
    
    // MARK: - Private
    private static func showAlertOrSheet(style: UIAlertController.Style, title: String? = nil,
                                         msg: String? = nil, btns:[String]? = nil,
                                         types:[UIAlertAction.Style]? = nil, handler: ((Int) -> Void)? = nil)
    {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: style)
        
        let btnsList = btns ?? []
        let typesList = types ?? []
        for (index, value) in btnsList.enumerated() {
            var btnType = UIAlertAction.Style.default
            if index < typesList.count {
                btnType = typesList[index]
            }
            let action = UIAlertAction(title: value, style: btnType) { _ in
                if let handler = handler {
                    handler(index)
                }
            }
            alertVC.addAction(action)
        }
        UIViewController.topVC?.present(alertVC, animated: true, completion: nil)
    }
    
}
