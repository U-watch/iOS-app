import UIKit
import DGCharts

class LiveViewController: UIViewController {
    
    var enabled: Bool = true
    var result: LiveResult? {
        didSet {
            updateUI()
        }
    }
    
    private var entries = [ChartDataEntry]()
    private var date = Date()
    
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
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "영상을 실시간으로 분석중이에요."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trendLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 추이"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let increasePrefixLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 1시간"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let increaseSuffixLabel: UILabel = {
        let label = UILabel()
        label.text = "+0%"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .green
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trendView: LineChartView = {
        let chart = LineChartView()
        chart.xAxis.valueFormatter = DateAxisValueFormatter()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    private let wordCloudLabel: UILabel = {
        let label = UILabel()
        label.text = "워드 클라우드"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wordCloudView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wc0")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let radarChartLabal: UILabel = {
        let label = UILabel()
        label.text = "감정 분석"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let radarChart: RadarChartView = {
        let chart = RadarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.chartDescription.enabled = false
        chart.webLineWidth = 1.0
        chart.innerWebLineWidth = 1.0
        chart.webColor = .lightGray
        chart.innerWebColor = .lightGray
        chart.rotationEnabled = true
        chart.highlightPerTapEnabled = false
        
        // Y축 범위 설정
        chart.yAxis.axisMinimum = 0
        chart.yAxis.axisMaximum = 10
        chart.yAxis.labelCount = 3 // 내부 간격 조정
        chart.yAxis.drawLabelsEnabled = false

        // X축 (꼭지점 레이블) 설정
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Joy", "Anger", "Sadness", "Surprise", "Fear", "Disgust"])
        chart.xAxis.labelFont = .systemFont(ofSize: 14, weight: .bold)
        chart.xAxis.labelTextColor = .black
        chart.xAxis.labelPosition = .bottom
        return chart
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if enabled {
            setupEnabledUI()
            fetchData()
        } else {
            setupDisabledUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        if enabled {
            setupEnabledConstraints()
        } else {
            setupDisabledConstraints()
        }
    }

    // MARK: - Setup UI
    private func setupDisabledUI() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(liveImageView)
        view.addSubview(descriptionLabel)

        setupDisabledConstraints()
    }

    private func setupDisabledConstraints() {
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
    
    private func setupEnabledUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)

        contentView.addSubview(trendLabel)
        contentView.addSubview(increasePrefixLabel)
        contentView.addSubview(increaseSuffixLabel)
        contentView.addSubview(trendView)

        contentView.addSubview(wordCloudLabel)
        contentView.addSubview(wordCloudView)
        
        contentView.addSubview(radarChartLabal)
        contentView.addSubview(radarChart)

        setupEnabledConstraints()
    }
    
    private func setupEnabledConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View Constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Status Label Constraints
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Trend Label Constraints
            trendLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            trendLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Increase Label Constraints
            increasePrefixLabel.topAnchor.constraint(equalTo: trendLabel.bottomAnchor, constant: 16),
            increasePrefixLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            increaseSuffixLabel.topAnchor.constraint(equalTo: trendLabel.bottomAnchor, constant: 16),
            increaseSuffixLabel.leadingAnchor.constraint(equalTo: increasePrefixLabel.trailingAnchor, constant: 8),
            
            // Trend View Constraints
            trendView.topAnchor.constraint(equalTo: increasePrefixLabel.bottomAnchor, constant: 8),
            trendView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trendView.heightAnchor.constraint(equalToConstant: 180),
            trendView.widthAnchor.constraint(equalToConstant: 360),

            // Word Cloud Label Constraints
            wordCloudLabel.topAnchor.constraint(equalTo: trendView.bottomAnchor, constant: 16),
            wordCloudLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            // Word Cloud View Constraints
            wordCloudView.topAnchor.constraint(equalTo: wordCloudLabel.bottomAnchor, constant: 8),
            wordCloudView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            wordCloudView.heightAnchor.constraint(equalToConstant: 180),
            wordCloudView.widthAnchor.constraint(equalToConstant: 360),
            
            // Radar Chart Label Constraints
            radarChartLabal.topAnchor.constraint(equalTo: wordCloudView.bottomAnchor, constant: 32),
            radarChartLabal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            // Word Cloud View Constraints
            radarChart.topAnchor.constraint(equalTo: radarChartLabal.bottomAnchor, constant: 8),
            radarChart.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            radarChart.heightAnchor.constraint(equalToConstant: 360),
            radarChart.widthAnchor.constraint(equalToConstant: 360),
            radarChart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        guard let result = self.result else {
            return
        }
        
        entries.append(ChartDataEntry(x: Double(Date().timeIntervalSince1970), y: Double(result.viewCount)))
        let set = LineChartDataSet(entries: entries, label: "댓글 추이")
        let chartData = LineChartData(dataSet: set)
        trendView.data = chartData
        
        let commentDelta = entries.last!.y - entries.first!.y
        let deltaPercent = (commentDelta / entries.last!.y) * 100
        increaseSuffixLabel.text = "+\(Int(deltaPercent))%"
        
        wordCloudView.image = UIImage(named: result.wordCloudName)
        
        let entries = [
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.joy]!)),
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.anger]!)),
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.sadness]!)),
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.suprise]!)),
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.fear]!)),
            RadarChartDataEntry(value: Double(result.emotionDistribution[CommentEmotion.disgust]!)),
        ]

        let dataSet = RadarChartDataSet(entries: entries, label: "감정 분석")
        dataSet.colors = [.systemBlue]
        dataSet.fillColor = .systemBlue
        dataSet.drawFilledEnabled = true
        dataSet.lineWidth = 2.0
        dataSet.valueFont = .systemFont(ofSize: 12)
        dataSet.drawValuesEnabled = false
        radarChart.data = RadarChartData(dataSets: [dataSet])
        radarChart.yAxis.resetCustomAxisMax()
//        radarChart.notifyDataSetChanged()
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchData() {
        Task {
            let result = try await LiveService.shared.next()
            
            DispatchQueue.main.async {
                self.result = result
            }
            
            fetchData()
        }
    }
}
