//
//  OwnerTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerTopView: View {
    var body: some View {
        TabView {
            OwnerSettingTopView()
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

struct OwnerTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTopView()
    }
}
