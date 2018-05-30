//
//  NetworkService.swift
//  ToDoMVC
//
//  Created by wangyan on 2018/5/29.
//  Copyright © 2018年 wangyan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import PromiseKit


struct NetworkResponseBean: Mappable {
    
    public var data: String?
    
    init?(map: Map) {
        
        
    }
    
    mutating func mapping(map: Map) {
        
        data <- map["results.0.data"]
    }
}

class NetworkServie {
    
    static let shared = NetworkServie()
    
    public typealias Success = (_ resultBean: NetworkResponseBean) -> Void
    public typealias Failure = (_ result: String) -> Void
    
    func request(url: String) -> Promise<NetworkResponseBean?>{
        
        let headers: HTTPHeaders = [
            "X-LC-Id": "CPc8KfPbLa28Emx3VlM6rREj-gzGzoHsz",
            "X-LC-Key": "gILYLu9KwykWDGn0uygI3R09"
        ]
        
        let encodeUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        return firstly {
            
            Alamofire.request(encodeUrl, headers: headers).responseString()
        }.then(on: DispatchQueue.global()) { (response) -> Promise<NetworkResponseBean?> in
            
            let value = response.string
            let bean = NetworkResponseBean(JSONString: value)
            return Promise.value(bean)
        }
    }
}

