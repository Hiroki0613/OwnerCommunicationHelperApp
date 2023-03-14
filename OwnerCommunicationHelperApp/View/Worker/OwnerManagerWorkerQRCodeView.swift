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
        // TODO: 削除したときに、nilクラッシュしないように調整をすること。例えば、一旦前の画面に戻してから、時間差で削除するなど
        // TODO: personalIdがnilの場合に表示する画面を用意する。
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
