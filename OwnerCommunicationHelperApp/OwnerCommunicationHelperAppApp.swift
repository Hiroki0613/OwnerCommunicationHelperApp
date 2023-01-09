//
//  OwnerCommunicationHelperAppApp.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import SwiftUI

@main
struct OwnerCommunicationHelperAppApp: App {
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
             　1. FirebaseUIを実装 ( AuthTestView()を参考に )
             　　→ 場合によっては、通常のログイン画面でも良さそう。
             　2. ログインをしているかをチェック
             　　→ Auth.auth().addStateDidChangeListener
             　3. ログイン画面しているかどうかで画面の切り替え
             　　https://www.youtube.com/watch?v=hwbHQf1Mvxk
             　4. QRリーダーを実装
             　5. QR作成を実装
             　6. 気圧計を実装
             　7. チャット機能を実装(Ownerは選べる)
             　8. ListViewでスタッフ、作業者のUIを実装
             　9. 通知機能を実装
             　10. 決済機能を実装
             */
            OwnerTopView()
        }
    }
}
