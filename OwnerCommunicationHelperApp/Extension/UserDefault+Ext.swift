//
//  UserDefault+Ext.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/25.
//

import Foundation

//https://qiita.com/YOSUKE8080/items/2cc1491d379ac1e5f9df
struct UserDefaultsDataStoreProvider {
    private static var shared = UserDefaultsDataStoreImpl()
    static func provide() -> UserDefaultDataStore {
        return UserDefaultsDataStoreProvider.shared
    }
}

protocol UserDefaultDataStore {
    var hasRegisterOwnerSetting: Bool? { get set }
}

private struct UserDefaultsDataStoreImpl: UserDefaultDataStore {
    var hasRegisterOwnerSetting: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "hasRegisterOwnerSetting") as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasRegisterOwnerSetting")
            UserDefaults.standard.synchronize()
        }
    }
}
