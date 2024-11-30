//
//  ViewController.swift
//  U-watch
//
//  Created by 손동현 on 10/9/24.
//

import UIKit
import DGCharts


class HomeViewController: UIViewController {







    // 스크롤뷰와 콘텐츠 뷰 선언
    private let scrollView = UIScrollView()
    private let contentView = UIStackView() // 콘텐츠를 담을 StackView

    override func viewDidLoad() {
        super.viewDidLoad()




        // 스크롤뷰와 콘텐츠 설정
        setupScrollView()
        setupContent()
    }

    private func setupScrollView() {
        // 스크롤뷰와 콘텐츠 뷰의 기본 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical // 세로로 쌓기
        contentView.spacing = 16 // 섹션 간 간격 설정

        // 스크롤뷰를 메인 뷰에 추가
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // 스크롤뷰와 콘텐츠 뷰의 Auto Layout 설정
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func setupContent() {
        // 샘플 콘텐츠 추가
        let section1 = createSection(title: "채널 정보 섹션")
        let section2 = createSection(title: "댓글 분석 섹션")
        let section3 = createSection(title: "워드 클라우드 섹션")
        let section4 = createSection(title: "감정 분석 섹션")
        let section5 = createSection(title: "열혈 구독자 섹션")

        // 콘텐츠 뷰(StackView)에 섹션 추가
        contentView.addArrangedSubview(section1)
        contentView.addArrangedSubview(section2)
        contentView.addArrangedSubview(section3)
        contentView.addArrangedSubview(section4)
        contentView.addArrangedSubview(section5)
    }

    private func createSection(title: String) -> UIView {
        // 섹션(UIView) 생성
        let section = UIView()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.heightAnchor.constraint(equalToConstant: 200).isActive = true
        section.backgroundColor = .lightGray // 임시 배경색 (필요에 따라 변경)

        // 섹션 내부에 Label 추가
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false

        section.addSubview(label)

        // Label의 Auto Layout 설정
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: section.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: section.centerYAnchor)
        ])

        return section
    }
}
