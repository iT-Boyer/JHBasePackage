//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit

extension UIView: JHUIKitCompatible {}

// MARK:一、UIView 有关 Frame 的扩展
public extension JHUIKit where Base: UIView{
    // MARK: 1.1、x 的位置
    /// x 的位置
    var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.x = newValue
            base.frame = tempFrame
        }
    }
    // MARK: 1.2、y 的位置
    /// y 的位置
    var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.origin.y = newValue
            base.frame = tempFrame
        }
    }
    
    // MARK: 1.3、height: 视图的高度
    /// height: 视图的高度
    var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.height = newValue
            base.frame = tempFrame
        }
    }
    
    // MARK: 1.4、width: 视图的宽度
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.width = newValue
            base.frame = tempFrame
        }
    }
    
    // MARK: 1.5、size: 视图的zize
    /// size: 视图的zize
    var size: CGSize {
        get {
            return base.frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size = newValue
            base.frame = tempFrame
        }
    }
    
    // MARK: 1.6、centerX: 视图的X中间位置
    /// centerX: 视图的X中间位置
    var centerX: CGFloat {
        get {
            return base.center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.x = newValue
            base.center = tempCenter
        }
    }
    
    // MARK: 1.7、centerY: 视图的Y中间位置
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return base.center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = base.center
            tempCenter.y = newValue
            base.center = tempCenter
        }
    }
}

// MARK: 2、手势的扩展
public extension JHUIKit where Base: UIView {
    // MARK: 2.1、通用响应添加方法
    /// 通用响应添加方法
    /// - Parameter actionClosure: 时间回调
    func addActionClosure(_ actionClosure: @escaping ViewClosure) {
        if let sender = self.base as? UIButton {
            sender.jh.setHandleClick(controlEvents: .touchUpInside) { (control) in
                guard let weakControl = control else {
                    return
                }
                actionClosure(nil, weakControl, weakControl.tag)
            }
        } else if let sender = self.base as? UIControl {
            sender.jh.addActionHandler({ (control) in
                actionClosure(nil, control, control.tag)
            }, for: .valueChanged)
        } else {
            _ = self.base.jh.addGestureTap { (reco) in
                actionClosure((reco as! UITapGestureRecognizer), reco.view!, reco.view!.tag)
            }
        }
    }
    
    // MARK: 2.2、手势 - 单击
    /// 手势 - 单击
    /// - Parameter action: 事件
    /// - Returns: 手势
    @discardableResult
    func addGestureTap(_ action: @escaping RecognizerClosure) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        // 轻点次数
        obj.numberOfTapsRequired = 1
        // 手指个数
        obj.numberOfTouchesRequired = 1
        addCommonGestureRecognizer(obj)
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
    
    //MARK: 通用支持手势的方法 - private
    private func addCommonGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        base.isUserInteractionEnabled = true
        base.isMultipleTouchEnabled = true
        base.addGestureRecognizer(gestureRecognizer)
    }

}
