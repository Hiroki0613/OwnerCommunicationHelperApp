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
    @EnvironmentObject var workerSettingManager: WorkerSettingManager

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    PrimaryColor.backgroundGreen
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
                                        // TODO: Workerを追加するViewを作成する。
//                                        workerSettingManager.setRegistrationData(name: "テスト4", personalId: 999)
                                    }, label: {
                                        Text("Workerの追加")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                                Button(
                                    action: {
                                        // 一旦、FirebaseでWorkerが追加されているかを確認する
                                        viewStore.send(.gotoQrCodeCreateView(true))
                                    }, label: {
                                        Text("QRコードの表示")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
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
                            get: \.hasShowedQrCode,
                            send: OwnerSettingTopAction.gotoQrCodeCreateView
                        )) {
//                            OwnerQRCodeView()
                            Text("QRコードを表示")
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
                    hasShowedQrCode: true
                ),
                reducer: ownerSettingTopReducer,
                environment: OwnerSettingTopEnvironment()
            )
        )
    }
}
