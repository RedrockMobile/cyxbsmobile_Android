//
//  FixedGroupModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/8/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SwiftyJSON

class FixedGroupModel {
    
    /// 分组信息数组
    var groupAry: [GroupItem] = []
    
    /// 网络请求得到分组
    static func getGroup(success: ((_ groupModel: FixedGroupModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        HttpTool.share().request(Discover_GET_allGroup_API,
                                 type: .get,
                                 serializer: .JSON,
                                 bodyParameters: nil,
                                 progress: nil,
                                 success: { task, object in
            let groupModel = FixedGroupModel()
            let json = JSON(object!)
            
            if let groups = json["data"].arrayObject as? [[String: Any]]  {
                for dic in groups {
                    let group = GroupItem(dictionary: dic)
                    groupModel.groupAry.append(group)
                }
            }
            
            success?(groupModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
    
    /// 网络请求删除分组
    static func deleteGroupWithGroupID(_ groupID: Int) {
        let parameters = ["group_ids": groupID]
        HttpTool.share().request(Discover_DELETE_deleteGroup_API,
                                 type: .delete,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
        },
                                 failure: { task, error in
            print(error)
        })
    }
    
    /// 网络请求置顶分组
    static func stickyGroup(name: String, groupID: Int) {
        let parameters = ["name": name, "group_id": groupID, "is_top": true] as [String: Any]
        HttpTool.share().request(Discover_PUT_updateGroup_API,
                                 type: .put,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
        },
                                 failure: { task, error in
            print(error)
        })
    }
}
