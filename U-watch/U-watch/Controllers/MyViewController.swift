import UIKit

class MyViewController: UIViewController {
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let channelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "채널명"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = "역할"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "v1.0.1"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchUserData() // API 호출 및 데이터 반영
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white

        // 상단 섹션
        view.addSubview(profileImageView)
        view.addSubview(channelTitleLabel)
        view.addSubview(roleLabel)

        // 기본 정보 섹션
        let emailRow = createInfoRow(title: "이메일", value: "")
        infoStackView.addArrangedSubview(emailRow)
        view.addSubview(infoStackView)

        // 하단 버튼 섹션
        let passwordButton = createMenuButton(title: "비밀번호 변경하기")
        let termsButton = createMenuButton(title: "이용약관 확인하기")
        let deleteAccountButton = createMenuButton(title: "회원 탈퇴하기")
        let logoutButton = createMenuButton(title: "로그아웃")
        buttonsStackView.addArrangedSubview(passwordButton)
        buttonsStackView.addArrangedSubview(termsButton)
        buttonsStackView.addArrangedSubview(deleteAccountButton)
        buttonsStackView.addArrangedSubview(logoutButton)
        view.addSubview(buttonsStackView)

        // 버전 정보 섹션
        view.addSubview(versionLabel)

        setupConstraints()
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            channelTitleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            channelTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            roleLabel.topAnchor.constraint(equalTo: channelTitleLabel.bottomAnchor, constant: 4),
            roleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roleLabel.widthAnchor.constraint(equalToConstant: 100),
            roleLabel.heightAnchor.constraint(equalToConstant: 24),

            infoStackView.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 20),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            buttonsStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func createInfoRow(title: String, value: String) -> UIView {
        let container = UIView()

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = .darkGray
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(titleLabel)
        container.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: container.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    private func createMenuButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .leading
        return button
    }

    // MARK: - Fetch User Data (API 연결)
    private func fetchUserData() {
        let exampleEmail = "example@gmail.com" // 예시 데이터

        // 이메일 업데이트
        if let emailRow = infoStackView.arrangedSubviews.first(where: { ($0 as? UIView)?.subviews.first(where: { ($0 as? UILabel)?.text == "이메일" }) != nil }) as? UIView {
            if let valueLabel = emailRow.subviews.last as? UILabel {
                valueLabel.text = exampleEmail
            }
        }

        // 기타 데이터 업데이트
        profileImageView.image = UIImage(named: "placeholder")
        channelTitleLabel.text = "침착맨"
        roleLabel.text = "크리에이터"
    }
}
