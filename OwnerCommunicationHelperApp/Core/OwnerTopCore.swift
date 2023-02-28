//
//  OwnerTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import Foundation

struct OwnerTopState: Equatable {
    var settingTopState: OwnerSettingTopState
    // TODO: ここはdidSetでUserDefaultsがセットされるようにする。
//    var hasRegisterOwnerSetting {
//        UserDefaults.register(なんとか)
//    }
    var hasRegisterOwnerSetting = true
}

enum OwnerTopAction {
    case settingTopAction(OwnerSettingTopAction)
}

struct OwnerTopEnvironment {
    var settingTopEnvironment: OwnerSettingTopEnvironment {
        .init()
    }
}

let topReducer = Reducer<OwnerTopState, OwnerTopAction, OwnerTopEnvironment>.combine(
    ownerSettingTopReducer.pullback(
        state: \.settingTopState,
        action: /OwnerTopAction.settingTopAction,
        environment: \.settingTopEnvironment
    ),
    Reducer<OwnerTopState, OwnerTopAction, OwnerTopEnvironment> { state, action, _ in
        switch action {
        case .settingTopAction:
            return .none
        }
    }
)
