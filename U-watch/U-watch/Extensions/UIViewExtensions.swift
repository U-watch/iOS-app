//
//  UIViewExtensions.swift
//  U-watch
//
//  Created by 이승규 on 12/6/24.
//

import UIKit

extension UIView {
    func loadFromXib(ofName name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
