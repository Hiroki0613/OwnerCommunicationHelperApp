//
//  OwnerCommunicationHelperAppApp.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import Firebase
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // TODO: ここでPush通知のコードを書くこと。
        return true
    }
}

@main
struct OwnerCommunicationHelperAppApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            // TODO: 画面には出さないが、端末管理は無制限に登録させる。作業者のみを課金制にする。
            /*
             ・端末追加はworker側がQRコードを読み込んで保存。
             ・UserDefaultsに情報を保存して、朝礼時にその端末QRコードを表示するようにする。
             ・WorkerQRコードはOwner側で生成して、画像 or PDFで読み出しをできるようにする。それを朝礼時に読み込み
             ・Firebaseのログイン有無はKeyChainが関わってくるので慎重に行うこと。対策をせずに、迂闊にアプリを消すとクラッシュの原因になる。
             ・チャットはOwnerのUUID直下に置くようにする。チャットルームは、独立させる。ただし、Workerとは紐付けをしておいて該当のチャットルームを出すようにする。
             ・出勤、不在が一目でわかるようにすると良さそう。
             ・オーナー側の作業者の削除機能はどうする？名前を変えて、そのまま使い続けるのも構わない。
             ・やるべきことリスト
             　1. チャット機能を実装(Ownerは選べる)
             　2. ListViewでスタッフ、作業者のUIを実装
             　3. 通知機能を実装
             　4. 決済機能を実装
             */
            OwnerTopView(
                store: Store(
                    initialState: OwnerTopState(
                        settingTopState: OwnerSettingTopState()
                    ),
                    reducer: topReducer,
                    environment: OwnerTopEnvironment()
                )
            )
        }
    }
}
