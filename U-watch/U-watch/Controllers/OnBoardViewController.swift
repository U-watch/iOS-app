import UIKit

// OnBoardViewController
class OnBoardViewController: UIViewController {

    // MARK: - UI Components
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "어서오세요, 닉네임님!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "본인의 계정이 맞으신가요?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let channelIdLabel: UILabel = {
        let label = UILabel()
        label.text = "@채널ID"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startAnalysisButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("분석 시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData() // 서버 데이터 로드

        // Back 버튼 숨기기
        self.navigationItem.hidesBackButton = true
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(profileImageView)
        view.addSubview(channelIdLabel)
        view.addSubview(startAnalysisButton)
        view.addSubview(logoutButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            profileImageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            channelIdLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            channelIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            startAnalysisButton.topAnchor.constraint(equalTo: channelIdLabel.bottomAnchor, constant: 30),
            startAnalysisButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startAnalysisButton.widthAnchor.constraint(equalToConstant: 200),
            startAnalysisButton.heightAnchor.constraint(equalToConstant: 50),

            logoutButton.topAnchor.constraint(equalTo: startAnalysisButton.bottomAnchor, constant: 10),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Fetch Data (API 연동)
    private func fetchData() {
        let exampleResponse = OnBoardResponse(
            code: "200",
            message: "Success",
            data: ChannelData(
                channelId: "ChimChakMan_Official",
                channelName: "침착맨",
                thumbnail: "https://via.placeholder.com/100"
            )
        )

        updateUI(with: exampleResponse)
    }

    private func updateUI(with response: OnBoardResponse) {
        let channelData = response.data

        // Welcome Label 업데이트
        welcomeLabel.text = "어서오세요, \(channelData.channelName)님!"

        // Channel ID 업데이트
        channelIdLabel.text = "@\(channelData.channelId)"

        // Profile Image 업데이트 (비동기 로드)
        if let url = URL(string: channelData.thumbnail) {
            // URLSession을 사용하여 비동기적으로 이미지 로드
            URLSession.shared.dataTask(with: url) { data, response, error in
                // 에러 처리
                if let error = error {
                    print("Failed to load image: \(error.localizedDescription)")
                    return
                }

                // 데이터 확인
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }

                // 메인 스레드에서 UI 업데이트
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }.resume() // 작업 시작
        }
    }

}
