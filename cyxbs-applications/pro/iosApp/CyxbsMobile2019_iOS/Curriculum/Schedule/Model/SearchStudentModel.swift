//
//  SearchStudentModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct SearchStudentModel: Codable, Equatable {
    
    var stunum: String = ""
    
    var name: String = ""
    
    var gender: String = ""
    
    var classnum: String = ""
    
    var depart: String = ""
    
    var grade: Int = 0
    
    var major: String = ""
}

extension SearchStudentModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(stunum)
    }
}

extension SearchStudentModel {
    
    init(json: JSON) {
        stunum = json["stunum"].stringValue
        name = json["name"].stringValue
        gender = json["gender"].stringValue
        classnum = json["classnum"].stringValue
        depart = json["depart"].stringValue
        grade = json["grade"].intValue
        major = json["major"].stringValue
    }
}

extension SearchStudentModel {
    
//    static func request(info: String, handle: @escaping (NetResponse<[SearchStudentModel]>) -> Void) {
//        HttpManager.shared.magipoke_text_search_people(stu: info).ry_JSON { response in
//            switch response {
//            case .success(let model):
//                if let ary = model["data"].array?.map(SearchStudentModel.init) {
//                    handle(.success(ary))
//                } else {
//                    let error = AFError.responseSerializationFailed(reason: .customSerializationFailed(error: NSError(domain: "com.mredrock.com", code: 80001, userInfo: ["info": "success with no data"])))
//                    handle(.failure(NetError(request: nil, response: nil, error: error)))
//                }
//            case .failure(let netError):
//                handle(.failure(netError))
//            }
//        }
//    }
}
