//
//  OwnerChatTalkListView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/18.
//

import SwiftUI

struct OwnerChatTalkListView: View {
    @StateObject var workerSettingManager = WorkerSettingManager()

    var body: some View {
        ZStack {
            PrimaryColor.backgroundSnowWhite
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Spacer().frame(height: 20)
                    ZStack {
                        PrimaryColor.backgroundGreen
                        Text("誰と話しますか？")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .padding(20)
                    }
                    .cornerRadius(20)
                    Spacer().frame(height: 20)
                    ForEach(workerSettingManager.workers, id: \.id) { worker in
                        NavigationLink(
                            destination: {
                                OwnerChatTopView(personalId: worker.personalId)
                            },
                            label: {
                                OwnerChatWorkerCellView(name: worker.name)
                                    .cornerRadius(20)
                                    .environmentObject(workerSettingManager)
                            }
                        )
                        Spacer().frame(height: 10)
                    }
                }
                .padding(.horizontal, 30)
            }
            .clipped()
        }
        .onAppear {
            workerSettingManager.getWorkerData()
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
                .foregroundColor(Color.white)
                .padding(20)
        }
    }
}
