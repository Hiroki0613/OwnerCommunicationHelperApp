//
//  OwnerSelectRegisterView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/10.
//

import ComposableArchitecture
import SwiftUI

struct OwnerSelectRegisterView: View {
    @StateObject var workerSettingManager = WorkerSettingManager()
    let store: Store<OwnerSettingTopState, OwnerSettingTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                PrimaryColor.backgroundGreen
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Spacer().frame(height: 20)
                        Text("新規登録")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        Button(
                            action: {
                                viewStore.send(.gotoQrCodeReadView(true))
                            }, label: {
                                Text("デバイス追加")
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
                                viewStore.send(.gotoRegisterWorkerView(true))
                            }, label: {
                                Text("Worker追加")
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
                                // TODO: ここはスタッフ追加の画面を開くようにする。
                            }, label: {
                                Text("スタッフ追加")
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
                                viewStore.send(.gotoSelectRegisterView(false))
                            }, label: {
                                Text("閉じる")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, minHeight: 91)
                                    .background(PrimaryColor.buttonRed)
                                    .cornerRadius(20)
                            }
                        )
                    }
                    .padding(.horizontal, 30)
                }
                .clipped()
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.hasShowedRegisterWorkerView,
                        send: OwnerSettingTopAction.gotoRegisterWorkerView
                    )
                ) {
                    OwnerRegisterWorkerView(viewStore: viewStore)
                        .environmentObject(workerSettingManager)
                }
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.hasShowedQrCodeReadView,
                        send: OwnerSettingTopAction.gotoQrCodeReadView
                    )
                ) {
                    OwnerRegisterDeviceView(name: "hirohiro_test", personalId: "abcdefg")
                }
            }
        }
    }
}

struct OwnerSelectRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSelectRegisterView(
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
