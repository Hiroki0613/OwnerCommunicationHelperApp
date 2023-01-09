//
//  OwnerSettingTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture

struct OwnerSettingTopState: Equatable {
    var pressureString = ""
}

enum OwnerSettingTopAction {
    case setPressure(String)
}

struct OwnerSettingTopEnvironment {
}

let ownerSettingTopReducer = Reducer<OwnerSettingTopState, OwnerSettingTopAction, OwnerSettingTopEnvironment> {
    state, action, _ in
    switch action {
    case .setPressure(let pressureString):
        state.pressureString = pressureString
    }
}
