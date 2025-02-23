//
//  MineMessageHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef MineMessageHeader_h
#define MineMessageHeader_h

#pragma mark - UserDefault

/// 是否设置了（默认没设置）
#define MineMessage_hadSettle_BOOL @"MineMessage_hadSettle"

/// 是否需要活动消息提醒（默认不需要）（静默？）
#define MineMessage_needMsgWarn_BOOL @"MineMessage_needMsgWarn"

/// 是否需要签到提醒（默认不需要）（本地）
#define MineMessage_needSignWarn_BOOL @"MineMessage_needSignWarn"

/// 签到的本地通知 identifier
#define MineMessage_notificationRequest_identifier @"MineMessage_notificationRequest"

#pragma mark - API

/**获取所有信息
 * @Header Authorization : Bearer ${token}
 */
#define Discover_GET_allMsg_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"message-system/user/allMsg"]

/**更改已读状态
 * @Header Content-Type : application//json
 * @Header Authorization : Bearer ${token}
 * @Body @ {"ids" : [String]}
 */
#define Discover_PUT_hasRead_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"message-system/user/msgHasRead"]

/**是否有未读消息
 * @Header Authorization : Bearer ${token}
 */
#define Discover_GET_userHadRead_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"message-system/user/msgHasRead"]

/**删除消息
 * @Header Authorization : Bearer ${token}
 * @Body @ {"ids" : [String]}
 */
#define Discover_DELETE_sysMsg_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"message-system/user/msg"]

/**单个md文档转为h5
 * WKWebView
 */
#define Discover_HTML_md_API(msgID) [CyxbsMobileBaseURL_1 stringByAppendingFormat:@"message-system/user/html/%@", msgID]

#endif /* MineMessageHeader_h */
