//
//  Protocols.swift
//  SmirnovaKseniyaTEST
//
//  Created by Ксения Смирнова on 7.04.22.
//

import UIKit

protocol CardsDataSource: AnyObject {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> CardView
    func emptyView() -> UIView?
    func tapNext()
    func tapSkip()
    func emptyScreen(visibleCardsCount: Int)
}

protocol CardsDelegate: AnyObject {
    func swipeDidEnd(on view: CardView)
}
