//
//  OwnerManageWorkerTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerManageWorkerTopView: View {
    var nameArray = ["ヤマダ", "スズキ", "サトウ", "エンドウ"]

    var body: some View {
        ZStack {
            PrimaryColor.background
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    Text("作業者")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                    ForEach(0..<nameArray.count) { index in
                        OwnerManageWorkerCellView(name: nameArray[index])
                            .cornerRadius(20)
                        Spacer().frame(height: 10)
                    }
                }
                .padding(.horizontal, 30)
            }
            .clipped()
        }
    }
}

struct OwnerManageWorkerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffTopView()
    }
}
