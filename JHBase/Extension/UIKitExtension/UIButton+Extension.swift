//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit

// MARK:- 1、Button的基本事件
private var buttonCallBackKey: Void?
extension UIButton: JHSwiftPropertyCompatible {
    internal typealias T = UIButton
    internal var swiftCallBack: SwiftCallBack? {
        get { return jh_getAssociatedObject(self, &buttonCallBackKey) }
        set { jh_setRetainedAssociatedObject(self, &buttonCallBackKey, newValue) }
    }
    
    @objc internal func swiftButtonAction(_ button: UIButton) {
        self.swiftCallBack?(button)
    }
}

public extension JHUIKit where Base: UIButton {
    
    // MARK: 1.1、button的事件
    /// button的事件
    /// - Parameters:
    ///   - controlEvents: 事件类型，默认是 valueChanged
    ///   - buttonCallBack: 事件
    /// - Returns: 闭包事件
    func setHandleClick(controlEvents: UIControl.Event = .touchUpInside, buttonCallBack: ((_ button: UIButton?) -> ())?){
        base.swiftCallBack = buttonCallBack
        base.addTarget(base, action: #selector(base.swiftButtonAction), for: controlEvents)
    }
}
