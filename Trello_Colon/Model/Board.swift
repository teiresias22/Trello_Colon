//
//  Board.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/15.
//

import Foundation

class Board: ObservableObject, Identifiable {
    
    private(set) var id = UUID()
    
    @Published var name: String
    @Published var lists: [BoardList]
    
    init(name: String, lists: [BoardList] = []) {
        self.name = name
        self.lists = lists
    }
}
