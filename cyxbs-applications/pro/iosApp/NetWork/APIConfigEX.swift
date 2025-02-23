//
//  APIConfigEX.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

extension APIConfig {
    
    // 用于存储IP地址和主机的字典
    private static var ipToHost: [String: String] = [:]
    
    // 用于控制对ipToHost字典的访问的信号量
    private static let ipToHostSemaphore = DispatchSemaphore(value: 1)
    
    func api(_ api: String) -> String {
        
        // IP 直连
        let host = environment.host
        if let ip = AliyunConfig.ip(byHost: host) {
            DispatchQueue.global().async {
                // 在访问ipToHost字典之前等待信号量
                APIConfig.ipToHostSemaphore.wait()
                APIConfig.ipToHost[ip] = host
                // 在完成对ipToHost字典的访问后释放信号量
                APIConfig.ipToHostSemaphore.signal()
            }
            return "https://" + ip + api
        }
        
        // 原URL请求
        let url = environment.url + api
        return url
    }
}
