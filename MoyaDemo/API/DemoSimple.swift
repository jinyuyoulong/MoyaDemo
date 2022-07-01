//
//  DemoSimple.swift
//  MoyaDemo
//
//  Created by yjkj on 2022/7/1.
//

import Foundation
import Moya

// MARK: - 使用moya
extension ConfigAPI {
    static func simpleFetchData() {
        let provider = MoyaProvider<ConfigAPI>()
        provider.request(.getGifts, completion: { result in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    //                    let data = try filteredResponse.data // data 二进制数据
                    let json = try filteredResponse.mapString() // json string
                    print(json)
                } catch {
                    print("response is failure, code is not in 200 ... 299")
                }
            case let .failure(error):
                print(error)
            }
        })
    }
}
// MARK: - 定义target结构
enum ConfigAPI {
    case zen
    case getGifts
    case cfg(String)
}
// MARK: - 实现moya target 协议
extension ConfigAPI: Moya.TargetType {
    var baseURL: URL{ return URL(string: "https://okstar-file.ok-star.cn")! }
    var path: String {
        switch self {
        case .zen:
            return "cfg/"
        case .getGifts:
            return "/cfg/cfg_gift.json"
        case .cfg(let name):
            return "/cfg/\(name)"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case .cfg(_):
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .zen:
            return .successCodes
        default:
            return .none
        }
    }
    
    var sampleData: Data {
        switch self {
        case .zen:
            return "sss".data(using: String.Encoding.utf8)!
        default:
            return "[{\"name\": \"dd\"}]".data(using: String.Encoding.utf8)!
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
