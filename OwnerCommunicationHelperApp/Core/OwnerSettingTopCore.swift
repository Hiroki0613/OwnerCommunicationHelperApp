//
//  OwnerSettingTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture

struct OwnerSettingTopState: Equatable {
    var pressureString = ""
    var hasShowedQrCode = false
    var hasShowedRegisterWorkerView = false
}

enum OwnerSettingTopAction {
    case setPressure(String)
    case gotoQrCodeCreateView(Bool)
    case gotoRegisterWorkerView(Bool)
}

struct OwnerSettingTopEnvironment {
}

let ownerSettingTopReducer = Reducer<OwnerSettingTopState, OwnerSettingTopAction, OwnerSettingTopEnvironment> {
    state, action, _ in
    switch action {
    case .setPressure(let pressureString):
        state.pressureString = pressureString
        return .none

    case .gotoQrCodeCreateView(let isActive):
        state.hasShowedQrCode = isActive
        return .none

    case .gotoRegisterWorkerView(let isActive):
        state.hasShowedRegisterWorkerView = isActive
        return .none
    }
}
