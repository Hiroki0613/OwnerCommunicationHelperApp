//
//  OwnerChatTalkListView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/18.
//

import SwiftUI

struct OwnerChatTalkListView: View {

    // TODO: personalIdをランダムで作成するようにする。
    var workerArray = [
        Worker(id: "\(UUID())", name: "ヤマダ", personalId: 111, timestamp: Date()),
        Worker(id: "\(UUID())", name: "スズキ", personalId: 222, timestamp: Date()),
        Worker(id: "\(UUID())", name: "サトウ", personalId: 333, timestamp: Date()),
        Worker(id: "\(UUID())", name: "エンドウ", personalId: 444, timestamp: Date())
    ]

    var body: some View {
        ZStack {
            PrimaryColor.backgroundSnowWhite
            ScrollView {
                VStack {
                    ForEach(workerArray) { worker in
                        NavigationLink(
                            destination: OwnerChatTopView(personalId: worker.personalId),
                            label: {
                                OwnerChatWorkerCellView(name: worker.name)
                                    .cornerRadius(20)
                                Spacer().frame(height: 10)
                            }
                        )
                    }
                }
            }
        }
    }
}

struct OwnerChatTalkListView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerChatTalkListView()
    }
}

struct OwnerChatWorkerCellView: View {
    var name: String
    
    var body: some View {
        ZStack {
            PrimaryColor.buttonLavenderRose
            Text(name + "さん")
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .padding(20)
        }
    }
}
