//
//  OwnerSettingOperatingTimeView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerSettingOperatingTimeView: View {
    var startTime: Date
    var endTime: Date

    var body: some View {
        ZStack {
            PrimaryColor.buttonLightGray
            VStack {
                // TODO: 開始時刻、終了時刻はFirebase側で変更できるようにする。
                CommonText(text: "支援者", alignment: .leading)
                HStack {
                    Spacer()
                    CommonText(text: "開始　", alignment: .trailing)
                    Text(startTime ,style: .time)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                }
                HStack {
                    Spacer()
                    CommonText(text: "終了　", alignment: .trailing)
                    Text(endTime ,style: .time)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                }
//                CommonText(text: "開始　" + startTime, alignment: .trailing)
//                CommonText(text: "終了 " + endTime, alignment: .trailing)
            }
            .padding(20)
        }
    }
}

struct OwnerSettingOperatingTimeView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingOperatingTimeView(startTime: Date(), endTime: Date())
    }
}
