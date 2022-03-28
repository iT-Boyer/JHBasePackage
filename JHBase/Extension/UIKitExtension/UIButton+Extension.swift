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

// MARK:- 二、UIButton 图片 与 title 位置关系
/// UIButton 图片与title位置关系 https://www.jianshu.com/p/0f34c1b52604
public extension JHUIKit where Base: UIButton {
    
    /// 图片 和 title 的布局样式
    enum ImageTitleLayout {
        case imgTop
        case imgBottom
        case imgLeft
        case imgRight
    }
    
    // MARK: 2.1、设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
    /// 设置图片和 title 的位置关系(提示：title和image要在设置布局关系之前设置)
    /// - Parameters:
    ///   - layout: 布局
    ///   - spacing: 间距
    /// - Returns: 返回自身
    @discardableResult
    func setImageTitleLayout(_ layout: ImageTitleLayout, spacing: CGFloat = 0) -> UIButton {
        switch layout {
        case .imgLeft:
            alignHorizontal(spacing: spacing, imageFirst: true)
        case .imgRight:
            alignHorizontal(spacing: spacing, imageFirst: false)
        case .imgTop:
            alignVertical(spacing: spacing, imageTop: true)
        case .imgBottom:
            alignVertical(spacing: spacing, imageTop: false)
        }
        return self.base
    }
    
    /// 水平方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageFirst: 图片是否优先
    private func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        base.imageEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -edgeOffset,
                                       bottom: 0,
                                       right: edgeOffset)
        base.titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: edgeOffset,
                                       bottom: 0,
                                       right: -edgeOffset)
        if !imageFirst {
            base.transform = CGAffineTransform(scaleX: -1, y: 1)
            base.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            base.titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        base.contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }
    
    /// 垂直方向
    /// - Parameters:
    ///   - spacing: 间距
    ///   - imageTop: 图片是不是在顶部
    private func alignVertical(spacing: CGFloat, imageTop: Bool) {
        guard let imageSize = self.base.imageView?.image?.size,
              let text = self.base.titleLabel?.text,
              let font = self.base.titleLabel?.font
            else {
                return
        }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let imageVerticalOffset = (titleSize.height + spacing) / 2
        let titleVerticalOffset = (imageSize.height + spacing) / 2
        let imageHorizontalOffset = (titleSize.width) / 2
        let titleHorizontalOffset = (imageSize.width) / 2
        let sign: CGFloat = imageTop ? 1 : -1
        
        base.imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
                                       left: imageHorizontalOffset,
                                       bottom: imageVerticalOffset * sign,
                                       right: -imageHorizontalOffset)
        base.titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
                                       left: -titleHorizontalOffset,
                                       bottom: -titleVerticalOffset * sign,
                                       right: titleHorizontalOffset)
        // increase content height to avoid clipping
        let edgeOffset = (min(imageSize.height, titleSize.height) + spacing) / 2
        base.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
    }
}

