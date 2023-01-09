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

    var body: some View {
        WithViewStore(store) { viewStore in
            TabView {
                OwnerSettingTopView(
                    store: store.scope(
                        state: \.settingTopState,
                        action: OwnerTopAction.settingTopAction
                    )
                )
                    .tabItem {
                        Label("設定", systemImage: "gear")
                    }
                OwnerManageStaffTopView()
                    .tabItem {
                        Label("スタッフ", systemImage: "person")
                    }
                OwnerManageWorkerTopView()
                    .tabItem {
                        Label("作業者", systemImage: "hammer.fill")
                    }
            }
        }
    }
}

//struct OwnerTopView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerTopView()
//    }
//}
