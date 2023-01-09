//
//  OwnerSettingPressureView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import CoreMotion
import SwiftUI

struct OwnerSettingPressureView: View {
    @ObservedObject var manager = AltimatorManager()
    let viewStore: ViewStore<OwnerTopState, OwnerTopAction>
    let availabe = CMAltimeter.isRelativeAltitudeAvailable()

    var body: some View {
        ZStack {
            PrimaryColor.buttonColor
            VStack {
                CommonText(text: availabe ? manager.pressureString : "----", alignment: .leading)
            }
            .padding(20)
        }
        .onAppear {
            viewStore.send(.setPressure(manager.pressureString))
        }
    }
}

struct OwnerSettingPressureView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingPressureView(
            viewStore: ViewStore(
                Store(
                    initialState: OwnerTopState(),
                    reducer: ownerTopReducer,
                    environment: OwnerTopEnvironment()
                )
            )
        )
    }
}
