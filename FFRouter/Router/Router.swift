//
//  Router.swift
//  FFRouter
//
//  Created by jinfeng on 2021/3/4.
//

import Foundation

class Router: NSObject {
    @objc static func open(url: String?) {
        open(url: url, params: nil, object: nil)
    }
    
    @objc static func open(url: String?, params: [String: Any]?, object: Any?) {
        guard let url = url else {
            return
        }
        print(url)
        
        let parse = UrlParser(url: url, params: params, object: object)
    }
}

func Register_router(url: String?) {
    
}
