//
//  HomeViewController.swift
//  U-watch
//
//  Created by 손동현 on 10/9/24.
//

import UIKit
import DGCharts

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var customUrl: UILabel!
    @IBOutlet weak var subscriberBox: UIView!
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var videoBox: UIView!
    @IBOutlet weak var likeBox: UIView!
    @IBOutlet weak var subscriberCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var wordCloud: UIImageView!
    @IBOutlet weak var radarChart: RadarChartView!
    @IBOutlet weak var subscriberTableView: UITableView!

    // MARK: - Data Source
    let dataProvider = ChannelService.shared // 서버 연결을 위한 싱글톤 인스턴스 사용

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // 테이블 뷰 설정
        subscriberTableView.delegate = self
        subscriberTableView.dataSource = self
        // 박스 스타일 설정
//        subscriberBox.layer.cornerRadius = 10 // 둥근 모서리
//        subscriberBox.backgroundColor = UIColor.systemBlue //  배경
        subscriberBox.layer.borderWidth = 1.0
        subscriberBox.layer.borderColor = UIColor.systemGray5.cgColor
        
        videoBox.layer.borderWidth = 1.0
        videoBox.layer.borderColor = UIColor.systemGray5.cgColor
        
        viewBox.layer.borderWidth = 1.0
        viewBox.layer.borderColor = UIColor.systemGray5.cgColor
        
        likeBox.layer.borderWidth = 1.0
        likeBox.layer.borderColor = UIColor.systemGray5.cgColor
        
        thumbnail.layer.shadowColor = UIColor.black.cgColor // Shadow color
        thumbnail.layer.shadowOpacity = 0.7                // Shadow opacity (0 to 1)
        thumbnail.layer.shadowOffset = CGSize(width: 5, height: 5) // Shadow position
        thumbnail.layer.shadowRadius = 69
