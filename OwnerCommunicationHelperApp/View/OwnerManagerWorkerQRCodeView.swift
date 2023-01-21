//
//  OwnerManagerWorkerQRCodeView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import SwiftUI

struct OwnerManagerWorkerQRCodeView: View {
    var name: String
    var personalId: String
    private let qRCodeGenerator = QRCodeGenerator()

    var body: some View {
        ZStack {
            PrimaryColor.backgroundGreen
            VStack {
                Spacer()
                CommonText(text: name, alignment: .center)
                if let personalQrIdImage = qRCodeGenerator.generate(with: personalId) {
                    Image(uiImage: personalQrIdImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
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