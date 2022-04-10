//
//  CustomLabel.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 8.04.22.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textAlignment = .center
        numberOfLines = 0
        font = .systemFont(ofSize: 18, weight: .thin)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
