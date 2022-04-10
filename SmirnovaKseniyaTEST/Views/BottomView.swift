//
//  BottomView.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 7.04.22.
//

import UIKit

class BottomView: UIView {
    
    //MARK: - Variables
    
    private lazy var shadowBottomView: CustomShadowView = {
        let view = CustomShadowView()
        return view
    }()
    
    lazy var bottomView: CustomView = {
        let view = CustomView()
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(NSLocalizedString("nextButton", comment: "").uppercased(), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var skipButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(NSLocalizedString("skipButton", comment: "").uppercased(), for: .normal)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    weak var delegate: CardsDataSource?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(shadowBottomView)
        shadowBottomView.addSubview(bottomView)
        shadowBottomView.addSubview(nextButton)
        shadowBottomView.addSubview(skipButton)
        setUpConstraintsFunction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func addGradient() {
        gradientLayer.frame = bottomView.bounds
        gradientLayer.colors = [UIColor.orange.withAlphaComponent(1).cgColor, UIColor.orange.withAlphaComponent(0.7).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        bottomView.layer.insertSublayer(gradientLayer, at: 0)
        
        nextButton.setTitle(NSLocalizedString("nextButton", comment: "").uppercased(), for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        bottomView.isHidden = false
        skipButton.isHidden = false
        skipButton.setTitleColor(.white, for: .normal)
    }
    
    func emptyScreen(title: String) {
        nextButton.setTitle(title, for: .normal)
        nextButton.setTitleColor(.orange, for: .normal)
        gradientLayer.removeFromSuperlayer()
        skipButton.setTitleColor(UIColor.lightGray.withAlphaComponent(0.6), for: .normal)
    }
    
    //MARK: - Actions
    
    @objc func nextButtonTapped() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        delegate?.tapNext()
    }
    
    @objc func skipButtonTapped() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        delegate?.tapSkip()
        bottomView.isHidden = true
    }
    
    //MARK: - Configuration
    
    private func setUpConstraintsFunction() {
        shadowBottomView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
        
        skipButton.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
    }
}
