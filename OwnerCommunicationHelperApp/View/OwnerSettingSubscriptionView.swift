//
//  OwnerSettingSubscriptionView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerSettingSubscriptionView: View {
    var numberOfPeopleCanRegister: Int?

    var body: some View {
        ZStack {
            PrimaryColor.buttonLightGray
            VStack {
                CommonText(text: "運用状況", alignment: .leading)
                CommonText(text: "可能登録人数 \(numberOfPeopleCanRegister)人", alignment: .trailing)
                CommonText(text: "残り \(numberOfPeopleCanRegister)人", alignment: .trailing)
            }
            .padding(20)
        }
    }
}

struct OwnerSettingsubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingSubscriptionView(numberOfPeopleCanRegister: 7)
    }
}
