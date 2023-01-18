//
//  OwnerManageStaffCellView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/17.
//

import SwiftUI

struct OwnerManageStaffCellView: View {
    var name: String
    
    var body: some View {
        ZStack {
            PrimaryColor.buttonLightGray
            Text(name + "さん")
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .padding(20)
        }
    }
}

struct OwnerManageStaffCellView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerManageStaffCellView(name: "")
    }
}
