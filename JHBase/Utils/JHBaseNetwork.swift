//  Created by lifei on 2021/12/7.
//  网络请求封装层

import Foundation
import Alamofire

public let JN = JHBaseNetwork.shared

public class JHBaseNetwork {
    public static let shared = JHBaseNetwork()
    private var taskList: [JHBaseNetworkRequest] = []
    
    // MARK: - API
    public func post(_ url: String,
                     parameters: [String: Any]? = nil,
                     headers: [String: String]? = nil) -> JHBaseNetworkRequest {
        request(url: url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    public func get(_ url: String,
                    parameters: [String: Any]? = nil,
                    headers: [String: String]? = nil) -> JHBaseNetworkRequest {
        request(url: url, method: .get, parameters: parameters, encoding: URLEncoding.default)
    }
    
    func upload(_ data: Data, url: String,
                headers: [String: String]? = nil) -> JHBaseNetworkRequest {
        uploadFile(data, url: url, headers: headers)
    }
    
    public func cancelAll() {
        taskList.forEach { $0.cancel() }
    }
    
    // MARK: - Lazy Load
    private lazy var clientInfoDict: [String: Any] = {
        let fileURL = Bundle.main.url(forResource: "JHVersion", withExtension: "plist")
        guard let tmpFileURL = fileURL else { return [:] }
        let fileDict = try? NSDictionary(contentsOf: tmpFileURL, error: ())
        guard let fileDict = fileDict as? [String: Any] else { return [:] }
        guard let clientDict = fileDict["clientInfo"] as? [String: Any] else { return [:] }
        return clientDict
    }()
}

// MARK: - Private
extension JHBaseNetwork {
    private func request(url: String,
                         method: HTTPMethod = .get,
                         parameters: [String: Any]? = nil,
                         headers: [String: String]? = nil,
                         encoding: ParameterEncoding = URLEncoding.default) -> JHBaseNetworkRequest {
        let task = JHBaseNetworkRequest()
        
        var httpHeaders: HTTPHeaders? = nil
        if let headersDict = headers {
            httpHeaders = HTTPHeaders(headersDict)
        }
        // 增加 clientInfo 公共参数
        var paramDict: [String: Any] = parameters ?? [:]
        if method != .get {
            let clientDict: [String: Any] = readClientInfoDict()
            paramDict["clientInfo"] = clientDict
        }
        weak var weakTask = task
        task.request = AF.request(url,
                                  method: method,
                                  parameters: paramDict,
                                  encoding: encoding,
                                  headers: httpHeaders).validate().response
        { [weak self] resp in
            guard let strongTask = weakTask, let strongSelf = self else { return }
            strongTask.handleResponse(resp: resp)
            strongSelf.taskList.removeFirst(where: { $0 == strongTask })
        }
        taskList.append(task)
        return task
    }
    
    private func uploadFile(_ data: Data,
                            url: String,
                            headers: [String: String]? = nil) -> JHBaseNetworkRequest {
        let task = JHBaseNetworkRequest()
        
        var httpHeaders: HTTPHeaders? = nil
        if let headersDict = headers {
            httpHeaders = HTTPHeaders(headersDict)
        }
        
        weak var weakTask = task
        task.request = AF.upload(data, to: url, headers: httpHeaders).uploadProgress { progress in
            guard let strongTask = weakTask else { return }
            strongTask.handleProgress(progress: progress)
        }.validate().response { [weak self] resp in
            guard let strongTask = weakTask, let strongSelf = self else { return }
            strongTask.handleResponse(resp: resp)
            strongSelf.taskList.removeFirst(where: { $0 == strongTask })
        }
        taskList.append(task)
        return task
    }
    
    // 读取 JHVersion.plist 中的配置
    private func readClientInfoDict() -> [String: Any] {
        let version = clientInfoDict["version"] as? String ?? "v1.8.0"
        let versionNum = clientInfoDict["versionNum"] as? Int ?? 180
        let device = clientInfoDict["device"] as? String ?? "ios"
        let appID = Bundle.main.infoDictionary?["APPID"] as? String ?? JHBaseInfo.appID
        let userID = JHBaseInfo.userID
        let clientDict: [String: Any] = ["version": version, "versionNum": versionNum,
                                         "device": device, "appid": appID, "userId": userID]
        return clientDict
    }
}

public class JHBaseNetworkRequest: Equatable {
    var request: Alamofire.Request?
    
    public typealias JHBaseSuccessClosure = (_ data: Data?, _ response: HTTPURLResponse?) -> Void
    public typealias JHBaseFailedClosure = (_ error: JHBaseNetworkError?, _ response: HTTPURLResponse?) -> Void
    public typealias JHBaseProgressClosure = (Progress) -> Void
    
    private var successHandler: JHBaseSuccessClosure?
    private var failedHandler: JHBaseFailedClosure?
    private var progressHandler: JHBaseProgressClosure?
    
    // MARK: - API
    @discardableResult
    public func success(_ closure: @escaping JHBaseSuccessClosure) -> Self {
        successHandler = closure
        return self
    }
    
    @discardableResult
    public func failed(_ closure: @escaping JHBaseFailedClosure) -> Self {
        failedHandler = closure
        return self
    }
    
    @discardableResult
    public func progress(closure: @escaping JHBaseProgressClosure) -> Self {
        progressHandler = closure
        return self
    }
    
    public func cancel() {
        request?.cancel()
    }
    
    // MARK: - Equatable
    public static func == (lhs: JHBaseNetworkRequest, rhs: JHBaseNetworkRequest) -> Bool {
        return lhs.request?.id == rhs.request?.id
    }
    
    // MARK: - Private
    fileprivate func handleResponse(resp: AFDataResponse<Data?>) {
        switch resp.result {
        case .success(let data):
            if let successHandler = successHandler {
                successHandler(data, resp.response)
            }
        case .failure(let error):
            if let failedHandler = failedHandler {
                let errorDesc = error.localizedDescription
                let netError = JHBaseNetworkError(code: error.responseCode, desc: errorDesc)
                failedHandler(netError, resp.response)
            }
        }
    }
    
    fileprivate func handleProgress(progress: Foundation.Progress) {
        if let closure = progressHandler {
            closure(progress)
        }
    }
}

public class JHBaseNetworkError {
    public var errorCode: Int?
    public var errorDesc: String?
    
    init(code: Int?, desc: String?) {
        errorCode = code
        errorDesc = desc
    }
}
