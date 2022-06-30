//
//  BaseConfigModel.swift
//  YJSinger
//
//  Created by yjkj on 2022/6/30.
//

import UIKit

class BaseConfigModel<T>: BaseModel {
    public var code: Int = -1
    public var msg: String = ""
    public var data:GiftConfigModels?// T?
    public var time: TimeInterval?
}

typealias GiftConfigModels = [GiftConfigModel]
class GiftConfigModel: BaseModel {
    var id: Int?
    var name: String?
    
}
