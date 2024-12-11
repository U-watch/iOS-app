//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class EmotionViewController: CommonCommentViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var emotionSegmentControl: UISegmentedControl!
    
    let options = ["즐거움", "슬픔", "놀람", "화남", "두려움", "역겨움"]
    var selectedOption: String?
    
    override func viewDidLoad() {
        emotion = CommentEmotion.joy
        
        emotionSegmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        super.viewDidLoad()
    }
    
    override func handleWrongClassification() {
        let alert = UIAlertController(title: "바꿀 분류를 선택하세요.", message: nil, preferredStyle: .alert)
        
        let vc = CorrectionViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.pickerView.delegate = self
        vc.pickerView.dataSource = self
        
        if let sheet = navVC.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                0.2 * context.maximumDetentValue
            }), .large()]
        }
        // Add actions
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("Selected option: \(self.selectedOption ?? "None")")
        }))
        
        navigationController?.present(navVC, animated: true)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.emotion = CommentEmotion.joy
        case 1:
            self.emotion = CommentEmotion.anger
        case 2:
            self.emotion = CommentEmotion.sadness
        case 3:
            self.emotion = CommentEmotion.suprise
        case 4:
            self.emotion = CommentEmotion.fear
        case 5:
            self.emotion = CommentEmotion.disgust
        default:
            print("Invalid value")
        }
        
        fetchInitialData()
        startLoading()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[row]
    }
}
