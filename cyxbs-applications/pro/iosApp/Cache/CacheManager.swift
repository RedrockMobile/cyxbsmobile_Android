//
//  CacheManager.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

struct CacheManager {
    
    static let shared = CacheManager()
    
    private init() {
        print("[document] \(RootPath.document.rawValue)")
        print("[widget] \(RootPath.widget.rawValue)")
        guard Constants.cleanInNextVersion,
            let shortVersionString = Constants.value(for: .shortVersionString)
            else { return }
        if let bundleShortVersion = UserDefaultsManager.shared.bundleShortVersion, bundleShortVersion == shortVersionString {
            return
        }
        delete(path: FilePath(rootPath: .document, file: ""))
        
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            print("Unable to retrieve bundle identifier.")
            return
        }
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaultsManager.shared.bundleShortVersion = shortVersionString
    }
}

// MARK: CRUD

extension CacheManager {
    
    func fileExists(file: FilePath) -> Bool {
        FileManager.default.fileExists(atPath: file.rawValue)
    }
    
    @discardableResult
    func create(file: FilePath) -> FilePath {
        let rawValue = file.rawValue
        if FileManager.default.fileExists(atPath: rawValue) { return file }
        let ary = rawValue.components(separatedBy: "/")
        let path = ary[0..<ary.count - 1].joined(separator: "/")
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
        } catch {
            print("Failed to create dicrectory at path: \(error)")
        }
        return file
    }
    
    func delete(path: FilePath) {
        let path = path.rawValue
        try? FileManager.default.contentsOfDirectory(atPath: path).forEach { perPath in
            try? FileManager.default.removeItem(atPath: perPath)
        }
    }
}

// MARK: cache/get cache

extension CacheManager {
    
    func cache(codable: Codable, in path: FilePath) {
        create(file: path)
        let fullPath = path.rawValue
        do {
            let jsonData = try JSONEncoder().encode(codable)
            do {
                try jsonData.write(to: URL(fileURLWithPath: fullPath))
            } catch {
                print("Failed to write Data to File: \(error)")
            }
        } catch {
            print("Failed to encode Codable to Data: \(error)")
        }
    }
    
    func getCodable<T: Decodable>(_ decode: T.Type, in path: FilePath) -> T? {
        if !fileExists(file: path) { return nil }
        let fullPath = path.rawValue
        do {
            let data = try NSData(contentsOfFile: fullPath) as Data
            do {
                return try JSONDecoder().decode(decode, from: data)
            } catch {
                print("Failed to convert Data to JSON: \(error)")
            }
        } catch {
            print("Failed to get Data from URL: \(error)")
        }
        return nil
    }
}

// MARK: - RootPath/FilePath

extension CacheManager {
    
    struct RootPath {
        
        var rawValue: String
        
        init(_ rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    struct FilePath {
        
        let rawValue: String
        
        init(rootPath: RootPath, file: String) {
            if file.count == 0 {
                rawValue = rootPath.rawValue
                return
            }
            var file = file
            if file.prefix(1) != "/" {
                file = "/" + file
            }
            rawValue = rootPath.rawValue + file
        }
    }
}

/* not accessible, use Codable
 
extension CacheManager {
    
    func cache(json: JSON, in path: FilePath) {
        create(file: path)
        let fullPath = path.rawValue
        do {
            let data = try json.rawData(options: .sortedKeys)
            do {
                try data.write(to: URL(fileURLWithPath: fullPath))
            } catch {
                print("Failed to write Data to File: \(error)")
            }
        } catch {
            print("Failed to convert JSON to Data: \(error)")
        }
    }
    
    func getJOSN(in path: FilePath) -> JSON? {
        if !fileExists(file: path) { return nil }
        let fullPath = path.rawValue
        do {
            let data = try NSData(contentsOfFile: fullPath) as Data
            do {
                return try JSON(data: data)
            } catch {
                print("Failed to convert Data to JSON: \(error)")
            }
        } catch {
            print("Failed to get Data from URL: \(error)")
        }
        return nil
    }
}
 */

// MARK: RootPaths

extension CacheManager.RootPath {
    
    func append(fileName: String) -> String {
        var file = fileName
        if file.prefix(1) != "/" {
            file = "/" + file
        }
        return rawValue + file
    }
    
    static let document: Self = .init(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "")
    
    static let widget: Self = {
        if let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.widgetGroupID)?.path {
            return .init(path)
        }
        return document
    }()
    
    static let bundle: Self = .init(Bundle.main.bundlePath)
}

// MARK: FilePaths

extension CacheManager.FilePath {
    
    static func searchStudent(sno: String) -> Self {
        .init(rootPath: .widget, file: "search/\(sno)")
    }
    
    static func schedule(sno: String) -> Self {
        .init(rootPath: .widget, file: "schedule/\(sno)")
    }
    
    static var toolsFromBundle: Self {
        .init(rootPath: .bundle, file: "FinderTools")
    }
    
    static var threeTools: Self {
        .init(rootPath: .document, file: "tools/three")
    }
    
    static var featuresFromBundle: Self {
        .init(rootPath: .bundle, file: "QuickFeatures")
    }
    
    static var features: Self {
        .init(rootPath: .document, file: "features/cus_sort")
    }
    
    static var customSchedule: Self {
        .init(rootPath: .widget, file: "schedule/custom")
    }
    
    static var token: Self {
        .init(rootPath: .widget, file: "user/token")
    }
    
    static var currentPerson: Self {
        .init(rootPath: .widget, file: "user/person")
    }
}
