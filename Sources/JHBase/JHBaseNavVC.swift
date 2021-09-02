//
//  JHBaseNavVC.swift
//  JHBase
//
//  Created by lifei on 2021/8/26.
//  UIViewController 基类

import UIKit
import SnapKit

// MARK: - JHBaseNavVC

open class JHBaseNavVC: UIViewController {
    private var refreshClosure: (() -> Void)?
    
    public var navTitle: String? {
        didSet {
            if let tmpTitle = navTitle, tmpTitle.isEmpty == false {
                navBar.titleLabel.text = tmpTitle
            }
        }
    }
    
    // MARK: - Init
    
    public init(title: String) {
        navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .kF5F5F5
        self.view.addSubview(navBar)
        navBar.frame = .init(x: 0, y: 0, width: kScreenWidth, height: kNaviBarMaxY)
        
        configUI()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    open func configUI() {}
    
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
    
    @objc open func refreshBtnClicked(_ btn: UIButton) -> Void {
        guard let refreshBlock = refreshClosure else { return }
        refreshBlock()
    }
    
    // MARK: - API
    @discardableResult
    public func showNoDataView() -> Self {
        return showNoDataView(in: self.view)
    }
    
    @discardableResult
    public func showNoDataView(in superView: UIView?) -> Self {
        emptyView.refreshBtn.isHidden = true
        return showEmptyView(in: superView, imgName: "nodata_green")
    }
    
    @discardableResult
    public func showNoInternet() -> Self {
        return showNoInternet(in: self.view)
    }
    
    @discardableResult
    public func showNoInternet(in superView: UIView?) -> Self {
        emptyView.refreshBtn.isHidden = false
        return showEmptyView(in: superView, imgName: "nodata_blue")
    }
    
    public func refresh(_ closure: (() -> Void)?) -> Void {
        refreshClosure = closure
    }
    
    func showEmptyView(in superView: UIView?, imgName: String) -> Self {
        #if SWIFT_PACKAGE
        let imgPath = String(format: "%@/\(imgName)", Bundle.module.bundlePath)
        emptyView.imgView.image = UIImage.init(named: imgPath)
        #endif
        
        var tmpView: UIView = self.view
        if let superView = superView {
            tmpView = superView
        }
        if tmpView.subviews.contains(emptyView) {
            tmpView.bringSubviewToFront(emptyView)
        } else {
            tmpView.addSubview(emptyView)
        }
        emptyView.frame = tmpView.bounds
        // 不遮挡导航栏
        if tmpView.subviews.contains(navBar) {
            tmpView.bringSubviewToFront(navBar)
        }
        return self
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

public class JHBaseNavBar: UIView {
    
    public var navTitle: String? {
        didSet {
            if let tmpTitle = navTitle, tmpTitle.isEmpty == false {
                titleLabel.text = tmpTitle
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .kFCFCFC
        self.addSubview(titleLabel)
        self.addSubview(backBtn)
        self.addSubview(lineView)
        
        setupFrame()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupFrame() -> Void {
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(kStatusBarHeight)
            make.height.equalTo(kNaviBarHeight)
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(kStatusBarHeight)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
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

public class JHBaseEmptyView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let container: UIView = UIView()
        self.addSubview(container)
        container.addSubview(imgView)
        container.addSubview(titleLabel)
        container.addSubview(refreshBtn)
        
        setupFrame(container: container)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupFrame(container: UIView) -> Void {
        container.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().offset(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(12)
        }
        
        refreshBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Lazy Load
    
    lazy public var titleLabel: UILabel = {
        let tmpLabel = UILabel.init(frame: .zero)
        tmpLabel.text = "暂无数据"
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
