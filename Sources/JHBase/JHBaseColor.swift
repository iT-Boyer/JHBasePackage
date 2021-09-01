//
//  Color_Ext.swift
//  PCSwiftUI
//
//  Created by lifei on 2021/2/19.
//  Color扩展-16进制颜色

import UIKit

// MARK: - UIColor Constant
extension UIColor {
    public static let kClear: UIColor  = UIColor.clear
    public static let k119B83: UIColor = UIColor.initWithHex("119B83")
    public static let k151515: UIColor = UIColor.initWithHex("151515")
    public static let k0ED72F: UIColor = UIColor.initWithHex("0ED72F")
    public static let k02BC9B: UIColor = UIColor.initWithHex("02BC9B")
    public static let k04BD81: UIColor = UIColor.initWithHex("04BD81")
    public static let k999999: UIColor = UIColor.initWithHex("999999")
    public static let k86B94A: UIColor = UIColor.initWithHex("86B94A")
    public static let k87BA4B: UIColor = UIColor.initWithHex("87BA4B")
    public static let kA3A3A3: UIColor = UIColor.initWithHex("A3A3A3")
    public static let kFC6767: UIColor = UIColor.initWithHex("FC6767")
    public static let kFF9F4F: UIColor = UIColor.initWithHex("FF9F4F")
    public static let kFF4242: UIColor = UIColor.initWithHex("FF4242")
    public static let k4AD1C0: UIColor = UIColor.initWithHex("4AD1C0")
    public static let kFF5858: UIColor = UIColor.initWithHex("FF5858")
    public static let kFF5252: UIColor = UIColor.initWithHex("FF5252")
    public static let k666666: UIColor = UIColor.initWithHex("666666")
    public static let kBBBBBB: UIColor = UIColor.initWithHex("BBBBBB")
    public static let kF6F6F6: UIColor = UIColor.initWithHex("F6F6F6")
    public static let kF9F9F9: UIColor = UIColor.initWithHex("F9F9F9")
    public static let kF64610: UIColor = UIColor.initWithHex("F64610")
    public static let kF6FFEA: UIColor = UIColor.initWithHex("F6FFEA")
    public static let k32D4FF: UIColor = UIColor.initWithHex("32D4FF")
    public static let k333333: UIColor = UIColor.initWithHex("333333")
    public static let k3BA7FE: UIColor = UIColor.initWithHex("3BA7FE")
    public static let k3B92FF: UIColor = UIColor.initWithHex("3B92FF")
    public static let k3F3F3F: UIColor = UIColor.initWithHex("3F3F3F")
    public static let k5A5A61: UIColor = UIColor.initWithHex("5A5A61")
    public static let kFF5F4B: UIColor = UIColor.initWithHex("FF5F4B")
    public static let kFF754B: UIColor = UIColor.initWithHex("FF754B")
    public static let kFF9C23: UIColor = UIColor.initWithHex("FF9C23")
    public static let kFF9637: UIColor = UIColor.initWithHex("FF9637")
    public static let kFFFFFF: UIColor = UIColor.initWithHex("FFFFFF")
    public static let kF1F1F1: UIColor = UIColor.initWithHex("F1F1F1")
    public static let kF2F2F2: UIColor = UIColor.initWithHex("F2F2F2")
    public static let kF4F4F4: UIColor = UIColor.initWithHex("F4F4F4")
    public static let kF5F5F5: UIColor = UIColor.initWithHex("F5F5F5")
    public static let kBFBFBF: UIColor = UIColor.initWithHex("BFBFBF")
    public static let kE0E0E0: UIColor = UIColor.initWithHex("E0E0E0")
    public static let kE1E1E1: UIColor = UIColor.initWithHex("E1E1E1")
    public static let kE3E3E3: UIColor = UIColor.initWithHex("E3E3E3")
    public static let kE5E5E5: UIColor = UIColor.initWithHex("E5E5E5")
    public static let kE6E6E6: UIColor = UIColor.initWithHex("E6E6E6")
    public static let kE7E7E7: UIColor = UIColor.initWithHex("E7E7E7")
    public static let kE9E9E9: UIColor = UIColor.initWithHex("E9E9E9")
    public static let kEAEAEA: UIColor = UIColor.initWithHex("EAEAEA")
    public static let kEEEEEE: UIColor = UIColor.initWithHex("EEEEEE")
    public static let k000000: UIColor = UIColor.initWithHex("000000")
    public static let kC4C4C4: UIColor = UIColor.initWithHex("C4C4C4")
    public static let kC1C1C1: UIColor = UIColor.initWithHex("C1C1C1")
    public static let kADADAD: UIColor = UIColor.initWithHex("ADADAD")
    public static let kD3D3D3: UIColor = UIColor.initWithHex("D3D3D3")
    public static let kD6D6D6: UIColor = UIColor.initWithHex("D6D6D6")
    public static let kD8D8D8: UIColor = UIColor.initWithHex("D8D8D8")
    public static let kFF2828: UIColor = UIColor.initWithHex("FF2828")
    public static let kFF6363: UIColor = UIColor.initWithHex("FF6363")
    public static let kFF8123: UIColor = UIColor.initWithHex("FF8123")
    public static let kFFEFDC: UIColor = UIColor.initWithHex("FFEFDC")
    public static let k7E7E7E: UIColor = UIColor.initWithHex("7E7E7E")
    public static let kFF3B2F: UIColor = UIColor.initWithHex("FF3B2F")
    public static let k007AFF: UIColor = UIColor.initWithHex("007AFF")
    public static let k00B317: UIColor = UIColor.initWithHex("00B317")
    public static let k2D92FF: UIColor = UIColor.initWithHex("2D92FF")
    public static let k249EFF: UIColor = UIColor.initWithHex("249EFF")
    public static let k70B6FE: UIColor = UIColor.initWithHex("70B6FE")
    public static let k788193: UIColor = UIColor.initWithHex("788193")
    public static let k409BFF: UIColor = UIColor.initWithHex("409BFF")
    public static let k29CF42: UIColor = UIColor.initWithHex("29CF42")
    public static let kF8F8F8: UIColor = UIColor.initWithHex("F8F8F8")
    public static let kF5FFEA: UIColor = UIColor.initWithHex("F5FFEA")
    public static let k363636: UIColor = UIColor.initWithHex("363636")
    public static let kEC8200: UIColor = UIColor.initWithHex("EC8200")
    public static let kB8BCCB: UIColor = UIColor.initWithHex("B8BCCB")
    public static let k0DCC62: UIColor = UIColor.initWithHex("0DCC62")
    public static let k0D81FF: UIColor = UIColor.initWithHex("0D81FF")
    public static let kFF6969: UIColor = UIColor.initWithHex("FF6969")
    public static let k02040B: UIColor = UIColor.initWithHex("02040B")
    public static let kFFF4E7: UIColor = UIColor.initWithHex("FFF4E7")
    public static let kFF7E26: UIColor = UIColor.initWithHex("FF7E26")
    public static let kFAA500: UIColor = UIColor.initWithHex("FAA500")
    public static let k48FF3A: UIColor = UIColor.initWithHex("48FF3A")
    public static let kFF8B09: UIColor = UIColor.initWithHex("FF8B09")
    public static let kFF7070: UIColor = UIColor.initWithHex("FF7070")
    public static let kBEBEBE: UIColor = UIColor.initWithHex("BEBEBE")
    public static let k99A0B6: UIColor = UIColor.initWithHex("99A0B6")
    public static let k2F3856: UIColor = UIColor.initWithHex("2F3856")
    public static let k428BFE: UIColor = UIColor.initWithHex("428BFE")
    public static let kECECEC: UIColor = UIColor.initWithHex("ECECEC")
    public static let k42DA7F: UIColor = UIColor.initWithHex("42DA7F")
    public static let k2F3755: UIColor = UIColor.initWithHex("2F3755")
    public static let k999FB5: UIColor = UIColor.initWithHex("999FB5")
    public static let kDB2727: UIColor = UIColor.initWithHex("DB2727")
    public static let k599199: UIColor = UIColor.initWithHex("599199")
    public static let kFDCB85: UIColor = UIColor.initWithHex("FDCB85")
    public static let kFFCD53: UIColor = UIColor.initWithHex("FFCD53")
    public static let kDC2828: UIColor = UIColor.initWithHex("DC2828")
    public static let kDFDFDF: UIColor = UIColor.initWithHex("DFDFDF")
    public static let kE2E6EF: UIColor = UIColor.initWithHex("E2E6EF")
    public static let kE6E6F0: UIColor = UIColor.initWithHex("E6E6F0")
    public static let k8A8A8A: UIColor = UIColor.initWithHex("8A8A8A")
    public static let k414755: UIColor = UIColor.initWithHex("414755")
    public static let k5E637B: UIColor = UIColor.initWithHex("5E637B")
    public static let kFCFCFC: UIColor = UIColor.initWithHex("FCFCFC")
    
}

