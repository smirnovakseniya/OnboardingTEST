//
//  MainVC.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 7.04.22.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    //MARK: - Variables
    
    private var viewModelData = [
        CardsDataModel(mainText: NSLocalizedString("card1_mainText", comment: ""),
                       lowerText: NSLocalizedString("card1_lowerText", comment: ""), image: "Sushi"),
        CardsDataModel(mainText: NSLocalizedString("card2_mainText", comment: ""),
                       lowerText: NSLocalizedString("card2_lowerText", comment: ""), image: "Donut"),
        CardsDataModel(mainText: NSLocalizedString("card3_mainText", comment: ""),
                       lowerText: NSLocalizedString("card3_lowerText", comment: ""), image: "Ice Cream")
    ]
    
    private var cardContainer: CardContainerView!
    private var bottomView: BottomView!
    
    private lazy var resetButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(NSLocalizedString("resetButton", comment: "").uppercased(), for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    
    //MARK: - Init
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(named: "CustomGrayColor")
        
        cardContainer = CardContainerView()
        cardContainer.dataSource = self
        
        bottomView = BottomView()
        bottomView.delegate = self
        
        view.addSubview(bottomView)
        view.addSubview(resetButton)
        view.addSubview(cardContainer)
        
        setUpConstraintsFunction()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardContainer.dataSource = self
        resetButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        bottomView.addGradient()
    }
    
    //MARK: - Actions
    
    @objc func resetButtonTapped() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        cardContainer.reloadData()
        bottomView.addGradient()
        resetButton.isHidden = true
    }
    
    //MARK: - Configurations
    
    private func setUpConstraintsFunction() {
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        cardContainer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.width.equalTo(350)
            make.height.equalTo(430)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(80)
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(cardContainer.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

//MARK: - Extension

extension MainVC: CardsDataSource {
    
    func emptyScreen(visibleCardsCount: Int) {
        bottomView.emptyScreen(title: NSLocalizedString("nextButton", comment: "").uppercased())
        
        switch visibleCardsCount {
        case 1:
            bottomView.emptyScreen(title: NSLocalizedString("closeButton", comment: "").uppercased())
            
        case 0:
            bottomView.emptyScreen(title: "")
            
            resetButton.isHidden = false
            resetButton.setTitleColor(.orange, for: .normal)
            
            bottomView.bottomView.isHidden = true
            bottomView.skipButton.isHidden = true
            
        default:
            break
        }
    }
    
    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> CardView {
        let card = CardView()
        card.dataSource = viewModelData[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    
    func tapNext() {
        cardContainer.visibleCards.last?.handleCardUp()
    }
    
    func tapSkip() {
        cardContainer.visibleCards.forEach { $0.handleTapGesture() }
    }
    
    func swipeDidEnd(on view: CardView) {
        cardContainer.swipeDidEnd(on: view)
    }
}
