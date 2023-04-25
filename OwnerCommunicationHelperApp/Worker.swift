//
//  Worker.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/18.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Worker: Identifiable, Codable {
    var id: String
    var name: String
    var workerId: String
    var deviceId: String
    // ここのタイムスタンプを更新することで朝礼のスキャンが出来ているかを確認する。
    var timestamp: Date
}

class WorkerSettingManager: ObservableObject {
    @Published private(set) var workers: [Worker] = []
    let db = Firestore.firestore()

    func getWorkerData() {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).collection("WorkerData").addSnapshotListener { querySnapshot, error in
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

    func setRegistrationData(name: String, workerId: String) {
        do {
            guard let auth = Auth.auth().currentUser?.uid else { return }
//            let newWorker = Worker(id: "\(UUID())", name: name, personalId: personalId, timestamp: Date())
            let newWorker = Worker(
                id: "\(UUID())",
                name: name,
                workerId: workerId,
                deviceId: "777",
                timestamp: Date()
            )
            try db.collection("OwnerList").document(auth).collection("WorkerData").document(workerId).setData(from: newWorker)
        } catch {
            print("WorkerSettingManager / Error adding message to Firestore: \(error)")
        }
    }

    // 朝会後に端末とWorkerIdを紐づけるもの
    func setAfterMorningMeetingData(name: String, workerId: String, deviceId: String) {
        do {
            guard let auth = Auth.auth().currentUser?.uid else { return }
            let newWorker = Worker(
                id: "\(UUID())",
                name: name,
                workerId: workerId,
                deviceId: deviceId,
                timestamp: Date()
            )
            try db.collection("OwnerList").document(auth).collection("WorkerData").document(workerId).setData(from: newWorker)
        } catch {
            print("WorkerSettingManager / Error adding message to Firestore: \(error)")
        }
    }
    

    func deleteWorkerData(personalId: String, completion: @escaping(Error?) -> Void) {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        db.collection("OwnerList").document(auth).collection("WorkerData").document(personalId).delete() { error in
            completion(error)
        }
    }
}
