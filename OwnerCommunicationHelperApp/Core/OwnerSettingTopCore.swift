//
//  OwnerSettingTopCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import Foundation

struct OwnerSettingTopState: Equatable {
    var ownerQrScanState = OwnerQrScanState()
    var pressureString = ""
    var hasShowedQrCodeScanView = false
    var hasShowedQrCodeReadView = false
    var hasShowedRegisterWorkerView = false
    var hasShowedDatePickerView = false
    var hasShowedSelectRegisterView = false
}

enum OwnerSettingTopAction {
    case ownerQrScanAction(OwnerQrScanAction)
    case setPressure(String)
    case gotoQrCodeReadView(Bool)
    case gotoQrCodeScanView(Bool)
    case gotoRegisterWorkerView(Bool)
    case gotoSelectRegisterView(Bool)
    case gotoDatePickerView(Bool)
}

struct OwnerSettingTopEnvironment {
    var ownerQrScanEnvironment: OwnerQrScanEnvironment {
        .init()
    }
}

let ownerSettingTopReducer = Reducer<OwnerSettingTopState, OwnerSettingTopAction, OwnerSettingTopEnvironment>.combine(
    ownerQrScanReducer.pullback(
        state: \.ownerQrScanState,
        action: /OwnerSettingTopAction.ownerQrScanAction,
        environment: \.ownerQrScanEnvironment
    ),
    Reducer<OwnerSettingTopState, OwnerSettingTopAction, OwnerSettingTopEnvironment> {
        state, action, _ in
        switch action {

        case .ownerQrScanAction:
            return .none

        case .setPressure(let pressureString):
            state.pressureString = pressureString
            return .none

        case .gotoQrCodeReadView(let isActive):
            state.hasShowedQrCodeReadView = isActive
            return .none

        case .gotoQrCodeScanView(let isActive):
            state.hasShowedQrCodeScanView = isActive
            return .none

        case .gotoRegisterWorkerView(let isActive):
            state.hasShowedRegisterWorkerView = isActive
            return .none

        case .gotoSelectRegisterView(let isActive):
            state.hasShowedSelectRegisterView = isActive
            return .none

        case .gotoDatePickerView(let isActive):
            state.hasShowedDatePickerView = isActive
            return .none
        }
    }
)
