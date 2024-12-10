import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var LogoImage: UIImageView!

    @IBOutlet weak var projectName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 로고 이미지 설정
        setupCircularLogo()
        LogoImage.image = UIImage(named: "logo")
    }


    // MARK: - Setup Circular Logo
    private func setupCircularLogo() {
        // UIImageView를 원형으로 만들기
        LogoImage.layer.cornerRadius = LogoImage.frame.size.width / 2
        LogoImage.clipsToBounds = true
        LogoImage.contentMode = .scaleAspectFill
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
                //print("Error during sign in: \(String(describing: error?.localizedDescription))")
                return
            }

            // 로그인 성공 시 사용자 정보를 가져오기
            guard let user = signInResult?.user else { return }

            // Access Token 출력
            let accessToken = user.accessToken.tokenString // Optional chaining 제거
            //print("Access Token: \(accessToken)")


            // Refresh Token 출력
            let refreshToken = user.refreshToken.tokenString // Optional chaining 제거
            //print("Refresh Token: \(refreshToken)")

            // Authorization Code 출력
            let authorizationCode = user.idToken?.tokenString // idToken은 Optional이므로 ? 유지
            if let authorizationCode = authorizationCode {
                //print("Authorization Code: \(authorizationCode)")
            } else {
                //print("No authorization code received.")
            }

            print("Sign in successful")

            // 화면 전환 (Segue 호출)
            self.performSegue(withIdentifier: "toOnBoard", sender: nil)
        }

    }
}
