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
        // https://ymgsapo.com/2022/11/17/swiftuifirestore-swiftui-list/
//        import Foundation
//        import FirebaseFirestore
//
//        struct Message: Identifiable {
//            var id: String = UUID().uuidString
//            var name: String
//            var post: String
//            var dateEvent: Date
//            var dateString: String {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy年M月d日 H時m分"
//                return formatter.string(from: dateEvent)
//            }
//        }
//
//        class ViewModel: ObservableObject {
//
//            @Published var messages = [Message]()
//
//            private var db = Firestore.firestore()
//
//            func fetchData() {
//                db.collection("messages").addSnapshotListener { (querySnapshot, error) in
//                    guard let documents = querySnapshot?.documents else {
//                        print("No documents")
//                        return
//                    }
//
//                    self.messages = documents.map { (queryDocumentSnapshot) -> Message in
//                        let data = queryDocumentSnapshot.data()
//                        let name = data["name"] as? String ?? ""
//                        let post = data["post"] as? String ?? ""
//                        let dateEvent = (data["time"] as? Timestamp)?.dateValue() ?? Date()
//                        return Message(name: name, post: post, dateEvent: dateEvent)
//                    }
//                }
//            }
//        }
        
        
        
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
