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
    @StateObject var workerSettingManager = WorkerSettingManager()
    let store: Store<OwnerSettingTopState, OwnerSettingTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    PrimaryColor.backgroundGreen
                        .ignoresSafeArea()
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
                            NavigationLink(
                                destination: {
                                    OwnerChatTalkListView()
                                },
                                label: {
                                    Text("チャット")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, minHeight: 91)
                                        .background(PrimaryColor.buttonRed)
                                        .cornerRadius(20)
                                }
                            )
                            Spacer().frame(height: 30)
                            Group {
                                Button(
                                    action: {
                                        viewStore.send(.gotoRegisterWorkerView(true))
                                    }, label: {
                                        Text("Worker,Staff,Terminalの追加")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                                Spacer().frame(height: 30)
                                Button(
                                    action: {
                                        viewStore.send(.gotoQrCodeScanView(true))
                                    }, label: {
                                        Text("QRコードスキャン")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                                Spacer().frame(height: 30)
                                Button(
                                    action: {
                                        do {
                                            try Auth.auth().signOut()
                                        } catch {
                                            print("error")
                                        }
                                    }, label: {
                                        Text("ログアウト")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 30)
                        Spacer().frame(height: 30)
                    }
                    .clipped()
                    .fullScreenCover(
                        isPresented: viewStore.binding(
                            get: \.hasShowedQrCodeScanView,
                            send: OwnerSettingTopAction.gotoQrCodeScanView
                        )
                    ) {
                        OwnerScanQrCodeView(
                            store: store.scope(
                                state: \.ownerQrScanState,
                                action: OwnerSettingTopAction.ownerQrScanAction
                            ),
                            goBackAction: {
                                viewStore.send(.gotoQrCodeScanView(false))
                            }
                        )
                    }
                    .fullScreenCover(
                        isPresented: viewStore.binding(
                            get: \.hasShowedRegisterWorkerView,
                            send: OwnerSettingTopAction.gotoRegisterWorkerView
                        )
                    ) {
                        OwnerRegisterWorkerView(viewStore: viewStore)
                            .environmentObject(workerSettingManager)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
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
                    hasShowedQrCodeScanView: true
                ),
                reducer: ownerSettingTopReducer,
                environment: OwnerSettingTopEnvironment()
            )
        )
    }
}
