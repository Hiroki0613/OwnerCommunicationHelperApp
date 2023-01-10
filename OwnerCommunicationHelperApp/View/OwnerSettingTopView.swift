//
//  OwnerSettingTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import FirebaseAuthUI
import SwiftUI

struct OwnerSettingTopView: View {

    let store: Store<OwnerSettingTopState, OwnerSettingTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                PrimaryColor.background
                ScrollView {
                    VStack {
                        Spacer().frame(height: 20)
                        OwnerSettingOperatingTimeView(startTime: "8:30", endTime: "17:30")
                            .cornerRadius(20)
                        Spacer().frame(height: 30)
                        OwnerSettingPressureView(viewStore: viewStore)
                            .cornerRadius(20)
                        Spacer().frame(height: 30)
                        OwnerSettingSubscriptionView()
                            .cornerRadius(20)
                        Spacer().frame(height: 30)
                        Button(action: {
//                            viewStore.send(.gotoQrCodeCreateView(true))
                            do {
                                try Auth.auth().signOut()
                            } catch {
                                print("error")
                            }
                        }, label: {
                            Text("Workerの追加")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, minHeight: 91)
                                .background(PrimaryColor.buttonRedColor)
                                .cornerRadius(20)
                        })
                    }
                    .padding(.horizontal, 30)
                }
                .clipped()
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.hasShowedQrCode,
                        send: OwnerSettingTopAction.gotoQrCodeCreateView
                    )) {
    //                    OwnerQRCodeView()
                        Text("QRコードを表示")
                    }
            }
        }
    }
}

struct OwnerSettingTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingTopView(
            store: Store(
                initialState: OwnerSettingTopState(
                    pressureString: "",
                    hasShowedQrCode: true
                ),
                reducer: ownerSettingTopReducer,
                environment: OwnerSettingTopEnvironment()
            )
        )
    }
}
