//
//  OwnerManagerWorkerQRCodeView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import SwiftUI

struct OwnerManagerWorkerQRCodeView: View {
    @StateObject var workerSettingManager = WorkerSettingManager()
    @StateObject var messagesManager = MessagesManager()
    @Environment(\.dismiss) var dismiss
    var name: String
    var personalId: String
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
                .ignoresSafeArea()
            VStack {
                Spacer()
                CommonText(text: name, alignment: .center)
                if let personalQrIdImage = qRCodeGenerator.generate(with: personalId) {
                    Image(uiImage: personalQrIdImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                Spacer().frame(height: 30)
                Button(
                    action: {
                        dismiss()
                        print("hirohiro_d_personalId: ", personalId)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            workerSettingManager.deleteWorkerData(personalId: personalId)
//                            messagesManager.deleteMessage(personalId: personalId)
                        }
                    }, label: {
                        Text("削除")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, minHeight: 91)
                            .background(PrimaryColor.buttonRed)
                            .cornerRadius(20)
                    }
                )
                Spacer()
            }
        }
    }
}

struct OwnerManagerWorkerQRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManagerWorkerQRCodeView(name: "", personalId: "")
    }
}
