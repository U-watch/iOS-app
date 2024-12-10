import UIKit

class LiveViewController: UIViewController {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "라이브 분석"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let liveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LiveImage") // Assets에 있는 이미지 이름
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "지금은 라이브가 진행중이지 않습니다."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(liveImageView)
        view.addSubview(descriptionLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Live Image View Constraints
            liveImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor), // 화면 중앙에 이미지 배치
            liveImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            liveImageView.widthAnchor.constraint(equalToConstant: 200), // 이미지 가로 크기
            liveImageView.heightAnchor.constraint(equalToConstant: 200), // 이미지 세로 크기

            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: liveImageView.bottomAnchor, constant: 20), // 이미지 아래로 여백 추가
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
