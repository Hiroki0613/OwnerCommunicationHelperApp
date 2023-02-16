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
    @Published private(set) var owner: Owner?
    let db = Firestore.firestore()

    func getOwnerData() {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).getDocument { document, error in
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
        
        
        // TODO: 参考コード
        // https://stackoverflow.com/questions/59826967/swiftui-assign-firbase-database-output-to-data-model
//            var user = User()
//            let docRef = db.collection("users").document(Auth.auth().currentUser?.uid)
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Document data: \(dataDescription)")
//                    user.username = document.data(["username"]) as! String
//                    user.email= document.data(["email"]) as! String
//                } else {
//                    print("Document does not exist")
//                }
//            }
    }

    func setOwnerData(name: String) {
        do {
            // TODO: authを失敗することはないと思うが、失敗した時の考慮は入れたほうが良いかも・・・
            guard let auth = Auth.auth().currentUser?.uid else { return }
            let newOwner = Owner(id: auth, ownerId: auth, startWorkTime: Date(), endWorkTime: Date(), numberOfPeopleCanRegister: 7)
            try db.collection("OwnerList").document(auth).setData(from: newOwner)
        } catch {
            print("OwnerSettingManager / Error adding message to Firestore: \(error)")
        }
    }

    func updateOperatingTime(startWorkTime: Date, endWorkTime: Date) {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).updateData(
            [
                "startWorkTime": startWorkTime as Any,
                "endWorkTime": endWorkTime as Any
            ]
        )
    }
}
