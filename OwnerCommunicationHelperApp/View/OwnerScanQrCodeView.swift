//
//  OwnerScanQrCodeView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/21.
//

import ComposableArchitecture
import SwiftUI

struct OwnerScanQrCodeView: View {
    let store: Store<OwnerQrScanState, OwnerQrScanAction>
    var goBackAction: () -> Void

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                QrCodeScannerView(viewStore: viewStore)
                VStack {
                    VStack {
                        Spacer().frame(height: 40)
                        Text("QRコードを読み込んでください")
                            .font(.system(size: 18))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(PrimaryColor.buttonLightGray)
                            .cornerRadius(20)
                            .padding(.horizontal, 22)
                        if viewStore.hasReadWorkerId {
                            Spacer().frame(height: 20)
                            Text("WorkerIdを読みました")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .background(PrimaryColor.buttonLightGray)
                        }
                        if viewStore.hasReadDeviceId {
                            Spacer().frame(height: 20)
                            Text("端末IDを読みました")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .background(PrimaryColor.buttonLightGray)
                        }
                        Spacer()
                        Button(action: {
                            goBackAction()
                        }, label: {
                            Text("閉じる")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, minHeight: 92)
                                .background(PrimaryColor.buttonRed)
                                .cornerRadius(20)
                                .padding(.horizontal, 22)
                        })
                        Spacer().frame(height: 30)
                    }
                    .padding(.vertical, 20)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct OwnerScanQrCodeView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerScanQrCodeView(
            store: Store(
                initialState: OwnerQrScanState(),
                reducer: ownerQrScanReducer,
                environment: OwnerQrScanEnvironment()
            ),
            goBackAction: {}
        )
    }
}
