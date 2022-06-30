//
//  BaseModel.swift
//  YJSinger
//
//  Created by yjkj on 2022/3/31.
//

import Foundation
import HandyJSON
import UIKit

class BaseModel:NSObject, HandyJSON {
    required override init() {}
    
    /**
     *  Json转对象
     */
    static func jsonToModel(_ jsonStr:String) -> Self? {
        if jsonStr == "" || jsonStr.count == 0 {
            #if DEBUG
                print("jsonoModel:字符串为空")
            #endif
            return nil
        }
        return Self.deserialize(from: jsonStr)
        
    }
    
    
    
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any]) -> Self? {
        if dictionStr.count == 0 {
            #if DEBUG
                print("dictionaryToModel:字符串为空")
            #endif
            return Self()
        }
        
        return Self.deserialize(from: dictionStr)
    }
    /**
     *  对象转字典
     */
    static func modelToDictionary(_ model: BaseModel?) -> [String:Any] {
        if model == nil {
            #if DEBUG
                print("modelToJson:model为空")
            #endif
            return [:]
        }
        return (model?.toJSON())!
    }
    
    func modelToString() -> String? {
        return self.toJSONString()
    }
}
