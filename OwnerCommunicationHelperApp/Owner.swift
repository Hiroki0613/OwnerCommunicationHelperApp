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
    @Published private(set) var owner: Owner = Owner(id: "", ownerId: "", startWorkTime: Date(), endWorkTime: Date(), numberOfPeopleCanRegister: 7)
    let db = Firestore.firestore()

    func getOwnerData() {
        db.collection("OwnerList").document("\(Auth.auth().currentUser?.uid)").getDocument { snapShot, error in
            guard let document = snapShot?.exists else {
                print("OwnerDataSettingManager / Error fetching documents: \(String(describing: error))")
                return
            }
            // TODO: ここにデータを格納する
        }
    }

    func setOwnerData(name: String) {
        do {
            let newOwner = Worker(id: "\(String(describing: Auth.auth().currentUser?.uid))", name: name, personalId: "\(Auth.auth().currentUser?.uid)", timestamp: Date())
            try db.collection("OwnerList").document("\(Auth.auth().currentUser?.uid)").setData(from: newOwner)
        } catch {
            print("OwnerSettingManager / Error adding message to Firestore: \(error)")
        }
    }
}
