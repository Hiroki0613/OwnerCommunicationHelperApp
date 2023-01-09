//
//  Constants.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

enum PrimaryColor {
    // スイッチで背景色を切り替える
    static let buttonColor = buttonLightGray
    static let buttonRedColor = buttonRed
    static let background = backgroundGreen
    // カラー配色
    static let buttonLightGray = Color(red: 0.961, green: 0.961, blue: 0.937)
    static let buttonRed = Color(red: 0.758, green: 0.145, blue: 0.145)
    static let backgroundGreen = Color(red: 0.424, green: 0.780, blue: 0.761)
    // 白黒配色
    static let buttonWhite = Color(red: 0.0, green: 0.0, blue: 0.0)
    static let buttonGray = Color(red: 0.50, green: 0.50, blue: 0.50)
    static let backgroundBlack = Color(red: 1.0, green: 1.0, blue: 1.0)
}

enum PrimaryUIColor {
    static let background = UIColor.init(red: 0.424, green: 0.780, blue: 0.761, alpha: 1)
}
