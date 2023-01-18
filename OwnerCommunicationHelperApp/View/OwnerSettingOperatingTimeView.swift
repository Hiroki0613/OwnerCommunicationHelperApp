//
//  OwnerSettingOperatingTimeView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerSettingOperatingTimeView: View {
    var startTime: String
    var endTime: String

    var body: some View {
        ZStack {
            PrimaryColor.buttonLightGray
            VStack {
                CommonText(text: "支援者", alignment: .leading)
                CommonText(text: "開始　" + startTime, alignment: .trailing)
                CommonText(text: "終了 " + endTime, alignment: .trailing)
            }
            .padding(20)
        }
    }
}

struct OwnerSettingOperatingTimeView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingOperatingTimeView(startTime: "", endTime: "")
    }
}
