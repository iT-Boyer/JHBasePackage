//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit

// 事件闭包
public typealias JHTask = () -> Void

// MARK:- 延迟事件
public struct JHAsyncs {
    // MARK: 1.1、异步做一些任务
    /// 异步做一些任务
    /// - Parameter JKTask: 任务
    @discardableResult
    public static func async(_ JHTask: @escaping JHTask) -> DispatchWorkItem {
        return _asyncDelay(0, JHTask)
    }
    
    // MARK: 1.2、异步做任务后回到主线程做任务
    /// 异步做任务后回到主线程做任务
    /// - Parameters:
    ///   - JKTask: 异步任务
    ///   - mainJKTask: 主线程任务
    @discardableResult
    public static func async(_ JHTask: @escaping JHTask,
                             _ mainJHTask: @escaping JHTask) -> DispatchWorkItem{
        return _asyncDelay(0, JHTask, mainJHTask)
    }
    
    // MARK: 1.3、异步延迟(子线程执行任务)
    /// 异步延迟(子线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter JKTask: 延迟的block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ JHTask: @escaping JHTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, JHTask)
    }
    
    // MARK: 1.4、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// 异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter JKTask: 延迟的block
    /// - Parameter mainJKTask: 延迟的主线程block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ JHTask: @escaping JHTask,
                                  _ mainJHTask: @escaping JHTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, JHTask, mainJHTask)
    }
}

// MARK:- 私有的方法
extension JHAsyncs {
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - JKTask: 任务
    ///   - mainJKTask: 任务
    /// - Returns: DispatchWorkItem
    fileprivate static func _asyncDelay(_ seconds: Double,
                                        _ JHTask: @escaping JHTask,
                                        _ mainJHTask: JHTask? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: JHTask)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainJHTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}

