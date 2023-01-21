//
//  OwnerSettingTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture

struct OwnerSettingTopState: Equatable {
    var pressureString = ""
    var hasShowedQrCodeScanView = false
    var hasShowedRegisterWorkerView = false
}

enum OwnerSettingTopAction {
    case setPressure(String)
    case gotoQrCodeScanView(Bool)
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

    case .gotoQrCodeScanView(let isActive):
        state.hasShowedQrCodeScanView = isActive
        return .none

    case .gotoRegisterWorkerView(let isActive):
        state.hasShowedRegisterWorkerView = isActive
        return .none
    }
}
