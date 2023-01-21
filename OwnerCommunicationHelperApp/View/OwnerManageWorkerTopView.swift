//
//  OwnerManageWorkerTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct OwnerManageWorkerTopView: View {
    @StateObject var workerSettingManager = WorkerSettingManager()

    var body: some View {
        NavigationView {
            ZStack {
                PrimaryColor.backgroundGreen
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Spacer().frame(height: 20)
                        Text("作業者")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        ForEach(workerSettingManager.workers, id: \.id) { worker in
                            let _ = print("hirohiro_ゲット")
                            NavigationLink(
                                destination: {
                                    Text(worker.name)
                                },
                                label: {
                                    OwnerManageWorkerCellView(name: worker.name)
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
        }
        .onAppear {
            workerSettingManager.getWorkerData()
        }
    }
}

struct OwnerManageWorkerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffTopView()
    }
}
