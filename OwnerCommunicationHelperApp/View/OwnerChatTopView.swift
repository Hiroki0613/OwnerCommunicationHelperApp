//
//  OwnerChatTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/15.
//

import SwiftUI

struct OwnerChatTopView: View {
    @StateObject var messagesManager = MessagesManager()

    var body: some View {
        ZStack {
            PrimaryColor.buttonColor
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            let _ = print("hirohiro_message: ", message)
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 10)
                    .background(.green)
                    .onChange(of: messagesManager.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                MessageField()
                    .environmentObject(messagesManager)
            }
        }
        .onAppear {
            messagesManager.getMessages()
        }

    }
}

struct OwnerChatTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerChatTopView()
    }
}
