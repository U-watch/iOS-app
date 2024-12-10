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

        // 버튼 액션 추가
        startAnalysisButton.addTarget(self, action: #selector(didTapStartAnalysisButton), for: .touchUpInside)
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
        Task {
            do {
                // Step 1: ChannelInfo 정보 가져오기
                try await ChannelService.shared.fetchChannelInfo(forMemberId: 1)
                if let channelInfo = ChannelService.shared.channelInfo {
                    //print("Fetched Channel Info: \(channelInfo)")
                }

                // Step 2: Channel ID 확인
                guard let channelId = ChannelService.shared.channelInfo?.channelId else {
                    //print("Channel ID not found")
                    return
                }
                //print("Fetched Channel ID: \(channelId)")

                // Step 3: ChannelDetails 정보 가져오기
                try await ChannelService.shared.fetchChannelDetails(forChannelId: channelId)
                if let channelDetails = ChannelService.shared.channelDetails {
                    //print("Fetched Channel Details: \(channelDetails)")
                }

                // Step 4: 데이터 가져오기에 성공하면 UI 업데이트
                if let channelInfo = ChannelService.shared.channelInfo,
                   let channelDetails = ChannelService.shared.channelDetails {
                    DispatchQueue.main.async {
                        self.updateUI(with: channelInfo, and: channelDetails)
                    }
                }
            } catch {
                //print("Failed to fetch channel info: \(error.localizedDescription)")
            }
        }
    }


    private func updateUI(with channelInfo: OnBoardData, and channelDetails: ChannelData) {
        //print("Updating UI with Channel Info: \(channelInfo)")
        //print("Updating UI with Channel Details: \(channelDetails)")

        // Welcome Label 업데이트
        welcomeLabel.text = "어서오세요, \(channelInfo.channelName)님!"

        // Custom URL 업데이트
        channelIdLabel.text = "\(channelDetails.customUrl)"

        // Profile Image 업데이트
        if let url = URL(string: channelInfo.thumbnail) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                if let error = error {
                    //print("Failed to load image: \(error.localizedDescription)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    //print("Invalid image data")
                    return
                }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }.resume()
        } else {
            //print("Invalid thumbnail URL")
        }
    }





    // MARK: - Actions
    @objc private func didTapStartAnalysisButton() {
        // Home.storyboard를 로드
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        // MainTabBarController 인스턴스화
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else {
            print("Tab Bar Controller not found")
            return
        }

        // 화면 전환
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}
