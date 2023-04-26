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
    var id: String = ""
    var ownerId: String = ""
    var startWorkTime: Double = 0
    var endWorkTime: Double = 0
    var numberOfPeopleCanRegister: Int = 0
}

class OwnerSettingManager: ObservableObject {
    @Published private(set) var owner = Owner()
    let db = Firestore.firestore()

    func getOwnerData() {
        guard let auth = Auth.auth().currentUser?.uid else { return }
//        db.collection("OwnerList").document(auth).getDocument { document, error in
//            guard error == nil else {
//                print("error", error ?? "")
//                return
//            }
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    self.owner.id = data["id"] as? String ?? ""
//                    self.owner.ownerId = data["ownerId"] as? String ?? ""
//                    self.owner.startWorkTime = data["startWorkTime"] as? Double ?? 0
//                    self.owner.endWorkTime = data["endWorkTime"] as? Double ?? 0
//                    self.owner.numberOfPeopleCanRegister = data["numberOfPeopleCanRegister"] as? Int ?? 0
//                }
//            }
//        }
        db.collection("OwnerList").document(auth).addSnapshotListener { document, error in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.owner.id = data["id"] as? String ?? ""
                    self.owner.ownerId = data["ownerId"] as? String ?? ""
                    self.owner.startWorkTime = data["startWorkTime"] as? Double ?? 0
                    self.owner.endWorkTime = data["endWorkTime"] as? Double ?? 0
                    self.owner.numberOfPeopleCanRegister = data["numberOfPeopleCanRegister"] as? Int ?? 0
                }
            }
        }
    }

    func setOwnerData() {
        do {
            guard let auth = Auth.auth().currentUser?.uid else { return }
            let newOwner = Owner(id: auth, ownerId: auth, startWorkTime: Date().timeIntervalSince1970, endWorkTime: Date().timeIntervalSince1970, numberOfPeopleCanRegister: 7)
            try db.collection("OwnerList").document(auth).setData(from: newOwner)
        } catch {
            print("OwnerSettingManager / Error adding message to Firestore: \(error)")
        }
    }

    func updateOperatingTime(startWorkTime: Date, endWorkTime: Date) {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).updateData(
            [
                "startWorkTime": startWorkTime.timeIntervalSince1970 as Any,
                "endWorkTime": endWorkTime.timeIntervalSince1970 as Any
            ]
        )
    }
}
