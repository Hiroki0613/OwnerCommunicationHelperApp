//
//  OwnerSelectRegisterView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/10.
//

import SwiftUI

struct OwnerSelectRegisterView: View {
    // 登録する対処が、デバイス、作業者、スタッフを選ぶ
    var registerArray = ["デバイス", "作業者", "スタッフ"]

    init() {
        UITableView.appearance().backgroundColor = PrimaryUIColor.background
    }

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    Text("新規登録")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
//                    ForEach(0..<registerArray.count) { index in
//                        switch index {
//                        case 0:
//                            OwnerManageStaffCellView(name: registerArray[index])
//                                .cornerRadius(20)
//                        case 1:
//                            OwnerManageStaffCellView(name: registerArray[index])
//                                .cornerRadius(20)
//                        case 2:
//                            OwnerManageStaffCellView(name: registerArray[index])
//                                .cornerRadius(20)
//                        default:
//                            OwnerManageStaffCellView(name: registerArray[index])
//                                .cornerRadius(20)
//                        }
//                        Spacer().frame(height: 10)
//                    }
                    // TODO: ここで、それぞれの登録画面に遷移するようにする。
                }
                .padding(.horizontal, 30)
            }
            .clipped()
        }
    }
}

struct OwnerSelectRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSelectRegisterView()
    }
}
