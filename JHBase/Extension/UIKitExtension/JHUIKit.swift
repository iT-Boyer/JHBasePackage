//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit
public struct JHUIKit<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JHUIKitCompatible {}

public extension JHUIKitCompatible {
    
    static var jh: JHUIKit<Self>.Type {
        get{ JHUIKit<Self>.self }
        set {}
    }
    
    var jh: JHUIKit<Self> {
        get { JHUIKit(self) }
        set {}
    }
}

/// Define Property protocol
internal protocol JHSwiftPropertyCompatible {
  
    /// Extended type
    associatedtype T
    
    ///Alias for callback function
    typealias SwiftCallBack = ((T?) -> ())
    
    ///Define the calculated properties of the closure type
    var swiftCallBack: SwiftCallBack?  { get set }
}
