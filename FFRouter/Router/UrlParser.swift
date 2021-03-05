//
//  UrlParser.swift
//  FFRouter
//
//  Created by jinfeng on 2021/3/4.
//

import Foundation

struct UrlParser {
    var url: String?
    var params: [String: Any]?
    var object: Any?
    
    enum parseResult {
        /// 解析失败
        case fail
        /// 解析成功
        case success
    }
    var result: parseResult = .fail
    
    enum failReason {
        /// 没有理由
        case none
        /// url是空
        case empty
        /// 无效url
        case invalid
    }
    var reason: failReason = .none
    
    var scheme: String?
    var host: String?
    var path: String?
    var allParams = [String: Any]()
    
    init(url: String?, params: [String: Any]?, object: Any?) {
        self.url = url
        self.params = params
        self.object = object
        
        guard let url = url else {
            reason = .empty
            return
        }
        
        if let URL = URLComponents(string: url) {
            scheme = URL.scheme
            host = URL.host
            path = URL.path
            
            if let queryItems = URL.queryItems {
                for item in queryItems {
                    allParams[item.name] = item.value
                }
            }
            
            if let params = params {
                allParams.merge(params) { (_, new)  in new }
            }
            
            print(URL.scheme)
            print(URL.host)
            print(URL.path)
            print(URL.queryItems)
            print(allParams)
            
        } else {
            reason = .invalid
        }
        
    }
}
