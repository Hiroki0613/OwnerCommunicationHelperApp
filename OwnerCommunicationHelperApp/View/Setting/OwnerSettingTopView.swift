//
//  OwnerSettingTopView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import ComposableArchitecture
import FirebaseAuthUI
import SwiftUI

struct OwnerSettingTopView: View {
    let pushNotificationSender = PushNotificationSender()
    @StateObject var workerSettingManager = WorkerSettingManager()
    @StateObject var ownerSettingManager = OwnerSettingManager()
    let store: Store<OwnerSettingTopState, OwnerSettingTopAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    PrimaryColor.backgroundGreen
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            Spacer().frame(height: 20)
                            Button(
                                action: {
                                    viewStore.send(.gotoDatePickerView(true))
                                },
                                label: {
                                    // TODO: 可能な限り通信を減らすために、更新しない限りは端末保存したデータで表示する。
                                    OwnerSettingOperatingTimeView(startTime: Date(timeIntervalSince1970: ownerSettingManager.owner.startWorkTime), endTime: Date(timeIntervalSince1970: ownerSettingManager.owner.endWorkTime))
                                        .cornerRadius(20)
                                }
                            )
                            Spacer().frame(height: 30)
                            OwnerSettingPressureView(viewStore: viewStore)
                                .cornerRadius(20)
                            Spacer().frame(height: 30)
                            // TODO: 残り人数はFirebaseと連携させておく。Workerの数を読み出してカウントに入れるようにする。
                            // TODO: 課金方法については、後から検討する。ここで可能参加人数を変更できるようにする。
                            OwnerSettingSubscriptionView(numberOfPeopleCanRegister: ownerSettingManager.owner.numberOfPeopleCanRegister)
                                .cornerRadius(20)
                            Spacer().frame(height: 30)
                            NavigationLink(
                                destination: {
                                    OwnerChatTalkListView()
                                },
                                label: {
                                    Text("チャット")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, minHeight: 91)
                                        .background(PrimaryColor.buttonRed)
                                        .cornerRadius(20)
                                }
                            )
                            Spacer().frame(height: 30)
                            Group {
                                Button(
                                    action: {
                                        // TODO: コマンド一つでpush通知が送れるように実装すること
                                        /*
                                         
                                         push通知をJSON形式でfirestoreに保存しておくことで、まとめて通知を送ることも可能かも。あるいは、プロフィールはJSON形式にすることが良いかも。
                                         更新頻度は考えた方が良いかも。
                                         1. チャットメッセージが送られたときにpush通知を送信
                                         2. tokenの構造はどうするかを考える。stringを繋ぎ合わせる？
                                         3. push通知が正確に送られているかは、複数端末で確認する。
                                         */
                                        pushNotificationSender.sendPushNotification(
                                            to: "dSSkiXY4qEbJlwFtb6qm38:APA91bFV_tB_c3ie6wjMaix8-yfkIq_lsJ_Y-KmrVgHmyQSaIxUlwQdH_HPZ-7jKkz-YHOIO19CQTZmH4pL3h1_tSU1hySGs4xU9EiZjC67_KOON74z-LCQbBN55VIxhN8JD9WlWEXsu",
                                            userId: "\(UUID())",
                                            title: "アプリ通信",
                                            body: "iPadから") {
                                                print("hirohiro_fcm完了だべ")
                                            }
                                        // TODO: Worker,Staff,Deviceの追加を分岐させること。
//                                        viewStore.send(.gotoRegisterWorkerView(true))
//                                        viewStore.send(.gotoQrCodeReadView(true))
                                        guard let _ = Auth.auth().currentUser?.uid else { return }
                                        viewStore.send(.gotoSelectRegisterView(true))
                                    }, label: {
                                        // TODO: Deviceを追加
                                        /*
                                         OwnerIDのQRコード + FCMTokenをWorker端末で読み取らせる。読み込んだ後に、FirestoreのaddSnapshotListenerを使ってWorker端末で、AuthIDをDeviceIDとして書き込む。さらに、TeminalIDへFCMTokenの情報を入れるとベター。 この２つがFirestoreへ書き込めた段階で、UserDefaultsにOwnerIDを書き込む。この間は初期セットアップ画面にしておくこと。
                                         (FCMTokenについては、理想論はCloudFunctionを通して取得するのがベスト。今回はFCMTokenは入れないようにする)
                                         Owner端末は表示している。QRコード画面を書き込みが成功したら閉じるようにする。
                                         
                                         なお、Worker端末でセットアップ画面に戻すことは出来ないようにする。
                                         1. Deviceの追加画面を用意
                                         2. OwnerのAuthIDを画面表示
                                         2. Worker端末で読ませる。読ませたら。DeviceIDとして、AuthをFirestoreに書き込む。
                                         3.
                                         Owner端末はAddSnapshotListenerを通して、登録が完了していることを確認する。読み込みが成功したら、(ダイアログを表示して)前の画面に戻る。
                                         4. Worker端末は、UserDefaultsにOwnerIDが書き込まれたら、画面が朝礼画面になるようにする。
                                         5. Worker端末は朝礼画面になったら、DeviceIDをQRコードで表示するようにセットする。
                                         */
                                        // TODO: QRコードを自体は将来的にハッシュ関数を記録するようにして、セキュリティを高めること。
                                        Text("Worker,Staff,Deviceの追加")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                                Spacer().frame(height: 30)
                                Button(
                                    action: {
                                        viewStore.send(.gotoQrCodeScanView(true))
                                    }, label: {
                                        Text("QRコードスキャン")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                                Spacer().frame(height: 30)
                                Button(
                                    action: {
                                        do {
                                            try Auth.auth().signOut()
                                        } catch {
                                            print("error")
                                        }
                                    }, label: {
                                        Text("ログアウト")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, minHeight: 91)
                                            .background(PrimaryColor.buttonRed)
                                            .cornerRadius(20)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 30)
                        Spacer().frame(height: 30)
                    }
                    .clipped()
                    .fullScreenCover(
                        isPresented:
                            viewStore.binding(
                                get: \.hasShowedSelectRegisterView,
                                send: OwnerSettingTopAction.gotoSelectRegisterView
                            )
                    ) {
                        OwnerSelectRegisterView(store: store)
                    }
                    .fullScreenCover(
                        isPresented: viewStore.binding(
                            get: \.hasShowedDatePickerView,
                            send: OwnerSettingTopAction.gotoDatePickerView
                        )
                    ) {
                        DatePickerView(
                            viewStore: viewStore,
                            startDate: Date(timeIntervalSince1970: ownerSettingManager.owner.startWorkTime),
                            endDate: Date(timeIntervalSince1970: ownerSettingManager.owner.endWorkTime)
                        )
                    }
                    .fullScreenCover(
                        isPresented: viewStore.binding(
                            get: \.hasShowedQrCodeScanView,
                            send: OwnerSettingTopAction.gotoQrCodeScanView
                            )
                        ) {
                            OwnerScanQrCodeView(
                                store: store.scope(
                                    state: \.ownerQrScanState,
                                    action: OwnerSettingTopAction.ownerQrScanAction
                                ),
                                goBackAction: {
                                    viewStore.send(.gotoQrCodeScanView(false))
                                }
                            )
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
            .onAppear {
                ownerSettingManager.getOwnerData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if ownerSettingManager.owner.id.isEmpty {
                        ownerSettingManager.setOwnerData()
                    }
                }
            }
        }
    }
}

struct OwnerSettingTopView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerSettingTopView(
            store: Store(
                initialState: OwnerSettingTopState(
                    pressureString: "",
                    hasShowedQrCodeScanView: true
                ),
                reducer: ownerSettingTopReducer,
                environment: OwnerSettingTopEnvironment()
            )
        )
    }
}
