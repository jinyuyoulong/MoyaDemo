//
//  ConfigAPI.swift
//  YJSinger
//
//  Created by yjkj on 2022/6/29.
//

import Foundation
import Moya
import HandyJSON

class ConfigAPIs {
    static func getGifts() {
        
        
        let target = CoutomTarget(baseurl: "https://okstar-file.ok-star.cn", path: "/cfg/cfg_gift.json", params: [:])
        let provider = MoyaProvider<CoutomTarget>()
        target.requestHandyJson(success: { (result: BaseConfigModel<GiftConfigModels>) in
            print("get gifts: \(result.data?.count ?? 0)")
        }, failure: {error in
            
        }, provider: provider)
    }
    
}

extension CoutomTarget {
    func request<T: Decodable>(success: @escaping ((T) -> Void),
                               failure: @escaping ((Error) -> Void) ,
                               provider: MoyaProvider<CoutomTarget>? = nil,
                               fullResponse: ((Moya.Response) -> Void)? = nil) {
        // model 返回模型数据
        provider?.request(self, completion: { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    //                    let data = try filteredResponse.data
                    let json = try filteredResponse.mapString()
                    print(json)
                    
                }catch {
                    print("response is failure, code is not in 200 ... 299")
                }
                
            case let .failure(error):
                print("\(error.errorDescription ?? "")")
                failure(error)
            }}
        )
        
    }
    
    func requestHandyJson<T: HandyJSON>(success: @escaping ((T) -> Void),
                                        failure: @escaping ((Error) -> Void) ,
                                        provider: MoyaProvider<CoutomTarget>,
                                        fullResponse: ((Moya.Response) -> Void)? = nil) {
        provider.request(self, completion: { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    //                    let data = try filteredResponse.data
                    let json = try filteredResponse.mapString()
                    if let obj = T.deserialize(from: json){
                        success(obj)
                    }
                }catch {
                    print("response is failure, code is not in 200 ... 299")
                }
                
            case let .failure(error):
                print("\(error.errorDescription ?? "")")
                failure(error)
            }
        })
    }
}

class CoutomTarget: Moya.TargetType {
    var baseURL: URL
    
    var path: String
    
    var method: Moya.Method
    
    var sampleData: Data {
        return "dd".data(using: String.Encoding.utf8)!
    }
    
    var task: Task
    
    init(baseurl: String, path: String,method: Moya.Method = .get, params: [String: Any]) {
        self.baseURL = URL(string: baseurl)!
        self.path = path
        self.method = method
        self.task = Task.requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    var headers: [String : String]? {
        return nil
    }
    
}
