//
//  UNManager.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UserNotifications

// MARK: UNManagerPush protocol

protocol UNManagerPushable {
    
    var identifier: String { get }
    
    var title: String { get }
    
    var subtitle: String { get }
    
    var body: String { get }
    
    var beginTime: Date { get }
    
    var aheadOfTime: TimeInterval { get }
    
    var repeats: Bool { get }
}

// MARK: to use

extension UNManagerPushable {
    
    var aheadOfTime: TimeInterval { 15 * 60 }
    
    var repeats: Bool { false }
    
    var triggerTime: TimeInterval {
        Date().timeIntervalSince1970 - beginTime.timeIntervalSince1970 - aheadOfTime
    }
    
    var notificationContent: UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = .default
        return content
    }
    
    var notificationTrigger: UNTimeIntervalNotificationTrigger {
        UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: repeats)
    }
    
    var notificationRequest: UNNotificationRequest {
        UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: notificationTrigger)
    }
}

// MARK: UNManager

struct UNManager {
    
    static let share = UNManager()
    
    private init() { }
    
    private let unc = UNUserNotificationCenter.current()
    
    private func requestAuthorization(action: @escaping (_ granted: Bool)->()) {
        unc.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                action(granted)
            }
        }
    }
    
    private func requestAuthorizationGranted(action: @escaping ()->()) {
        requestAuthorization { granted in
            if granted {
                action()
            }
        }
    }
}

// MARK: user notification

extension UNManager {
    
    // - append
    
    func append(_ pushables: [UNManagerPushable]) {
        for pushable in pushables {
            append(pushable)
        }
    }
    
    func append(_ pushable: UNManagerPushable) {
        requestAuthorizationGranted {
            self.unc.add(pushable.notificationRequest)
        }
    }
    
    // - delete
    
    func delete(_ identifier: String) {
        delete([identifier])
    }
    
    func delete(_ identifiers: [String]) {
        requestAuthorizationGranted {
            self.unc.removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    // - renew
    
    func renew(_ pushable: UNManagerPushable) {
        renew([pushable])
    }
    
    func renew(_ pushables: [UNManagerPushable]) {
        requestAuthorizationGranted {
            self.delete(pushables.map { $0.identifier })
            self.append(pushables)
        }
    }
}
