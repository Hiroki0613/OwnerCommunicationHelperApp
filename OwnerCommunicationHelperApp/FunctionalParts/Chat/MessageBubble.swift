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
    var isMessageReceived = true

    // TODO: 身体情報を入れるUIを作成すること personalInformation
    var body: some View {
        VStack(alignment: isMessageReceived ? .leading : .trailing) {
            HStack(spacing: .zero) {
                Text(message.text)
                    .font(.caption2)
                    .fontWeight(.thin)
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .background(isMessageReceived ? PrimaryColor.buttonLightGray : PrimaryColor.buttonRed)
                    .cornerRadius(10)
                Spacer().frame(width: 5)
                VStack {
                    Spacer()
                    Text("\(message.personalInformation)")
                        .font(.caption2)
                        .fontWeight(.thin)
                        .foregroundColor(.gray)
                        .padding(isMessageReceived ? .leading : .trailing, 10)
                    Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(isMessageReceived ? .leading : .trailing, 10)
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: 300, alignment: isMessageReceived ? .leading : .trailing)
         
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
