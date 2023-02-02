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

    var body: some View {
        WithViewStore(store) { viewStore in
            // FirebaseのinfoPlistを追加すること。そうするとログイン機能が実装できる。
            if authState.isSignin {
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
                    // TODO: Owner情報を更新するようにする
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
