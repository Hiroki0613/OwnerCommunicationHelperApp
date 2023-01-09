//
//  CommonText.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

struct CommonText: View{
    var text: String
    var alignment: Alignment

    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: alignment)
            .font(.system(size: 20))
            .foregroundColor(Color.black)
    }
}
