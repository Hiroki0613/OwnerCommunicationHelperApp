//
//  OwnerRegisterDeviceView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/04/04.
//

import FirebaseAuth
import SwiftUI

struct OwnerRegisterDeviceView: View {
    @Environment(\.dismiss) var dismiss
    var name: String
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
                .ignoresSafeArea()
            VStack {
                Spacer()
                if let deviceQrIdImage = qRCodeGenerator.generate(with: generateRandomDeviceId()),
                   let ownerId = Auth.auth().currentUser?.uid,
                   let ownerQrCodeIdImage = qRCodeGenerator.generate(with: "owner_\(ownerId)")
                {
                    CommonText(text: name, alignment: .center)
                    Image(uiImage: deviceQrIdImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer().frame(height: 30)
                    Image(uiImage: ownerQrCodeIdImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                Spacer().frame(height: 30)
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Text("戻る")
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

    func generateRandomDeviceId() -> String {
      let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        //２０文字のランダムな文字列を生成
        let randomStr = String((0..<20).map{ _ in characters.randomElement()! })
      return "device_\(randomStr)"
    }
}

struct OwnerRegisterDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerRegisterDeviceView(name: "")
    }
}