//
//        viewBox.layer.cornerRadius = 10 // 둥근 모서리
//        viewBox.backgroundColor = UIColor.systemBlue //  배경
//
//        videoBox.layer.cornerRadius = 10 // 둥근 모서리
//        videoBox.backgroundColor = UIColor.systemBlue //  배경
//
//        likeBox.layer.cornerRadius = 10 // 둥근 모서리
//        likeBox.backgroundColor = UIColor.systemBlue //  배경


        // 데이터 로드
        fetchData()
    }

    // MARK: - Fetch Data from Server
    private func fetchData() {
        Task {
            do {
                //print("Starting data fetch...")

                // Step 1: 채널 상세 정보 가져오기
                //print("Fetching channel details...")
                try await dataProvider.fetchChannelDetails(forChannelId: "UCsJ6RuBiTVWRX156FVbeaGg")
                if let details = dataProvider.channelDetails {
                    print("Channel Details: \(details)")
                }

                // Step 2: 감정 분석 데이터 가져오기
                //print("Fetching sentiment analysis...")
                try await dataProvider.fetchSentimentAnalysis(forChannelId: "UCsJ6RuBiTVWRX156FVbeaGg")
                if let sentiment = dataProvider.sentimentData {
                    print("Sentiment Data: \(sentiment)")
                }

                // Step 3: 열혈 구독자 정보 가져오기
                //print("Fetching super fans...")
                try await dataProvider.fetchSuperFans(forChannelId: "UCsJ6RuBiTVWRX156FVbeaGg")
                if !dataProvider.superFans.isEmpty {
                    //print("Super Fans: \(dataProvider.superFans)")
                }

                // UI 업데이트
                DispatchQueue.main.async {
                    //print("Updating UI...")
                    self.updateUI()
                    self.setupRadarChart()
                }
            } catch {
                //print("Failed to fetch data: \(error.localizedDescription)")
                //print("Error Details: \(error)") // 디버깅용으로 에러 전체 출력
            }
        }
    }

    // MARK: - Update UI
    private func updateUI() {
        guard let channelDetails = dataProvider.channelDetails else {
            //print("No channel details available to update UI.")
            return
        }

        // 채널 썸네일 업데이트
        if let url = URL(string: channelDetails.thumbnail) {
            //print("Loading channel thumbnail from: \(url)")
            loadImage(from: url, into: thumbnail)
        }

        // 채널 정보 업데이트
        channelName.text = channelDetails.channelName
        customUrl.text = channelDetails.customUrl
        subscriberCount.text = "\(formatWithSuffix(channelDetails.subscriberCount))"
        viewCount.text = "\(formatWithSuffix(channelDetails.viewCount))"
        videoCount.text = "\(formatWithSuffix(channelDetails.videoCount))"
        likeCount.text = "\(formatWithSuffix(channelDetails.likeCount))"

        // 워드클라우드 업데이트
        if let wordCloudURL = URL(string: channelDetails.wordcloud) {
            //print("Loading word cloud from: \(wordCloudURL)")
            loadImage(from: wordCloudURL, into: wordCloud)
        }

        // 테이블 뷰 갱신
        subscriberTableView.reloadData()
    }

    private func setupRadarChart() {
        guard let sentimentData = dataProvider.sentimentData else {
            //print("No sentiment data available to setup radar chart.")
            return
        }

        //print("Setting up radar chart with sentiment data: \(sentimentData)")

        radarChart.chartDescription.enabled = false
        radarChart.webLineWidth = 1.0
        radarChart.innerWebLineWidth = 1.0
        radarChart.webColor = .lightGray
        radarChart.innerWebColor = .lightGray
        radarChart.rotationEnabled = true
        radarChart.highlightPerTapEnabled = false

        // 데이터의 최대값 계산
        let values = [
            sentimentData.joy,
            sentimentData.anger,
            sentimentData.sadness,
            sentimentData.surprise,
            sentimentData.fear,
            sentimentData.disgust
        ]
        let maxValue = values.max() ?? 100

        // Y축 범위 설정: 데이터의 최대값으로 설정
        radarChart.yAxis.axisMinimum = 0
        radarChart.yAxis.axisMaximum = maxValue
        radarChart.yAxis.labelCount = 3 // 단계 간격 조정
        radarChart.yAxis.drawLabelsEnabled = false


        // X축 (꼭지점 레이블) 설정
        radarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Joy", "Anger", "Sadness", "Surprise", "Fear", "Disgust"])
        radarChart.xAxis.labelFont = .systemFont(ofSize: 14, weight: .bold)
        radarChart.xAxis.labelTextColor = .black
        radarChart.xAxis.labelPosition = .bottom

        // 데이터 입력
        let entries = [
            RadarChartDataEntry(value: Double(sentimentData.joy)),
            RadarChartDataEntry(value: Double(sentimentData.anger)),
            RadarChartDataEntry(value: Double(sentimentData.sadness)),
            RadarChartDataEntry(value: Double(sentimentData.surprise)),
            RadarChartDataEntry(value: Double(sentimentData.fear)),
            RadarChartDataEntry(value: Double(sentimentData.disgust))
        ]

        // 데이터셋 스타일 설정
        let dataSet = RadarChartDataSet(entries: entries, label: "감정 분석")
        dataSet.colors = [.systemBlue]
        dataSet.fillColor = .systemBlue
        dataSet.drawFilledEnabled = true
        dataSet.lineWidth = 2.0
        dataSet.valueFont = .systemFont(ofSize: 12)
        dataSet.drawValuesEnabled = false // 데이터 값 숨기기
        dataSet.valueTextColor = .black

        // 데이터 설정 및 업데이트
        radarChart.data = RadarChartData(dataSets: [dataSet])
        radarChart.notifyDataSetChanged()
        radarChart.yAxis.resetCustomAxisMax()
    }



    // MARK: - Load Image Helper
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                //print("Invalid image data for URL: \(url)")
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.superFans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriberCell", for: indexPath) as? TestCell else {
            return UITableViewCell()
        }

        let superFan = dataProvider.superFans[indexPath.row]
        cell.authorName.text = superFan.authorName + getGradeIcon(grade: indexPath.row + 1)
        cell.commentCount.text = "댓글 수: \(superFan.commentCount)"
        if let url = URL(string: superFan.authorProfileImageUrl) {
            loadImage(from: url, into: cell.authorProfileImageUrl)
        }
        return cell
    }

    // MARK: - number format
    private func formatWithSuffix(_ number: Int) -> String {
        let thousand = 1_000
        let million = 1_000_000
        let billion = 1_000_000_000

        if number >= billion {
            let value = Double(number) / Double(billion)
            return String(format: "%.1fB", value) // 10억 단위
        } else if number >= million {
            let value = Double(number) / Double(million)
            return String(format: "%.1fM", value) // 백만 단위
        } else if number >= thousand {
            let value = Double(number) / Double(thousand)
            return String(format: "%.1fK", value) // 천 단위
        } else {
            return "\(number)" // 천 단위 미만
        }
    }

    private func getGradeIcon(grade: Int) -> String {
        switch grade {
        case 1: "🥇"
        case 2: "🥈"
        case 3: "🥉"
        default: ""
        }
    }
}
