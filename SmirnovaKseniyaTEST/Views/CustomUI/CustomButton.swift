//
//  CustomButton.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 8.04.22.
//

import UIKit

class CustomButton: UIButton {
    
    weak var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(changeColorButton), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeColorButton() {
        setTitleColor(.white, for: .normal)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.setTitleColor(.white, for: .normal)
            self.timer?.invalidate()
        }
    }
}
