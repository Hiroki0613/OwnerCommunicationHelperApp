//
//  OwnerChatTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/15.
//

import SwiftUI

struct OwnerChatTopView: View {
    var personalId: String
    @StateObject var messagesManager = MessagesManager()

    var body: some View {
        ZStack {
            // TODO: チャット画面のUIを整えること。文字の大きさや、吹き出しも少し小さくすること。
            // TODO: 要望では、1日分だけをチャット画面にするので、タイムスタンプから当日分だけを取得すること。
            // TODO: チャット画面、現在はタブバーが見える。見えないようにすること。
            PrimaryColor.buttonLightGray
                .ignoresSafeArea()
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
                MessageField(personalId: personalId)
                    .environmentObject(messagesManager)
            }
        }
        .onAppear {
            messagesManager.getMessages(personalId: personalId)
        }
    }
}

struct OwnerChatTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerChatTopView(personalId: "")
    }
}
