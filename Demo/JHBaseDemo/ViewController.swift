//
//  ViewController.swift
//  JHBaseDemo
//
//  Created by lifei on 2021/8/27.
//

import UIKit
import JHBase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.backgroundColor = .randomColor()
        self.test()
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

}

