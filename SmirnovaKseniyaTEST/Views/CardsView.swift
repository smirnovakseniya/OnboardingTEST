//
//  CardsView.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 7.04.22.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    //MARK: - Variables
    
    private lazy var shadowView: CustomShadowView! = {
        let view = CustomShadowView()
        return view
    }()
    
    private lazy var swipeView: CustomView = {
        let view = CustomView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iview = UIImageView()
        iview.contentMode = .scaleAspectFit
        iview.translatesAutoresizingMaskIntoConstraints = false
        return iview
    }()
    
    private lazy var mainLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var lowerLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .lightGray.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var dataSource: CardsDataModel? {
        didSet {
            mainLabel.text = dataSource?.mainText
            lowerLabel.text = dataSource?.lowerText
            guard let image = dataSource?.image else { return }
            imageView.image = UIImage(named: image)
        }
    }
    
    weak var delegate: CardsDelegate?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(shadowView)
        shadowView.addSubview(swipeView)
        shadowView.addSubview(imageView)
        shadowView.addSubview(mainLabel)
        shadowView.addSubview(lowerLabel)
        
        setUpConstraintsFunction()
        
        addPanGestureOnCards()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NextTapped"), object: nil)
    }
    
    //MARK: - Constraints
    
    private func setUpConstraintsFunction() {
        shadowView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        swipeView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(180)
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
        
        lowerLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Functions
    
    private func addPanGestureOnCards() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    @objc func handleTapGesture() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { _ in
            self.delegate?.swipeDidEnd(on: self)
        }
    }
    
    func handleCardUp() {
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.center = CGPoint(x: centerOfParentContainer.x, y: centerOfParentContainer.y - 300)
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { _ in
            self.delegate?.swipeDidEnd(on: self)
        }
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
        switch sender.state {
        case .ended:
            if self.center.x > 200 {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.center = CGPoint(x: centerOfParentContainer.x + 400,
                                          y: centerOfParentContainer.y - 75)
                    self.alpha = 0
                    self.layoutIfNeeded()
                } completion: { _ in
                    self.delegate?.swipeDidEnd(on: self)
                }
                return
            } else if self.center.x < 60 {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                    self.center = CGPoint(x: centerOfParentContainer.x - 400,
                                          y: centerOfParentContainer.y - 75)
                    self.alpha = 0
                    self.layoutIfNeeded()
                } completion: { _ in
                    self.delegate?.swipeDidEnd(on: self)
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
                self.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            self.transform = CGAffineTransform(rotationAngle: rotation)
        default:
            break
        }
    }
}
