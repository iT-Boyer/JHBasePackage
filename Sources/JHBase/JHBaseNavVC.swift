//
//  JHBaseNavVC.swift
//  JHBase
//
//  Created by lifei on 2021/8/26.
//

import UIKit

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
        tmpLabel.font = .boldSystemFont(ofSize: 18)
        tmpLabel.textAlignment = .center
        return tmpLabel
    }()
    
    lazy public var backBtn: UIButton = {
        let tmpBtn = UIButton.init(type: .custom)
        #if SWIFT_PACKAGE
        if let imgPath = Bundle.module.path(forResource: "arrow_left_dark@2x", ofType: "png") {
            let btnImg = UIImage.init(named: imgPath)
            tmpBtn.setImage(btnImg, for: .normal)
        }
        #endif
        return tmpBtn
    }()
    
    lazy public var lineView: UIView = {
        let tmpView = UIView.init(frame: .zero)
        tmpView.backgroundColor = .initWithHex("#F7F7F7")
        return tmpView
    }()
}
