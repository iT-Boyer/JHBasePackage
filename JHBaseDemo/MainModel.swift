//
//  MainModel.swift
//  JHBaseDemo
//
//  Created by lifei on 2021/8/25.
//

import UIKit
//import JHBase

class MainModel: NSObject {
    
    @objc public func test() -> Void {
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
