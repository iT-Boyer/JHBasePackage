//
//  JHBaseNavVC.swift
//  JHBase
//
//  Created by lifei on 2021/8/26.
//

import UIKit

// MARK: - JHBaseNavVC

open class JHBaseNavVC: UIViewController {
    typealias RefreshClosure = () -> Void
    var refreshClosure: RefreshClosure?
    
    open var navTitle: String? {
        didSet {
            if let tmpTitle = navTitle, tmpTitle.count > 0 {
                self.navBar.titleLabel.text = tmpTitle
            }
        }
    }
    
    // MARK: - Init
    
    public init(title: String) {
        self.navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .kF5F5F5
        self.view.addSubview(self.navBar)
        self.navBar.frame = .init(x: 0, y: 0, width: kScreenWidth, height: kNaviBarMaxY)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @objc open func backBtnClicked(_ btn: UIButton) -> Void {
        guard let navi = self.navigationController else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        if navi.viewControllers.count == 1 {
            self.dismiss(animated: false, completion: nil)
        } else {
            navi.popViewController(animated: true)
        }
    }
    
    @objc func refreshBtnClicked(_ btn: UIButton) -> Void {
        guard let refreshBlock = self.refreshClosure else { return }
        refreshBlock()
    }
    
    // MARK: - API
    
    func showNoDataView() -> Void {
        self.emptyView.refreshBtn.isHidden = true
        #if SWIFT_PACKAGE
        let imgPath = String(format: "%@/nodata_green", Bundle.module.bundlePath)
        self.emptyView.imgView.image = UIImage.init(named: imgPath)
        #endif
        if self.view.subviews.contains(self.emptyView) {
            self.view.bringSubviewToFront(self.emptyView)
        } else {
            self.view.addSubview(self.emptyView)
        }
        self.emptyView.setNeedsLayout()
    }
    
    func showNoInternet() -> Void {
        self.emptyView.refreshBtn.isHidden = false
        #if SWIFT_PACKAGE
        let imgPath = String(format: "%@/nodata_blue", Bundle.module.bundlePath)
        self.emptyView.imgView.image = UIImage.init(named: imgPath)
        #endif
        if self.view.subviews.contains(self.emptyView) {
            self.view.bringSubviewToFront(self.emptyView)
        } else {
            self.view.addSubview(self.emptyView)
        }
        self.emptyView.setNeedsLayout()
    }
    
    // MARK: - Lazy Load
    
    lazy public var navBar: JHBaseNavBar = {
        let tmpView = JHBaseNavBar.init(frame: .zero)
        tmpView.backBtn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        return tmpView
    }()
    
    lazy public var emptyView: JHBaseEmptyView = {
        let tmpView = JHBaseEmptyView.init(frame: .zero)
        tmpView.refreshBtn.addTarget(self, action: #selector(refreshBtnClicked(_:)), for: .touchUpInside)
        return tmpView
    }()

}

// MARK: - JHBaseNavBar

open class JHBaseNavBar: UIView {
    
    open var navTitle: String? {
        didSet {
            if let tmpTitle = navTitle, tmpTitle.count > 0 {
                self.titleLabel.text = tmpTitle
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .kFCFCFC
        self.addSubview(self.titleLabel)
        self.addSubview(self.backBtn)
        self.addSubview(self.lineView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let titleLabelW = kScreenWidth - 120
        self.titleLabel.frame = .init(x: 60, y: kStatusBarHeight, width: titleLabelW, height: kNaviBarHeight)
        self.backBtn.frame = .init(x: 0, y: kStatusBarHeight, width: 60, height: 44)
        
        let lineY = self.frame.size.height - 1
        let lineW = self.frame.size.width
        self.lineView.frame = .init(x: 0, y: lineY, width: lineW, height: 1)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lazy Load
    lazy public var titleLabel: UILabel = {
        let tmpLabel = UILabel.init(frame: .zero)
        tmpLabel.font = .kBoldFont18
        tmpLabel.textColor = .k333333
        tmpLabel.textAlignment = .center
        return tmpLabel
    }()
    
    lazy public var backBtn: UIButton = {
        let tmpBtn = UIButton.init(type: .custom)
        #if SWIFT_PACKAGE
        let imgPath = String(format: "%@/arrow_left_dark", Bundle.module.bundlePath)
        tmpBtn.setImage(UIImage.init(named: imgPath), for: .normal)
        #endif
        return tmpBtn
    }()
    
    lazy public var lineView: UIView = {
        let tmpView = UIView.init(frame: .zero)
        tmpView.backgroundColor = .kF7F7F7
        return tmpView
    }()
}

// MARK: - JHBaseEmptyView

open class JHBaseEmptyView: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imgView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.refreshBtn)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imgView.sizeToFit()
        let imgW = self.imgView.bounds.size.width
        let imgH = self.imgView.bounds.size.height
        
        let titleW = kScreenWidth - 24
        let titleH = self.titleLabel.sizeThatFits(.init(width: titleW, height: kScreenHeight)).height
        
        let imgX = (kScreenWidth - imgW) * 0.5
        let imgY = (kScreenHeight - imgH - 20 - titleH - 10 - 30) * 0.5
        self.imgView.frame = .init(x: imgX, y: imgY, width: imgW, height: imgH)
        
        let titleLabelY = self.imgView.frame.maxY + 20
        self.titleLabel.frame = .init(x: 0, y: titleLabelY, width: titleW, height: titleH)
        
        let btnX = (kScreenWidth - 90) * 0.5
        let btnY = self.titleLabel.frame.maxY + 10
        self.refreshBtn.frame = .init(x: btnX, y: btnY, width: 90, height: 30)
    }
    
    // MARK: - Lazy Load
    
    lazy public var titleLabel: UILabel = {
        let tmpLabel = UILabel.init(frame: .zero)
        tmpLabel.font = .kFont14
        tmpLabel.textAlignment = .center
        tmpLabel.textColor = .k999999
        tmpLabel.numberOfLines = 0
        return tmpLabel
    }()
    
    lazy public var imgView: UIImageView = {
        let tmpView = UIImageView.init(frame: .zero)
        #if SWIFT_PACKAGE
        let imgPath = String(format: "%@/nodata_green", Bundle.module.bundlePath)
        tmpView.image = UIImage.init(named: imgPath)
        #endif
        return tmpView
    }()
    
    lazy public var refreshBtn: UIButton = {
        let tmpBtn = UIButton.init(type: .custom)
        tmpBtn.isHidden = true
        #if SWIFT_PACKAGE
        let normalPath = String(format: "%@/refresh_text_normal", Bundle.module.bundlePath)
        let highlightPath = String(format: "%@/refresh_text_highlight", Bundle.module.bundlePath)
        tmpBtn.setImage(UIImage.init(named: normalPath), for: .normal)
        tmpBtn.setImage(UIImage.init(named: highlightPath), for: .highlighted)
        #endif
        return tmpBtn
    }()
}
