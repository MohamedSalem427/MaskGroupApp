//
//  UserDefaults+Extension.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Foundation

public protocol UserDefaultsProtocol {
    func get<T>(_ key: UserDefaults.Keys) -> T?
    func set(_ value: Any?, key: UserDefaults.Keys)
    func remove(_ key: UserDefaults.Keys)
}

extension UserDefaults: UserDefaultsProtocol {
    public enum Keys: String {
        case accessToken
        case isLoggedIn
    }
    public func get<T>(_ key: UserDefaults.Keys) -> T? {
        if self.value(forKey: key.rawValue) == nil {
            return nil
        } else {
            return self.value(forKey: key.rawValue) as? T
        }
    }

    public func set(_ value: Any?, key: Keys) {
        set(value, forKey: key.rawValue)
        synchronize()
    }

    public func remove(_ key: Keys) {
        if value(forKey: key.rawValue) != nil {
            removeObject(forKey: key.rawValue)
            synchronize()
        }
    }
}
