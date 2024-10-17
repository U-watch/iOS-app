//
//  ViewController.swift
//  U-watch
//
//  Created by 손동현 on 10/9/24.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Error during sign in: \(String(describing: error?.localizedDescription))")
                return
            }

            // 로그인 성공 시 앱의 메인 콘텐츠를 보여주는 코드 추가
            print("Sign in successful")
        }
    }
}
