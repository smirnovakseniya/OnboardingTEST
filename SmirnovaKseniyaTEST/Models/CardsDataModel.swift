//
//  CardsDataModel.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 7.04.22.
//

import UIKit

struct CardsDataModel {
    
    var mainText: String
    var lowerText: String
    var image: String
      
    init(mainText: String, lowerText: String, image: String) {
        self.mainText = mainText
        self.lowerText = lowerText.uppercased()
        self.image = image
    }
}
