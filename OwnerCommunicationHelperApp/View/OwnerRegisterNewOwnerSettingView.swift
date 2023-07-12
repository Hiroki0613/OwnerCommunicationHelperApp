//
//  OwnerRegisterNewOwnerSettingView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/26.
//

import ComposableArchitecture
import SwiftUI

struct OwnerRegisterNewOwnerSettingView: View {
    let viewStore: ViewStore<OwnerSettingTopState, OwnerSettingTopAction>
    @StateObject var ownerSettingManager = OwnerSettingManager()
    @State var name: String
    @State var startDate: Date
    @State var endDate: Date

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
            VStack {
                HStack {
                    Spacer().frame(width: 30)
                    Text("開始時間")
                    Spacer().frame(width: 30)
                    DatePicker("", selection: $startDate, displayedComponents: .hourAndMinute)
                    Spacer().frame(width: 30)
                }
                Spacer().frame(height: 30)
                HStack {
                    Spacer().frame(width: 30)
                    Text("終了時間")
                    Spacer().frame(width: 30)
                    DatePicker("", selection: $endDate, displayedComponents: .hourAndMinute)
                    Spacer().frame(width: 30)
                }
                Spacer().frame(height: 30)
                Button(
                    action: {
                        // TODO: ここで許可ダイアログを入れる。
//                        ownerSettingManager.updateOperatingTime(startWorkTime: startDate, endWorkTime: endDate)
                        ownerSettingManager.setOwnerData()
                        print("hirohiro_a_updateOperatingTime: ", startDate, endDate)
                        // OwnerRegisterNewOwnerSettingViewを閉じること。
                    },
                    label: {
                        Text("決定")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(PrimaryColor.buttonRed)
                            .cornerRadius(20)
                    }
                )
            }
        }
    }
}

//struct OwnerRegisterNewOwnerSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnerRegisterNewOwnerSettingView()
//    }
//}
