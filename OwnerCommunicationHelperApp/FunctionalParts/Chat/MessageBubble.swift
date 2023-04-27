//
//  MessageBubble.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/14.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    var isMessageReceived: Bool

    var body: some View {
        if isMessageReceived {
            // 左側 自分以外
            VStack {
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
            .padding(.horizontal, 10)
        } else {
            // 右側　自分自身
            VStack {
                HStack(spacing: .zero) {
                    Spacer()
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
                    Spacer().frame(width: 5)
                    Text(message.text)
                        .font(.caption2)
                        .fontWeight(.thin)
                        .padding(.all, 10)
                        .foregroundColor(.black)
                        .background(isMessageReceived ? PrimaryColor.buttonLightGray : PrimaryColor.buttonRed)
                        .cornerRadius(10)
                    Spacer().frame(width: 5)
                }
                .frame(maxWidth: 300, alignment: isMessageReceived ? .leading : .trailing)
            }
            .padding(.horizontal, 10)
        }
        Spacer().frame(height: 10)
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
            ), isMessageReceived: true
        )
    }
}
