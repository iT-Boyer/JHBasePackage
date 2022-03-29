//
//  UIImage+Extension.swift
//  JHBase
//
//  Created by jh on 2022/3/29.
//

import UIKit

extension UIImage: JHUIKitCompatible {}

// MARK:- 一、UIImage 压缩相关
public extension JHUIKit where Base: UIImage {
    //由角度转换弧度
    private static func degreesToRadian(_ x: Float) -> Float {
        return .pi * x / 180.0
    }
    
    //1.0 传入图片大小（内存），返回压缩系数
    static func getCompressionFactor(imageLength: Float, expectLength: Float) -> Float {
        /*
         根据数据实例记录，得到压缩系数和压缩后内存大小和图片原来大小之间的关系：
         压缩系数:压缩后的内存大小和原图片大小比;
         压缩系数0.9:压缩后图片大小和原图大小比0.4;
         0.8:0.32;
         0.7:0.29;
         0.6:0.22;
         0.5:0.15;
         0.4:0.10;
         0.3:0.08;
         0.2:0.06;
         0.1:0.05;
         0.01:0.05;
         2:1;
         */
        if imageLength == 0 {
            return 1
        } else if expectLength == 0 {
            return 0.001
        }
        //压缩系数
        let coefficientArray = ["0.9","0.8","0.7","0.6","0.5","0.4","0.3","0.2","0.1","0.01","0.01"]
        //比例系数
        var proportionArray = ["0.4","0.32","0.29","0.22","0.15","0.10","0.08","0.06","0.05","0.05"]
        let proportionResultValue = expectLength/imageLength
        let proportionResultStr = String(format: "%.2f",proportionResultValue)
        proportionArray.append(proportionResultStr)
        proportionArray = proportionArray.sorted { obj1, obj2 in
            return Float(obj1) ?? 0.0 < Float(obj2) ?? 0.0
        }
        
        let index = proportionArray.firstIndex(where: { $0 == proportionResultStr }) ?? 0
        
        let coefficientStr = coefficientArray[index]
        //NSLog(@"过程：%.2f,%ld,%.2f",proportionResultValue,(long)index,coefficientStr.floatValue);
        return Float(coefficientStr) ?? 0.01
    }
}
