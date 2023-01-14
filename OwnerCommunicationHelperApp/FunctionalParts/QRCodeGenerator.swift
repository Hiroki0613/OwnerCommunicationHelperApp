//
//  QRCodeGenerator.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/12.
//

import SwiftUI

// https://dev.classmethod.jp/articles/swift-generate-qr-code/
struct QRCodeGenerator {
    func generate(with inputText: String) -> UIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let inputData = inputText.data(using: .utf8)
        qrFilter.setValue(inputData, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        guard let ciImage = qrFilter.outputImage else { return nil }
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCiImage = ciImage.transformed(by: sizeTransform)
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledCiImage, from: scaledCiImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

// TODO: QRコードを作成した時についでに行うこと。　匿名ログインでも問題が無いかは要確認。
/*
 　1. 同時にFirebaseでデータを作成。そのときにFCMトークン欄も作成しておくこと。
 　2. FCMトークンは朝の調整時に毎回、データを入れ替える。そのことで、トークンが入れ替わっていたら再セットをしなおす。
 　3. FCMトークンはPush通知で使うために用意する。これが匿名ログインでも効果を発揮したら万歳である。
 */
