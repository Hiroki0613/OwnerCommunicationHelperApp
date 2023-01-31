//
//  OwnerQrScanCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import ComposableArchitecture
import Foundation

struct OwnerQrScanState: Equatable {
    var hasReadWorkerId = false
    var hasReadTerminalId = false
}

enum OwnerQrScanAction {
    case scanQrCodeResult(result: String)
    case readWorkerId(id: String)
    case readTerminalId(id: String)
    case finishReadQrCode
}

struct OwnerQrScanEnvironment {
}

let ownerQrScanReducer = Reducer<OwnerQrScanState, OwnerQrScanAction, OwnerQrScanEnvironment> { state, action, _ in

    switch action {
    case .scanQrCodeResult(let result):
        if result.contains("worker_") {
            return .concatenate(
                Effect(value: .readWorkerId(id: result))
            )
        }
        if result.contains("terminal_") {
            return .concatenate(
                Effect(value: .readTerminalId(id: result))
            )
        }
        return .none

    case .readWorkerId(let id):
        state.hasReadWorkerId = true
        return Effect(value: .finishReadQrCode)

    case .readTerminalId(let id):
        state.hasReadTerminalId = true
        return Effect(value: .finishReadQrCode)

    case .finishReadQrCode:
        if state.hasReadWorkerId && state.hasReadTerminalId {
            state.hasReadWorkerId = false
            state.hasReadTerminalId = false
            // TODO: ここに朝礼時のQRコードを読み取った後の処理を書く。
            return .none
        }
        return .none
    }
}
