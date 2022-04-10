//
//  CustomShadowView.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 8.04.22.
//

import UIKit

class CustomShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
