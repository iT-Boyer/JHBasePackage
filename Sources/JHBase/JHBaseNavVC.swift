//
//  JHBaseNavVC.swift
//  JHBase
//
//  Created by lifei on 2021/8/26.
//

import UIKit

// MARK: - JHBaseNavVC

open class JHBaseNavVC: UIViewController {
    
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
    
    @objc open func backBtnClicked(_ backBtn: UIButton) -> Void {
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
    
    // MARK: - Lazy Load
    
    lazy public var navBar: JHBaseNavBar = {
        let navBar = JHBaseNavBar.init(frame: .zero)
        navBar.backBtn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
        return navBar
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.imgView)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let imgX = (kScreenWidth - 130) * 0.5
        let imgY = (kScreenHeight - 76 - 44) * 0.5
        self.imgView.frame = .init(x: imgX, y: imgY, width: 130, height: 76)
        
        let titleLabelY = self.imgView.frame.maxY + 24
        self.titleLabel.frame = .init(x: 0, y: titleLabelY, width: kScreenWidth, height: 20)
    }
    
    // MARK: - Lazy Load
    
    lazy public var titleLabel: UILabel = {
        let tmpLabel = UILabel.init(frame: .zero)
        tmpLabel.font = .kFont14
        tmpLabel.textAlignment = .center
        tmpLabel.textColor = .k999999
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
}
