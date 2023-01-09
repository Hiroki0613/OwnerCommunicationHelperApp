//
//  OwnerTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture

struct OwnerTopState: Equatable {
    var settingTopState: OwnerSettingTopState
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
