//
//  BoardList.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/15.
//

import Foundation

class BoardList: ObservableObject, Identifiable {
    
    private(set) var id = UUID()
    var boardID: UUID
    
    @Published var name: String
    @Published var cards: [Card]
    
    init(name: String, cards: [Card] = [], boardID: UUID) {
        self.name = name
        self.cards = cards
        self.boardID = boardID
    }
}
