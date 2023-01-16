//
//  MessageBubble.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/14.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    // TODO: MessageBubbleでのアライメント、色などはpersonalIdで判別すること。
    var isMessageReceived = false

    // TODO: 身体情報を入れるUIを作成すること personalInformation
    var body: some View {
        VStack(alignment: isMessageReceived ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(isMessageReceived ? PrimaryColor.buttonColor : PrimaryColor.buttonRed)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: isMessageReceived ? .leading : .trailing)
            Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(isMessageReceived ? .leading : .trailing, 25)
        }
        .frame(maxWidth: .infinity, alignment: isMessageReceived ? .leading : .trailing)
        .padding(isMessageReceived ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(
            message: Message(
                id: "",
                personalId: "",
                personalInformation: "",
                text: "",
                timestamp: Date()
            )
        )
    }
}
