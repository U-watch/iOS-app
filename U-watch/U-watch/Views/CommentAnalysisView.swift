import UIKit

class CommentAnalysisView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.text = "댓글 종합 분석"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let chartPlaceholder = ChartPlaceholderView()
        let wordCloudPlaceholder = WordCloudPlaceholderView()

        let stackView = UIStackView(arrangedSubviews: [titleLabel, chartPlaceholder, wordCloudPlaceholder])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
