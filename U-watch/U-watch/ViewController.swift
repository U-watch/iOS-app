import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signIn(sender: Any) {
        // 요청할 OAuth 범위 설정
        let additionalScopes = [
            "https://www.googleapis.com/auth/youtube",
            "https://www.googleapis.com/auth/youtube.force-ssl"
        ]

        // Sign-In 요청
        GIDSignIn.sharedInstance.signIn(withPresenting: self, hint: nil, additionalScopes: additionalScopes) { signInResult, error in
            guard error == nil else {
                print("Error during sign in: \(String(describing: error?.localizedDescription))")
                return
            }

            // 로그인 성공 시 사용자 정보를 가져오기
            guard let user = signInResult?.user else { return }

            // Access Token 출력
            let accessToken = user.accessToken.tokenString // Optional chaining 제거
            print("Access Token: \(accessToken)")

            // Refresh Token 출력
            let refreshToken = user.refreshToken.tokenString // Optional chaining 제거
            print("Refresh Token: \(refreshToken)")

            // Authorization Code 출력
            let authorizationCode = user.idToken?.tokenString // idToken은 Optional이므로 ? 유지
            if let authorizationCode = authorizationCode {
                print("Authorization Code: \(authorizationCode)")
            } else {
                print("No authorization code received.")
            }

            print("Sign in successful")
        }
    }
}
