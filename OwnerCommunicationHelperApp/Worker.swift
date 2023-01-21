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
    var personalId: Int
    var timestamp: Date
}

class WorkerSettingManager: ObservableObject {
    @Published private(set) var workers: [Worker] = []
    let db = Firestore.firestore()

    func setRegistrationData(name: String, personalId: Int) {
        do {
            let newWorker = Worker(id: "\(UUID())", name: name, personalId: personalId, timestamp: Date())
            try db.collection("WorkerData").document(String(personalId)).setData(from: newWorker)
        } catch {
            print("WorkerSettingManager / Error adding message to Firestore: \(error)")
        }
    }
}