//
//  OwnerRegisterWorkerView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import ComposableArchitecture
import SwiftUI

struct OwnerRegisterWorkerView: View {
    let viewStore: ViewStore<OwnerSettingTopState, OwnerSettingTopAction>
    @EnvironmentObject var workerSettingManager: WorkerSettingManager
    @State private var workerName = ""

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
            VStack {
                CommonText(text: "ワーカー追加", alignment: .center)
                Spacer().frame(height: 30)
                Group {
                    CustomTextField(
                        placeholder: Text("名前を入力してください"),
                        text: $workerName
                    )
                    .foregroundColor(.black)
                    .font(.caption)
                    .frame(height: 22)
                    .disableAutocorrection(true)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(PrimaryColor.backgroundSnowWhite)
                .cornerRadius(50)
                .padding()
                Spacer().frame(height: 30)
                Button(
                    action: {
                        let id = generateRandomWorkerId()
                        workerSettingManager.setRegistrationData(name: workerName, personalId: id)
                        workerName = ""
                    },
                    label: {
                        Text("追加")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 91)
                            .background(PrimaryColor.buttonRed)
                            .cornerRadius(20)
                    }
                )
                Spacer().frame(height: 30)
                Button(
                    action: {
                        viewStore.send(.gotoRegisterWorkerView(false))
                    },
                    label: {
                        Text("戻る")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 91)
                            .background(PrimaryColor.buttonRed)
                            .cornerRadius(20)
                    }
                )
            }
            .padding(20)
        }
    }

    func generateRandomWorkerId() -> String {
      let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //２０文字のランダムな文字列を生成
        let randomStr = String((0..<20).map{ _ in characters.randomElement()! })
      return "worker_\(randomStr)"
    }
}

struct OwnerRegisterWorkerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerRegisterWorkerView(
            viewStore: ViewStore(
                Store(
                    initialState: OwnerSettingTopState(),
                    reducer: ownerSettingTopReducer,
                    environment: OwnerSettingTopEnvironment()
                )
            )
        )
    }
}
