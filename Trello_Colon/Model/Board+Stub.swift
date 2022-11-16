//
//  Board+Stub.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/16.
//

import Foundation


extension Board {
    
    static var stub: Board {
        let board = Board(name: "XCA Board 💡💡💡")
        let backlogBoardList = BoardList(name: "Backlog", boardID: board.id)
        let backlogCards = [
            "Cloud Service",
            "Ingestion Engin",
            "Compression Engine",
            "DB Service",
            "Routing Engine",
            "Scheme Design",
            "Web Analytics Dashboard and CMS"
        ].map { Card(content: $0, boardListID: backlogBoardList.id) }
        backlogBoardList.cards = backlogCards
        
        let todoBoardList = BoardList(name: "Todo", boardID: board.id)
        let todoCards = [
            "Error Handling",
            "Text Search"
        ].map { Card(content: $0, boardListID: todoBoardList.id) }
        todoBoardList.cards = todoCards
        
        let inProgressBoardList = BoardList(name: "In Progress", boardID: board.id)
        let inProgressCards = ["File Storage Service"].map { Card(content: $0, boardListID: inProgressBoardList.id) }
        inProgressBoardList.cards = inProgressCards
        
        let doneBoardList = BoardList(name: "Done", boardID: board.id)
        board.lists = [
            backlogBoardList,
            todoBoardList,
            inProgressBoardList,
            doneBoardList
        ]
        
        return board
    }
}