// MARK: - Hex to UIColor
@objc extension UIColor {
    public static func initWithHex(_ hex: String) -> UIColor {
        var hexStr: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexStr.hasPrefix("#") {
            hexStr = String(hexStr.dropFirst(1))
        }
        
        let scanner = Scanner(string: hexStr)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        var r = Int(color >> 16) & mask
        var g = Int(color >> 8) & mask
        var b = Int(color) & mask
        var a = 255
        
        if hexStr.count > 6 {
            r = Int(color >> 24) & mask
            g = Int(color >> 16) & mask
            b = Int(color >> 8) & mask
            a = Int(color) & mask
        }
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func randomColor() -> UIColor{
        #if DEBUG
            let r = CGFloat(arc4random()%255)/255
            let g = CGFloat(arc4random()%255)/255
            let b = CGFloat(arc4random()%255)/255
            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        #else
            return UIColor.clear;
        #endif
    }
}

// MARK: - UIColor to Hex
extension UIColor {
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    private var rgba: RGBA? {
        var (r,g,b,a): RGBA = (0,0,0,0)
        return self.getRed(&r, green: &g, blue: &b, alpha: &a) ? (r,g,b,a) : nil
    }
    
    public var hexString: String? {
        guard let rgba = rgba else { return nil }
        let rgbaStr = String(format: "%02x%02x%02x",
                             Int(rgba.red * 255.0),
                             Int(rgba.green * 255.0),
                             Int(rgba.blue * 255.0))
        return rgbaStr.uppercased()
    }
    
    public var hexaString: String? {
        guard let rgba = rgba else { return nil }
        let rgbaStr = String(format: "%02x%02x%02x%02x",
                             Int(rgba.red * 255.0),
                             Int(rgba.green * 255.0),
                             Int(rgba.blue * 255.0),
                             Int(rgba.alpha * 255.0))
        return rgbaStr.uppercased()
    }
}
