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
    var personalInformation: String
    var text: String
    var timestamp: Date
}
