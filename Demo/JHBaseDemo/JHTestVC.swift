//
//  JHTestVC.swift
//  JHBaseDemo
//
//  Created by lifei on 2021/8/27.
//

import UIKit
import JHBase

class JHTestVC: JHBaseNavVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "测试控制器"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.backgroundColor = .randomColor()
        test()
        self.showNoDataView(self.view)
    }
    
    public func test() -> Void {
        print("kScreenBounds:\(kScreenBounds)")
        print("kScreenWidth:\(kScreenWidth)")
        print("kScreenHeight:\(kScreenHeight)")
        print("kScreenScale:\(kScreenScale)")
        print("kEmptyBottomHeight:\(kEmptyBottomHeight)")
        print("kTabbarHeight:\(kTabbarHeight)")
        print("kNaviBarHeight:\(kNaviBarHeight)")
        print("kStatusBarHeight:\(kStatusBarHeight)")
        print("kNaviBarMaxY:\(kNaviBarMaxY)")
    }
    
    deinit {
        print("Dealloc")
    }

}
