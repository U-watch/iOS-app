//
//  CorrectionViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/11/24.
//

import UIKit

class CorrectionViewController: UIViewController {
    
    let pickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let confirmButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(pickerView)
        view.addSubview(confirmButton)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Picker View Constraints
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Confirm Button Constraints
            confirmButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func confirmButtonTapped() {
        // FIXME: This code is not executed!!
        dismiss(animated: true, completion: nil)
    }
}
