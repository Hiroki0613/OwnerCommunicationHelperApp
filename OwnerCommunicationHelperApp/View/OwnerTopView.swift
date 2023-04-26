//
//  OwnerTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import SwiftUI

struct OwnerTopView: View {
    let store: Store<OwnerTopState, OwnerTopAction>
    @StateObject var workerSettingManager = WorkerSettingManager()
    @ObservedObject private var authState = FirebaseAuthStateObserver()
    @State var isShowSheet = false
    var userDefault: UserDefaultDataStore = UserDefaultsDataStoreProvider.provide()

    var body: some View {
        WithViewStore(store) { viewStore in
            // FirebaseのinfoPlistを追加すること。そうするとログイン機能が実装できる。
            let _ = print("hirohiro_OwnerTopView: ", userDefault.hasRegisterOwnerSetting, authState.isSignin)

//            if let hasRegisterOwnerSetting = userDefault.hasRegisterOwnerSetting,
//                authState.isSignin && hasRegisterOwnerSetting
            
            if authState.isSignin
            {
                TabView {
                    OwnerSettingTopView(
                        store: store.scope(
                            state: \.settingTopState,
                            action: OwnerTopAction.settingTopAction
                        )
                    )
                    .environmentObject(workerSettingManager)
                    .tabItem {
                        Label("設定", systemImage: "gear")
                    }
                    // TODO: OwnerManageWorkerTopViewを参考にスタッフ追加方法を検討する。その際に担当Workerの情報を設定する方法も検討する
                    OwnerManageStaffTopView()
                        .tabItem {
                            Label("スタッフ", systemImage: "person")
                        }
                    NavigationView {
                        OwnerManageWorkerTopView()
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                    }
                    .tabItem {
                        Label("作業者", systemImage: "hammer.fill")
                    }
                }
            } else if let hasRegisterOwnerSetting = userDefault.hasRegisterOwnerSetting,
                      authState.isSignin && !hasRegisterOwnerSetting {
                // TODO: 名前、開始時間、終了時間の初期設定をする画面を用意する。
                /*
                 1. DatePickerView()を参考にして、初期設定をする。
                 2. なにかviewStoreを発火させる方法を確認する。
                 3. 現状はuserDefaultsを使っているため、変更しても発火しない可能性がある。
                 */
                
                
                
            } else {
                ZStack {
                    PrimaryColor.backgroundGreen
                    VStack {
                        Text("少しでも力になれば幸いです")
                            .padding()
                        Button(
                            action: {
                                isShowSheet.toggle()
                            }, label: {
                                Text("AppleIDでログインしてください")
                            }
                        )
                    }
                }
            }
        }
        .sheet(isPresented: $isShowSheet, content: {
            ZStack {
                PrimaryColor.backgroundGreen
                VStack {
                    FirebaseUIView()
                }
            }
        })
    }
}

struct OwnerTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTopView(
            store: Store(
                initialState: OwnerTopState(
                    settingTopState: OwnerSettingTopState()
                ),
                reducer: topReducer,
                environment: OwnerTopEnvironment()
            ),
            isShowSheet: true
        )
    }
}
