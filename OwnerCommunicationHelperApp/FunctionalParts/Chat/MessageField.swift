//
//  MessageField.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/14.
//

import SwiftUI

struct MessageField: View {
    var personalId: String
    @EnvironmentObject var messagesManager: MessagesManager
    @State private var message = ""

    var body: some View {
        HStack {
            // Custom text field created below
            CustomTextField(placeholder: Text("文字を入力してください"), text: $message)
                .foregroundColor(.black)
                .font(.caption)
                .frame(height: 22)
                .disableAutocorrection(true)
            Button {
                messagesManager.sendMessage(text: message, personalId:personalId)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(10)
                    .background(.cyan)
                    .cornerRadius(20)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.mint)
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(personalId: "")
            .environmentObject(MessagesManager())
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
