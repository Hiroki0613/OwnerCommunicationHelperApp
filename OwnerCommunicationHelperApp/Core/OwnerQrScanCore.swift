//
//  OwnerQrScanCore.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct OwnerQrScanState: Equatable {
    var hasReadWorkerId = false
    var hasReadDeviceId = false
    var setWorkerId = ""
    var setDeviceId = ""
}

enum OwnerQrScanAction {
    case scanQrCodeResult(result: String)
    case readWorkerId(id: String)
    case readDeviceId(id: String)
    case finishReadQrCode
}

struct OwnerQrScanEnvironment {
}

let ownerQrScanReducer = Reducer<OwnerQrScanState, OwnerQrScanAction, OwnerQrScanEnvironment> { state, action, _ in
    @StateObject var workerSettingManager = WorkerSettingManager()

    switch action {
    case .scanQrCodeResult(let result):
        if result.contains("worker_") {
            return .concatenate(
                Effect(value: .readWorkerId(id: result))
            )
        }
        if result.contains("device_") {
            return .concatenate(
                Effect(value: .readDeviceId(id: result))
            )
        }
        return .none

    case .readWorkerId(let id):
        state.setWorkerId = id
        state.hasReadWorkerId = true
        return Effect(value: .finishReadQrCode)

    case .readDeviceId(let id):
        state.setDeviceId = id
        state.hasReadDeviceId = true
        return Effect(value: .finishReadQrCode)

    case .finishReadQrCode:
        if state.hasReadWorkerId && state.hasReadDeviceId,
           !state.setWorkerId.isEmpty,
           !state.setDeviceId.isEmpty {
            state.hasReadWorkerId = false
            state.hasReadDeviceId = false
            // TODO: ここに朝礼時のQRコードを読み取った後の処理を書く。Firestoreへの書き込みをして、WorkerApp側のTCAを反応させて画面を切り替えさせる。
            // TODO: setData or UpdataData と addSnapshotLisenerを使って、処理を連携させる。
            workerSettingManager.setAfterMorningMeetingData(
                name: "テストですか", workerId: state.setWorkerId, deviceId: state.setDeviceId)
            return .none
        }
        return .none
    }
}
