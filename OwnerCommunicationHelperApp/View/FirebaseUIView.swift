//
//  FirebaseUIView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/09.
//

import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import SwiftUI

struct FirebaseUIView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /*
     アニノマスログインは、ログアウトするたびに新しいアカウントになってしまうので注意。
     */
    // signInApple
    // https://ios-docs.dev/guideline4-8/
    // https://www.amefure.com/tech/swift-firebase-authentication-apple
    // https://i-app-tec.com/ios/apply-application.html
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()!
        let providers: [FUIAuthProvider] = [
            FUIOAuth.appleAuthProvider()
        ]
        authUI.providers = providers
        authUI.delegate = context.coordinator
        return authUI.authViewController()
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }

    class Coordinator: NSObject, FUIAuthDelegate {
        let parent: FirebaseUIView
        init(_ parent: FirebaseUIView) {
            self.parent = parent
        }
    }
}

class FirebaseAuthStateObserver: ObservableObject {
    @Published var isSignin: Bool = false
    private var listener: AuthStateDidChangeListenerHandle!

    init() {
        listener = Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = user {
                self.isSignin = true
            } else {
                self.isSignin = false
            }
        }
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(listener)
    }
}
