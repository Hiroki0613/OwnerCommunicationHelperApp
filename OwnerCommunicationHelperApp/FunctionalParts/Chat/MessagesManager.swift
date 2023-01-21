//
//  MessagesManager.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/14.
//

//参考URL https://github.com/stephdiep/ChatApp
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    // Create an instance of our Firestore database
    let db = Firestore.firestore()

    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages(personalId: String) {
        // TODO: チャットの構成を確定すること。
        db.collection("OwnerList").document("123456789").collection("ChatRoomId").document(personalId).collection("Chat").addSnapshotListener { querySnapshot, error in
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")
                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }

    // Add a message in Firestore
    func sendMessage(text: String, personalId: String) {
        do {
            guard text.isEmpty == false else { return }
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            // TODO: チャットに送信する情報を編集すること
            let newMessage = Message(id: "\(UUID())", personalId: "",personalInformation: "", text: text, timestamp: Date())
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try db.collection("OwnerList").document("123456789").collection("ChatRoomId").document(personalId).collection("Chat").document().setData(from: newMessage)
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
}
