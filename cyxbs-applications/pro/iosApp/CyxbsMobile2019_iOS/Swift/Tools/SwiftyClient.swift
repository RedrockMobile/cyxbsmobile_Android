//
//  SwiftyClient.swift
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/10/5.
//  Copyright © 2020 Redrock. All rights reserved.
//


import Foundation
import Alamofire

typealias HttpClientResponse = (Any?) -> Void

class SwiftyClient: NSObject {
    
    static let shared = SwiftyClient()
    
    private override init() {
        
    }
    
    
    func request(_ url: URL,
                 method: HTTPMethod,
                 headers: [String: String]?,
                 parameters: Parameters?,
                 completion: @escaping HttpClientResponse) {
        
        var requestHeaders: [String: String]
        
        if headers != nil {
            requestHeaders = headers!
        } else {
            requestHeaders = [String: String]()
        }
        
        if UserItemTool.defaultItem().token != "" {
            requestHeaders["Authorization"] = "Bearer \(UserItemTool.defaultItem().token)"
        }
        
            
        AF.request(url, method: method, parameters: parameters ?? nil, encoding: JSONEncoding.default, headers: HTTPHeaders(requestHeaders)).responseJSON { (response) in
            
            switch response.result {
    
                case let .success(data):
                    completion(data)
                    break
    
                case let .failure(error):
                    completion(nil)
                    print(error)
                    break
                    
            }
            
        }
        
    }

}
