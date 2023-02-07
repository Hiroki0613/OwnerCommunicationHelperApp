//
//  Message.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/14.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var personalId: String
    // ここに身体情報を入れる
    // Owner側も入れること
    // 他に情報が入っていたら追加する。
    /*
     支援者の方も脈拍測定は必要です。
     理由:障害当事者が支援者側の生態情報を見て相手の感情を読み取るため。
     */
    var personalInformation: String
    var text: String
    var timestamp: Date
}
