//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit

private struct AssociateKeys {
    static var closure = "UIControl" + "closure"
}

public extension JHUIKit where Base: UIControl {
    
    // MARK: 1.1、多少秒内不可重复点击
    // 多少秒内不可重复点击
    func preventDoubleHit(_ hitTime: Double = 1) {
        base.preventDoubleHit(hitTime)
    }
    
    /// UIControl 添加回调方式
    func addActionHandler(_ action: @escaping ControlClosure, for controlEvents: UIControl.Event = .touchUpInside) {
        self.base.addTarget(self, action: #selector(base.handleAction), for: controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private var hitTimerKey: Void?
fileprivate extension UIControl  {
    
    private var hitTime: Double? {
        get { return jh_getAssociatedObject(self, &hitTimerKey) }
        set { jh_setRetainedAssociatedObject(self, &hitTimerKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    func preventDoubleHit(_ hitTime: Double) {
        self.hitTime = hitTime
        addTarget(self, action: #selector(c_preventDoubleHit), for: .touchUpInside)
    }
    
    @objc func c_preventDoubleHit(_ base: UIControl)  {
        base.isUserInteractionEnabled = false
        JHAsyncs.asyncDelay(hitTime ?? 1.0) {
        } _: {
            base.isUserInteractionEnabled = true
        }
    }
    
    /// 点击回调
    @objc func handleAction(_ sender: UIControl) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ControlClosure {
            block(sender)
        }
    }
}
