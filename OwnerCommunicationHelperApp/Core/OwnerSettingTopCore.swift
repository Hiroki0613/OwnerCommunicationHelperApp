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
//    var startWorkTime = Date()
//    var endWorkTime = Date()
//    var numberOfPeopleCanRegister: Int = 0
    var pressureString = ""
    var hasShowedQrCodeScanView = false
    var hasShowedRegisterWorkerView = false
    var hasShowedDatePickerView = false
}

enum OwnerSettingTopAction {
    case ownerQrScanAction(OwnerQrScanAction)
    case setPressure(String)
//    case setOwnerSettingInformation
    case gotoQrCodeScanView(Bool)
    case gotoRegisterWorkerView(Bool)
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
//        @StateObject var ownerSettingManager = OwnerSettingManager()
        switch action {

        case .ownerQrScanAction:
            return .none

        case .setPressure(let pressureString):
            state.pressureString = pressureString
            return .none

//        case .setOwnerSettingInformation:
//            ownerSettingManager.getOwnerData()
//                state.startWorkTime = Date(timeIntervalSince1970: ownerSettingManager.owner.startWorkTime)
//                state.endWorkTime = Date(timeIntervalSince1970: ownerSettingManager.owner.endWorkTime)
//                state.numberOfPeopleCanRegister = ownerSettingManager.owner.numberOfPeopleCanRegister
//            return .none

        case .gotoQrCodeScanView(let isActive):
            state.hasShowedQrCodeScanView = isActive
            return .none

        case .gotoRegisterWorkerView(let isActive):
            state.hasShowedRegisterWorkerView = isActive
            return .none

        case .gotoDatePickerView(let isActive):
            state.hasShowedDatePickerView = isActive
            return .none
        }
    }
)
