import UIKit

class ChannelInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // 프로필 이미지
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "profile_placeholder") // 이미지 추가 필요
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        // 채널 이름과 계정 정보
        let channelNameLabel = UILabel()
        channelNameLabel.text = "침착맨"
        channelNameLabel.font = UIFont.boldSystemFont(ofSize: 20)

        let accountLabel = UILabel()
        accountLabel.text = "@ChimChakMan_Official"
        accountLabel.font = UIFont.systemFont(ofSize: 14)
        accountLabel.textColor = .gray

        let nameStack = UIStackView(arrangedSubviews: [channelNameLabel, accountLabel])
        nameStack.axis = .vertical
        nameStack.spacing = 4

        // 통계 정보
        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.spacing = 16
        statsStack.distribution = .fillEqually

        let stats = [
            ("구독자 수", "3.2k"),
            ("비디오 수", "100"),
            ("총 조회수", "1M"),
            ("좋아요 수", "500k")
        ]

        for (title, value) in stats {
            let label = UILabel()
            label.text = "\(title)\n\(value)"
            label.numberOfLines = 2
            label.textAlignment = .center
            statsStack.addArrangedSubview(label)
        }

        // 레이아웃 구성
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameStack, statsStack])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
