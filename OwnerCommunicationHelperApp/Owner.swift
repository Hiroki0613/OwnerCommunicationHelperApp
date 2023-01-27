//
//  Owner.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Owner: Identifiable, Codable {
    var id: String
    var ownerId: String
    var startWorkTime: Date
    var endWorkTime: Date
    var numberOfPeopleCanRegister: Int
}

class OwnerSettingManager: ObservableObject {
    // TODO: ここの構造がおかしいので修正すること。
    @Published private(set) var owner: Owner?
    let db = Firestore.firestore()

    func getOwnerData() {
        db.collection("OwnerList").document("\(Auth.auth().currentUser?.uid)").getDocument { document, error in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("hirohiro_documentData: ", data)
                }
            }
        }
    }

    func setOwnerData(name: String) {
        do {
//            let newOwner = Worker(id: "\(Auth.auth().currentUser?.uid)", name: name, personalId: "\(Auth.auth().currentUser?.uid)", timestamp: Date())
            let newOwner = Owner(id: "\(Auth.auth().currentUser?.uid)", ownerId: "\(Auth.auth().currentUser?.uid)", startWorkTime: Date(), endWorkTime: Date(), numberOfPeopleCanRegister: 7)
            try db.collection("OwnerList").document("\(Auth.auth().currentUser?.uid)").setData(from: newOwner)
        } catch {
            print("OwnerSettingManager / Error adding message to Firestore: \(error)")
        }
    }
}
