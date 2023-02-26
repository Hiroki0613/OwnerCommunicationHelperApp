//
//  DatePickerView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/02/26.
//

import ComposableArchitecture
import SwiftUI

struct DatePickerView: View {
    let viewStore: ViewStore<OwnerSettingTopState, OwnerSettingTopAction>
    @StateObject var ownerSettingManager = OwnerSettingManager()
    @State var startDate: Date
    @State var endDate: Date

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen.opacity(0.2)
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
                        ownerSettingManager.updateOperatingTime(startWorkTime: startDate, endWorkTime: endDate)
                        print("hirohiro_a_updateOperatingTime: ", startDate, endDate)
                        viewStore.send(.gotoDatePickerView(false))
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
            .frame(width: 300, height: 300)
            .background(PrimaryColor.backgroundGreen)
            .cornerRadius(20)
        }
    }
}

//struct DatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePickerView()
//    }
//}
