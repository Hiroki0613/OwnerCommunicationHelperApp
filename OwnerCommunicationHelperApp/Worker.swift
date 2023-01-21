//
//  Worker.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/18.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Worker: Identifiable, Codable {
    var id: String
    var name: String
    var personalId: String
    // ここのタイムスタンプを更新することで朝礼のスキャンが出来ているかを確認する。
    var timestamp: Date
}

class WorkerSettingManager: ObservableObject {
    @Published private(set) var workers: [Worker] = []
    let db = Firestore.firestore()

    func getWorkerData() {
        db.collection("OwnerList").document("123456789").collection("WorkerData").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("WorkerSettingManager / Error fetching documents: \(String(describing: error))")
                return
            }
            self.workers = documents.compactMap{ document -> Worker? in
                do {
                    return try document.data(as: Worker.self)
                } catch {
                    print("WorkerSettingManager / Error decoding document into Message: \(error)")
                    return nil
                }
            }
        }
    }

    func setRegistrationData(name: String, personalId: String) {
        do {
            let newWorker = Worker(id: "\(UUID())", name: name, personalId: personalId, timestamp: Date())
            try db.collection("OwnerList").document("123456789").collection("WorkerData").document(personalId).setData(from: newWorker)
        } catch {
            print("WorkerSettingManager / Error adding message to Firestore: \(error)")
        }
    }
}
